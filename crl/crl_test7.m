clear all
SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';
RAND_HEAD   = 'RAND_W_';
RAND_PATH   = '/matlab/data/rand/';
Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';
U_HEAD   = 'UPD_25_W_';
U_PATH   = '/matlab/data/UPD/mat/';

%Set range of dates
startyear = 2002;
startmonth = 10;
startday = 02;

endyear = 2005;
endmonth = 09;
endday = 28;



%construct date variables
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
j%days=jdays(1):7:jdays(40);

load /matlab/matlab/domains/air-sea_eio_lat_lon
llat=lat;
llon=lon;
load /matlab/data/QuickScat/mat/QSCAT_30_25km_2454776.mat lat lon
qlat=lat;
qlon=lon;
load /matlab/data/eddy/V4/mat/AVISO_25_W_2454776.mat lat lon ssh


 
[r1,c]=imap(-45,-15,0,360,lat,lon);
[r2,c]=imap(15,45,0,360,lat,lon);
r=cat(1,r1,r2);

[r1,cq]=imap(-45,-15,0,360,qlat,qlon);
[r2,cq]=imap(15,45,0,360,qlat,qlon);
rq=cat(1,r1,r2);

[rl,cl]=imap(-45,-15,80,130,lat,lon);
[rlq,clq]=imap(-45,-15,80,130,qlat,qlon);
[rs,cs]=imap(min(qlat(:)),max(qlat(:)),min(qlon(:)),max(qlon(:)),lat,lon);

[r,c]=imap(min(llat)-0,max(llat)+0,min(llon)-0,max(llon)+0,lat,lon);
[rq,cq]=imap(min(llat)-0,max(llat)+0,min(llon)-0,max(llon)+0,qlat,qlon);
% initalize
[tmp_var,tmp_var_na,tmp_var_qs,tmp_var_ha]=deal(single(nan(length(r),length(c),length(jdays))));

a=0;
b=5;
aa=-1;
bb=1;

for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
	% Set up file names
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	r_file = [RAND_PATH RAND_HEAD  num2str(jdays(m))];
	q_file = [Q_PATH Q_HEAD  num2str(jdays(m))];
	u_file = [U_PATH U_HEAD  num2str(jdays(m))];
	
	
	% load files
	load(u_file,'hp66_crlg','half_ls_10_cm_mask')
	ucrl=hp66_crlg;
	umask=half_ls_10_cm_mask;
	load(ssh_file,'hp66_crlg','half_ls_10_cm_mask')
	load(q_file,'hp66_crl')
   	mask=half_ls_10_cm_mask;
   	
	
	
   	g=hp66_crlg(rs,cs).*mask(rs,cs);
   	u=ucrl(rs,cs).*umask(rs,cs);
   	tmp_var(:,:,m)=single(g(rq,cq));
   	tmp_var_na(:,:,m)=single(u(rq,cq));
   	tmp_var_qs(:,:,m)=single(hp66_crl(rq,cq));
end     

tbins=[-.7:.1:.7];

kk=1;
fprintf('\n')
	y=1e5*tmp_var_na(:);
	x=1e5*tmp_var(:);
	z=-1e5*tmp_var_qs(:);

	clear binned_samps2 num_samps2 binned_samps3 num_samps3
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = (pmean(y(bin_est)));
			binned_samps3(i) = (pmean(z(bin_est)));
			num_samps2(i) = length(y(bin_est));
			num_samps3(i) = length(z(bin_est));
			std_samps3(i) = pstd(z(bin_est));
		end
		
	[Cor(kk),Covar,N,Sig,Xbar,Ybar,sdX(kk),sdY(kk)]=pcor(x,y);
	beta_n(kk)=Cor(kk)*sdY(kk)/sdX(kk);
	[Corz(kk),Covar,N,Sig,Xbar,Ybar,sdXz(kk),sdYz(kk)]=pcor(x,z);
	beta_n_z(kk)=Corz(kk)*sdYz(kk)/sdXz(kk);
	%[y_lin,b]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
	%[y_lin,b]=reg(x,y,'lin');	
	%beta_n_reg(kk)=b(2);
	[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(tbins(1:length(tbins)-1),binned_samps2);
	beta_b(kk)=xor*sdy/sdx;
	[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(tbins(1:length(tbins)-1),binned_samps3);
	beta_b_z(kk)=xor*sdy/sdx;

[dens,beta_ols,beta_bin,ci_bin]=pscatter(x,z,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','- \nabla \times U_{rel}');
figure(23)
hold on
print -dpng -r300 figs/crl_eio_crlg_half_pscatter_1_percent
figure(22)
print -dpng -r300 figs/crl_eio_crlg_half_pscatter

[densz,beta_olsz,beta_binz,ci_binz]=pscatter(y,z,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g} UPD','- \nabla \times U_{rel}');
figure(23)
print -dpng -r300 figs/crl_eio_upd_half_pscatter_1_percent
figure(22)
print -dpng -r300 figs/crl_eio_upd_half_pscatter