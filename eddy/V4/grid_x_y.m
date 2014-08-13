load global_tracks_V4.mat

gx=nan*x;
by=nan*y;

for m=1:length(x)
	tx=x(m);
	ty=y(m);
	tmpxs=floor(tx)-.125:.25:ceil(tx)+.125;
	tmpys=floor(ty)-.125:.25:ceil(ty)+.125;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    gx(m)=tmpxs(iminx(1));
    gy(m)=tmpys(iminy(1));
end

gy=gy';

clear tx ty tmpxs tmpys disx disy iminy iminx 
save global_tracks_V4.mat