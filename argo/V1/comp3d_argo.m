clear all
load /Volumes/matlab/matlab/argo/SOUTH_anom_prof

ai=find(tid>=nneg);
ci=find(tid<nneg);

x=[-2:.1:2];
y=x';
z=z_prime;
[X,Y,Z]=meshgrid(x,y,z);
rspan=.3;
zspan=50;


comp3_a=nan(size(X));
comp3_c=nan(size(X));

ai=find(tid>=nneg);
ci=find(tid<nneg);

tT_a=stT(ai,:);
tT_c=stT(ci,:);
txa=tx(ai);
txc=tx(ci);
tya=ty(ai);
tyc=ty(ci);
tlata=tlat(ai);
tlona=tlon(ai);
tefolda=tefold(ai);
tlatc=tlat(ci);
tlonc=tlon(ci);
tefoldc=tefold(ci);
tida=tid(ai);
tidc=tid(ci);

dist_xa = ((txa-tlona).*(111.1*cosd(tya)))./tefolda;
dist_ya = ((tya-tlata).*111.1)./tefolda;
dist_xc = ((txc-tlonc).*(111.1*cosd(tyc)))./tefoldc;
dist_yc = ((tyc-tlatc).*111.1)./tefoldc;


%{
ppp=1;
qqq=1;
for m=1:length(tida)
	dist_x = ((txa(m)-tlona(m)).*(111.1*cosd(tya(m))))./tefolda(m);
	dist_y = ((tya(m)-tlata(m)).*111.1)./tefolda(m);
	tmpxs=floor(dist_x)-1:.1:ceil(dist_x)+1;
	tmpys=floor(dist_y)-1:.1:ceil(dist_y)+1;
    disx = abs(tmpxs-dist_x);
    disy = abs(tmpys-dist_y);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cxa(m)=tmpxs(iminx(1));
    cya(m)=tmpys(iminy(1));   
end

for m=1:length(tidc)
	dist_x = ((txc(m)-tlonc(m)).*(111.1*cosd(tyc(m))))./tefoldc(m);
	dist_y = ((tyc(m)-tlatc(m)).*111.1)./tefoldc(m);
	tmpxs=floor(dist_x)-1:.1:ceil(dist_x)+1;
	tmpys=floor(dist_y)-1:.1:ceil(dist_y)+1;
    disx = abs(tmpxs-dist_x);
    disy = abs(tmpys-dist_y);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cxc(m)=tmpxs(iminx(1));
    cyc(m)=tmpys(iminy(1));   
end
%}




%now use loess to grid into 3d composite
nregs=1;
rspan2=rspan^2;

for p=1:length(z_prime(1:61))
	for m=1:length(x)
		for n=1:length(y)
			
			inonan	=	find(~isnan(tT_a(:,p)));
			tmp_dx	=	dist_xa(inonan)-X(m,n,p);
			tmp_dy	=	dist_ya(inonan)-Y(m,n,p);
			tmp_dz	=	z_prime-Z(m,n,p);
			tmp_dat	=	tT_a(inonan,p);
			
			igood=find(abs(tmp_dx)<=rspan & abs(tmp_dy)<=rspan);

				if any(igood) & length(igood)>=10 
					dx	=	tmp_dx(igood)';
					dy	=	tmp_dy(igood)';
					dx2	=	dx.^2;
					dy2	=	dy.^2;
					d2	=	dx2+dy2;
					dat	=	tmp_dat(igood);
										
					w = 1 - (d2/rspan2).*sqrt(d2/rspan2);
                    w = w.*w.*w;
                    
                    xin = repmat(w,[1 6]);
          			xin(:,2) = xin(:,2).*dx;
           			xin(:,3) = xin(:,3).*dy;
           			xin(:,4) = xin(:,2).*dx;
           			xin(:,5) = xin(:,3).*dy;
           			xin(:,6) = xin(:,2).*dy;
           			
           			B = xin \ (w.*dat);
           			if B(1) > min(dat) & B(1) < max(dat) 
           				comp3_a(m,n,p) = B(1);
           			else
           				comp3_a(m,n,p) = nan;
           			end
           			           			
					clear B w xin
            end                       
        end
    end    
end			

for p=1:60
surf(X(:,:,p),Y(:,:,p),-Z(:,:,p),comp3_a(:,:,p));shading flat;axis equal
hold on
caxis([-3 3])
daspect([1 1 50])
drawnow
end




	