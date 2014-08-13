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
jdays=jdays(1):7:jdays(80);

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


for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
	% Set up file names
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	r_file = [RAND_PATH RAND_HEAD  num2str(jdays(m))];
	q_file = [Q_PATH Q_HEAD  num2str(jdays(m))];
	
	
	% load files
	load(ssh_file,'hp66_crlg','ls_mask','ls_half_mask','mask')
	load(q_file,'hp66_crl','bp26_crl_sst')
   	load(r_file,'nR')
   	mask=ls_mask;
   	%mask=ls_half_mask;
	
	%{

	figure(1)
   	clf
   	subplot(311)
   	pmap(lon(r,c),lat(r,c),hp66_crlg(r,c))
   	ran=caxis;
   	title('crlg')
   	
   	subplot(312)
   	pmap(lon(r,c),lat(r,c),na_crlg(r,c))
   	caxis(ran)
   	title('crlg+R+crl-sst')
   	
   	subplot(313)
   	pmap(qlon(rq,cq),qlat(rq,cq),-hp66_crl(rq,cq))
   	caxis(ran)
   	title('-crl')
   	
   	
   	drawnow
    %pause(3)
   	%}
   	
   	%mask=ones(size(mask));;

   	g=hp66_crlg(rs,cs);
   	sd=pstd(g);
   	a=-2.4;
   	b=2.4;
   	w= round(sum(a + (b-a).*rand(3,2)));
	y=nan*g;
	if w(1)>0 & w(2)>0
		y(w(1):end,w(2):end)=g(1:end-w(1)+1,1:end-w(2)+1);
	elseif w(1)>0 & w(2)<0	
		y(w(1):end,1:end+w(2))=g(1:end-w(1)+1,-w(2)+1:end);
	elseif w(1)<0 & w(2)<0
		y(1:end+w(1),1:end+w(2))=g(-w(1)+1:end,-w(2)+1:end);
	elseif w(1)<0 & w(2)>0
		y(1:end+w(1),w(2):end)=g(-w(1)+1:end,1:end-w(2)+1);
	elseif w(1)==0 & w(2)>0
		y(1:end,w(2):end)=g(1:end,1:end-w(2)+1);
	elseif w(1)==0 & w(2)<0
		y(1:end,1:end+w(2))=g(1:end,-w(2)+1:end);	
	elseif w(1)<0 & w(2)==0
		y(1:end+w(1),1:end)=g(-w(1)+1:end,1:end);
	elseif w(1)>0 & w(2)==0
		y(w(1):end,1:end)=g(1:end-w(1)+1,1:end);	
	else
		y=g;
	end	
   	y=(y+0.1*sd*nR(rs,cs)).*mask(rs,cs);
	%{
	figure(1)
	clf
	pcolor(qlon(rq,cq),qlat(rq,cq),double(1e5*y(rq,cq)));shading flat
	return
    %}
    z=hp66_crl.*mask(rs,cs);
	x=hp66_crlg(rs,cs).*mask(rs,cs);;
   	tmp_var(:,:,m)=single(x(rq,cq));
   	tmp_var_na(:,:,m)=single(y(rq,cq));
   	tmp_var_qs(:,:,m)=single(z(rq,cq));
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
	%beta_b_reg(kk)=b(2);
	pcoupco(x,y,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}')
	figure(23)
	hold on
	errorbar(tbins(1:end-1),binned_samps3,std_samps3,'b.')
	
	






[dens,beta_ols,beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
return
figure(23)
hold on
errorbar(tbins(1:end-1),binned_samps3,std_samps3,'b.')
print -dpng -r300 figs/offset_car_crlg_pscatter_1_percent
figure(22)
print -dpng -r300 figs/offset_car_crlg_pscatter


[densz,beta_olsz,beta_binz,ci_binz]=pscatter(x,z,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','- \nabla \times U_{rel}');
figure(23)
print -dpng -r300 figs/crl_eio_crlg_pscatter_1_percent
figure(22)
print -dpng -r300 figs/crl_eio_crlg_pscatter