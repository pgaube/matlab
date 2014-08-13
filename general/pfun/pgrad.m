function [mag_grad,dfdx,dfdy]=pgrad(lon,lat,data);

sp=abs(lat(10,10)-lat(9,10));
r = 6371000;
C = 2*pi/360;
CR = C*r;
xdist = CR*cos(C*lat);

[M,N]=size(data);
dfdx=nan(M,N);
dfdy=nan(M,N);
mag_grad=nan(M,N);

for m=1:M
	for n=1:N
   	tdata= data(m,n);
  	dx   = xdist(m,n)*sp;
   	dy   = CR*sp; % y-distance b/w grid pt and obs pts
   
   	% Build matrix for the  regression of wind observations
   	% based on distance (dx,dy) from the grid point

  	xin(:,1) = 1;
   	xin(:,2) = dx;
   	xin(:,3) = dy;
                          
   	% Decompose xin using QR decomposition to use for 
   	% least-squares regression.  

   	[Q, R] = qr( xin, 0 );

   	% Use the Q and R matrices to perform inversions
   	% for each wind data type
                          
  	Q = Q';
   	bdata = R \ ( Q*( tdata ) );
         
   	dfdx(m,n)                	= bdata(2);
   	dfdy(m,n)     				= bdata(3);
   	mag_grad(m,n)				= sqrt(dfdx(m,n).^2+dfdy(m,n).^2);
	end
end
