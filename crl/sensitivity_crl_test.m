%
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

dred=[.01 .075 .1 .2 .3];
doff=[.5 .75 1];

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
[tmp_var,tmp_var_off_p5,tmp_var_off_p75,tmp_var_off_1,tmp_var_off_1p5,...
tmp_var_red_p01,tmp_var_red_p05,tmp_var_red_p1,tmp_var_red_p5,tmp_var_red_1,...
tmp_var_qs,tmp_var_ha]=deal(single(nan(length(r),length(c),length(jdays))));


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
	
	%half degree
	w = randi(4,2,1)-2;
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
   	y=(y-bp26_crl_sst+(0.2*sd*nR(rs,cs)).*mask(rs,cs));
   	tmp_var_off_p5(:,:,m)=single(y(rq,cq));
   	
   	%.75 degree
	w = randi(6,2,1)-3;
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
	one_y=y;
   	y=(y-bp26_crl_sst+(0.2*sd*nR(rs,cs)).*mask(rs,cs));
   	tmp_var_off_p75(:,:,m)=single(y(rq,cq));
	
	%1 degree
	w = randi(8,2,1)-4;
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
   	y=(y-bp26_crl_sst+(.2*sd*nR(rs,cs)).*mask(rs,cs));
   	tmp_var_off_1(:,:,m)=single(y(rq,cq));

	%.01 red
	y=(one_y-bp26_crl_sst+(dred(1)*sd*nR(rs,cs)).*mask(rs,cs));
	tmp_var_red_p01(:,:,m)=single(y(rq,cq));
	%.05 red
	y=(one_y-bp26_crl_sst+(dred(2)*sd*nR(rs,cs)).*mask(rs,cs));
	tmp_var_red_p05(:,:,m)=single(y(rq,cq));
	%.1 red
	y=(one_y-bp26_crl_sst+(dred(3)*sd*nR(rs,cs)).*mask(rs,cs));
	tmp_var_red_p1(:,:,m)=single(y(rq,cq));
	%.5 red
	y=(one_y-bp26_crl_sst+(dred(4)*sd*nR(rs,cs)).*mask(rs,cs));
	tmp_var_red_p5(:,:,m)=single(y(rq,cq));
	%1 red
	y=(one_y-bp26_crl_sst+(dred(5)*sd*nR(rs,cs)).*mask(rs,cs));
	tmp_var_red_1(:,:,m)=single(y(rq,cq));
	
    z=hp66_crl.*mask(rs,cs);
	x=hp66_crlg(rs,cs).*mask(rs,cs);;
   	tmp_var(:,:,m)=single(x(rq,cq));
   	tmp_var_qs(:,:,m)=single(z(rq,cq));
end     
%}
tbins=-1:.1:1;

kk=1;
fprintf('\n')
%half degree
y=1e5*tmp_var_off_p5(:);
x=1e5*tmp_var(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_off(kk)=Cor*sdY/sdX;
[dens,beta_o_off(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\sigma(x,y) = 0.5 ^\circ  ')
print -dpng -r300 figs/sensitive_sigma_.5
kk=kk+1;
%.75 degree
y=1e5*tmp_var_off_p75(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_off(kk)=Cor*sdY/sdX;
beta_o_off(kk)=ols_line(double(x),double(y),1);		
[dens,beta_o_off(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\sigma(x,y) = 0.75 ^\circ  ')
print -dpng -r300 figs/sensitive_sigma_1
kk=kk+1;
%1 degree
y=1e5*tmp_var_off_1(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_off(kk)=Cor*sdY/sdX;
beta_o_off(kk)=ols_line(double(x),double(y),1);		
[dens,beta_o_off(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\sigma(x,y) = 1 ^\circ  ')
print -dpng -r300 figs/sensitive_sigma_1.5

kk=1;
%.01 red
y=1e5*tmp_var_red_p01(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_red(kk)=Cor*sdY/sdX;
[dens,beta_o_red(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\alpha = 0.01')
print -dpng -r300 figs/sensitive_alpha_.01
kk=kk+1;
%.05 red
y=1e5*tmp_var_red_p05(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_red(kk)=Cor*sdY/sdX;
beta_o_red(kk)=ols_line(double(x),double(y),1);	
[dens,beta_o_red(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\alpha = 0.075')
print -dpng -r300 figs/sensitive_alpha_.075
kk=kk+1;
%.1 red
y=1e5*tmp_var_red_p1(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_red(kk)=Cor*sdY/sdX;
beta_o_red(kk)=ols_line(double(x),double(y),1);	
[dens,beta_o_red(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\alpha = 0.1')
print -dpng -r300 figs/sensitive_alpha_.1
kk=kk+1;
%.5 red
y=1e5*tmp_var_red_p5(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_red(kk)=Cor*sdY/sdX;
beta_o_red(kk)=ols_line(double(x),double(y),1);	
[dens,beta_o_red(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\alpha = 0.2')
print -dpng -r300 figs/sensitive_alpha_.2
kk=kk+1;
%1 red
y=1e5*tmp_var_red_1(:);
[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(x,y);
beta_n_red(kk)=Cor*sdY/sdX;
beta_o_red(kk)=ols_line(double(x),double(y),1);	
[dens,beta_o_red(kk),beta_bin,ci_bin]=pscatter(x,y,1,1,tbins,.25,-2,2,-2,2,'\nabla \times U_{g}','offset \nabla \times U_{g}');
figure(23)
title('\alpha = 0.3')
print -dpng -r300 figs/sensitive_alpha_.3

figure(10)
clf
plot(doff,beta_n_off)
hold on
plot(doff,beta_o_off,'g')
xlabel('\sigma_{(x,y)}')
ylabel('\beta_1')
title('offset')
print -dpng -r300 figs/sensitive_sigmas

figure(11)
clf
plot(dred,beta_n_red)
hold on
plot(dred,beta_o_red,'g')
xlabel('\alpha')
ylabel('\beta_1')
title('red noise')
print -dpng -r300 figs/sensitive_alphas
save sensitivity_crl_test beta_* dred doff