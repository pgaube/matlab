function yout = filter_fft2d(data,dt,dx)

y=fillnans(data);

N=length(y(:,1));
M=N;
n=[0:N-1];
if rem(N,2)==0
	m=[-(M/2):(M/2-1)];
else
	m=[-((M-1)/2):((M-1)/2)];
end
tn=n.*dt; %Obs times
f=m./(M*dt); %Fourier Freq



B=length(y(1,:));
D=B;
b=[0:B-1];
if rem(B,2)==0
	d=[-(D/2):(D/2-1)];
else
	d=[-((D-1)/2):((D-1)/2)];
end
tb=b.*dx; %Obs locs
k=d./(D*dx); %Fourier wave numbers

%preform fft,center on zero
Y=fft2(y)./((N*dt)*(B*dx));
Y = fftshift(Y);
[k,f]=meshgrid(k,f);
k=fliplr(k);


%mask
mask=zeros(size(Y));
ii=find(k>-1/200 & k<-1/1000 & f>1/410 & f<1/37);
mask(ii)=1;


inmask=flipud(fliplr(mask));
mask(inmask==1)=1;




Y=mask.*Y;
Y = ifftshift(Y);
yout = ifft2(Y).*((N*dt)*(B*dx));
%yout = ifft2(Y,'symmetric').*((N*dt)*(B*dx));