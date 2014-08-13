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


alf=[0 .5 1 2 10 20 100]
%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;
jdays=jdays(1):7:jdays(40);

load /matlab/data/QuickScat/mat/QSCAT_30_25km_2454776.mat lat lon
qlat=lat;
qlon=lon;
load /matlab/data/eddy/V4/mat/AVISO_25_W_2454776.mat lat lon ssh

[r1,c]=imap(-45,-15,0,360,lat,lon);
[r2,c]=imap(15,45,0,360,lat,lon);

r=cat(1,r1,r2);

[rl,cl]=imap(-45,-15,80,130,lat,lon);
[rq,cq]=imap(-45,-15,80,130,qlat,qlon);
r=rl;
c=cl;
% initalize
[tmp_var,tmp_var1,tmp_var2,tmp_var3,tmp_var4,tmp_var5,tmp_var6,tmp_var7,tmp_var8,tmp_var9,tmp_var10,tmp_var11] ...
=deal(single(nan(length(lat(r,1)),length(lon(1,c)),length(jdays))));



for m=1:length(jdays)
    %fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
	% Set up file names
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	r_file = [RAND_PATH RAND_HEAD  num2str(jdays(m))];
	q_file = [Q_PATH Q_HEAD  num2str(jdays(m))];
	
	
	% load files
	load(ssh_file,'hp66_crlg','ls_mask','mask')
	load(r_file,'nR')
	load(q_file,'hp66_crl')
   	mask=ls_mask;
	
	%{
	tt=hp66_crlg.*mask;
   	crstd=pstd(tt(r,c));
	figure(1)
   	clf
   	subplot(221)
   	pmap(lon(rl,cl),lat(rl,cl),hp66_crlg(rl,cl))
   	ran=caxis;
   	title('crlg')
   	
   	subplot(222)
   	pmap(lon(rl,cl),lat(rl,cl),(hp66_crlg(rl,cl)-(nR(rl,cl) .* crstd)))
   	caxis(ran)
   	title('crlg+R')
   	
   	subplot(223)
   	pmap(qlon(rq,cq),qlat(rq,cq),-hp66_crl(rq,cq))
   	caxis(ran)
   	title('-crl')
   	
   	subplot(224)
   	pmap(lon(rl,cl),lat(rl,cl),nR(rl,cl) .* crstd)
   	caxis(ran)
   	title('R')
   	drawnow
    %pause(3)
   	%}
   	
   	%mask=1;
	nR=nR.*mask;
   	hp66_crlg=hp66_crlg.*mask;
   	crstd=pstd(hp66_crlg(r,c));
   	
   	tmp_var(:,:,m)=single(hp66_crlg(r,c));
   	for kk=1:length(alf)
	   	eval(['tmp_var',num2str(kk),'(:,:,m)=single(hp66_crlg(r,c) +(alf(',num2str(kk),') .*(nR(r,c) .* crstd)));']);
   	end
end     

tbins=[-2:.1:2];

fprintf('\n')
for kk=1:length(alf)
	eval(['y=tmp_var',num2str(kk),';'])
	x=tmp_var;
	x=1e5*x(:);
	y=1e5*y(:);
	clear binned_samps2 num_samps2
		for i=1:length(tbins)-1
			bin_est = find(x>=tbins(i) & x<tbins(i+1));
			%binned_samps1(i) = double(pmean(x(bin_est)));
			binned_samps2(i) = (pmean(y(bin_est)));
			num_samps2(i) = length(y(bin_est));
		end
		
	[Cor(kk),Covar,N,Sig,Xbar,Ybar,sdX(kk),sdY(kk)]=pcor(x,y);
	beta_n(kk)=Cor(kk)*sdY(kk)/sdX(kk);
	%[y_lin,b]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
	%[y_lin,b]=reg(x,y,'lin');	
	%beta_n_reg(kk)=b(2);
	[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(tbins(1:length(tbins)-1),binned_samps2);
	beta_b(kk)=xor*sdy/sdx;
	%beta_b_reg(kk)=b(2);
	%pcoupco(x,y,1,-1:.1:1,.25,-2,2,-2,2,'-\nabla \times U_{g}','\nabla \times U_{rel}')
	
end


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





