load gline_6_hov
%lp=smooth2d_loess(chov,clon,cjdays,10,60,clon,cjdays);
%fn=chov-lp;
y=fillnans(thov);
dt=7;
dx=25;


zf=length(y(:,1));
zk=length(y(1,:));



N=length(y(:,1));
M=N;
n=[0:N-1];
m=linspace(-(M/2),(M/2-1),zf);
mm=[-(M/2):(M/2-1)];
tn=n.*dt; %Obs times
f=m./(M*dt); %Fourier Freq
ff=mm./(M*dt); %Fourier Freq

B=length(y(1,:));
D=B;
b=[0:B-1];
d=linspace(-(D/2),(D/2-1),zk);
dd=[-(D/2):(D/2-1)];
tb=b.*dx; %Obs locs
k=d./(D*dx); %Fourier wave numbers
kk=dd./(D*dx);

k=fliplr(k);
[k,f]=meshgrid(k,f);
[kk,ff]=meshgrid(kk,ff);


%window and remove mean

mu=pmean(y(:));
va=pvar(y(:));
tap = (1 - ((2.*abs(mm))./N))'*(1 - ((2.*abs(dd))./B)); %triangle window
%tap = sin(kk/2).*sin(ff/2);
yn=(y-mu).*tap;
vn=pvar(yn);


%preform fft,center on zero and calculate sample PSD
Y=fft2(yn,zf,zk);
s = real(Y.*conj(Y)).*(1/N)*dt.*(1/B)*dx;
s = s.*(va/vn);
%s = s/(size(s, 1)*size(s, 2));
S = fftshift(s);

xlim=[-4 .2];
ylim=[0 .015];
figure(2)
%pcolor(1e3*k,f,log10(S));shading interp
pcolor(1e3*k,f,smoothn(log10(S),1));shading interp
caxis([2 6.5])
set(gca,'xlim',xlim,'ylim',ylim)
return

%Windows
%Rectangular
rwindow = ones(N,N);
runwindow = 1./rwindow;
%
%Triangle Window
twindow = ones(N,N)-abs(1-xx/pi).*abs(1-yy/pi);
tunwindow = 1./twindow;
%
%Hamming Window
hwindow = sin(xx/2).*sin(yy/2);
hunwindow = 1./hwindow;
%
zz =    cos(xx*k0(1)+yy*l0(1));
zz = zz+cos(xx*k0(2)+yy*l0(2));
zz = zz+sin(xx*k0(3)+yy*l0(3));
zz = zz+sin(xx*k0(4)+yy*l0(4));
tzz = zz.*twindow;
hzz = zz.*hwindow;
fz = fftshift(fft2(zz));
ftz = fftshift(fft2(tzz));
fhz = fftshift(fft2(hzz));
mfz = log(abs(fz));
mftz = log(abs(ftz));
mfhz = log(abs(fhz));
Ffz = mask.*fz;
Fftz = mask.*ftz;
Ffhz = mask.*fhz;
mFfz = log(abs(Ffz));
mFftz = log(abs(Fftz));
mFfhz = log(abs(Ffhz));
iFfz = real(ifft2(fftshift(Ffz)));
iFftz = tunwindow.*real(ifft2(fftshift(Fftz)));
iFfhz = hunwindow.*real(ifft2(fftshift(Ffhz)));
%
% Draw 
% 
% input function | input power spectra
% --------------------------------------------
% filter output  |  filter power spectra
%
figure(1)
subplot(2,2,1)
pcolor(xx/pi,yy/pi,zz);
shading flat
title('f(x,y)')
axis('square')
grid('on')
colorbar
subplot(2,2,2)
pcolor(kk,ll,mfz);
shading flat
axis('square')
grid('on')
title('log|f(k,l)|')
caxis(max(max(mfz))*CB)
colorbar
subplot(2,2,3)
pcolor(xx/pi,yy/pi,iFfz);
shading flat
title('filtered f(x,y)')
axis('square')
grid('on')
caxis(sqrt(mean(mean(iFfz.*iFfz)))*[-1 1])
colorbar
subplot(2,2,4)
pcolor(kk,ll,mFfz);
shading flat
title('log|filtered f(k,l)|')
axis('square')
grid('on')
caxis(max(max(abs(mfz)))*CB)
colorbar
print('rectangle.png','-dpng','-S1024,768')
%
% Draw 
% Triangle Filter
% input function | input power spectra
% --------------------------------------------
% filter output  |  filter power spectra
%
figure(2)
subplot(2,2,1)
pcolor(xx/pi,yy/pi,zz);
shading flat
title('f(x,y)')
axis('square')
grid('on')
colorbar
subplot(2,2,2)
pcolor(kk,ll,mftz);
shading flat
axis('square')
grid('on')
title('log|f(k,l)|')
caxis(max(max(abs(mfz)))*CB)
colorbar
subplot(2,2,3)
pcolor(xx/pi,yy/pi,iFftz);
shading flat
title('filtered f(x,y)')
axis('square')
grid('on')
caxis(sqrt(mean(mean(iFftz.*iFftz)))*[-1 1])
colorbar
subplot(2,2,4)
pcolor(kk,ll,mFftz);
shading flat
title('log|filtered f(k,l)|')
caxis(max(max(abs(mfz)))*CB)
axis('square')
grid('on')
colorbar
print('triangle.png','-dpng','-S1024,768')
%
% Draw 
% Hamming window
% input function | input power spectra
% --------------------------------------------
% filter output  |  filter power spectra
%
figure(3)
subplot(2,2,1)
pcolor(xx/pi,yy/pi,zz);
shading flat
title('f(x,y)')
axis('square')
grid('on')
colorbar
subplot(2,2,2)
pcolor(kk,ll,mfhz);
shading flat
axis('square')
grid('on')
title('log|f(k,l)|')
caxis(max(max(abs(mfz)))*CB)
colorbar
subplot(2,2,3)
pcolor(xx/pi,yy/pi,iFfhz);
shading flat
title('filtered f(x,y)')
axis('square')
grid('on')
caxis(sqrt(mean(mean(iFfhz.*iFfhz)))*[-1 1])
colorbar
subplot(2,2,4)
pcolor(kk,ll,mFfhz);
shading flat
title('log|filtered f(k,l)|')
caxis(max(max(abs(mfz)))*CB)
axis('square')
grid('on')
%caxis(max(max(mFfhz))*CB)
colorbar
print('hamming.png','-dpng','-S1024,768')
%figure()
%close all
