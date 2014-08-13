clear all
SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';
RAND_HEAD   = 'RAND_W_';
RAND_PATH   = '/matlab/data/rand/';
Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';

%Set range of dates
START_YR = 2002;
START_MO = 07;
START_DY = 03;
END_YR= 2008;
END_MO = 01;
END_DY = 23;



%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;
jdays=jdays(1):7:jdays(40);

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
[tmp_var,tmp_var_na,tmp_var_qs]=deal(single(nan(length(r),length(c),length(jdays))));



for m=1:length(jdays)
    %fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
	% Set up file names
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	r_file = [RAND_PATH RAND_HEAD  num2str(jdays(m))];
	q_file = [Q_PATH Q_HEAD  num2str(jdays(m))];
	
	
	% load files
	load(ssh_file,'bp26_crlg','ls_mask','ls_half_mask','mask')
	load(r_file,'na_crlg')
	load(q_file,'bp26_crl','hp_wek_sst_week_dtdn')
   	mask=ls_mask;
   	%mask=ls_half_mask;
	
	%{

	figure(1)
   	clf
   	subplot(311)
   	pmap(lon(r,c),lat(r,c),bp26_crlg(r,c))
   	ran=caxis;
   	title('crlg')
   	
   	subplot(312)
   	pmap(lon(r,c),lat(r,c),na_crlg(r,c))
   	caxis(ran)
   	title('crlg+R+crl-sst')
   	
   	subplot(313)
   	pmap(qlon(rq,cq),qlat(rq,cq),-bp26_crl(rq,cq))
   	caxis(ran)
   	title('-crl')
   	
   	
   	drawnow
    %pause(3)
   	%}
   	
   	%mask=ones(size(mask));;

   	bp26_crlg=bp26_crlg.*mask;
   	na_crlg=na_crlg.*mask;
	bp26_crl=bp26_crl.*mask(rs,cs);
	hp_wek_sst_week_dtdn=hp_wek_sst_week_dtdn.*mask(rs,cs);
   	crstd=pstd(bp26_crlg(r,c));
   	
   	tmp_var(:,:,m)=single(bp26_crlg(r,c));
   	tmp_var_na(:,:,m)=single(na_crlg(r,c));
   	tmp_var_qs(:,:,m)=single(bp26_crl(rq,cq));
end     

tbins=[-1:.1:1];

kk=1;
fprintf('\n')
	z=-1e5*tmp_var_qs(:);
	y=1e5*tmp_var_na(:);
	x=1e5*tmp_var(:);

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
	[Corz(kk),Covar,N,Sig,Xbar,Ybar,sdXz(kk),sdYz(kk)]=pcor(x,y);
	beta_n_z(kk)=Corz(kk)*sdYz(kk)/sdXz(kk);
	%[y_lin,b]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
	%[y_lin,b]=reg(x,y,'lin');	
	%beta_n_reg(kk)=b(2);
	[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(tbins(1:length(tbins)-1),binned_samps2);
	beta_b(kk)=xor*sdy/sdx;
	[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(tbins(1:length(tbins)-1),binned_samps3);
	beta_b_z(kk)=xor*sdy/sdx;
	%beta_b_reg(kk)=b(2);
	pcoupco(x,y,1,tbins,.25,-2,2,-2,2,'-\nabla \times U_{g}','\nabla \times U_{rel}')
	hold on
	errorbar(tbins(1:end-1),binned_samps3,std_samps3)
	



return
figure(2)
clf
plot(alf,beta_n);
hold on
scatter(alf,beta_n,'b.')

title(' slope of least-squares fit of e to x [e = x+(d*r*sd_x)]')
ylabel('a')
xlabel('d')
niceplot

figure(3)
clf
plot(sdY./sdX,Cor);
hold on
scatter(sdY./sdX,Cor,'b.')

title(' Cross-correlation plotted as a function of \sigma(y)/\sigma(x)   ')
ylabel('\rho(x,y)')
xlabel('\sigma(y)/\sigma(x)')
niceplot





