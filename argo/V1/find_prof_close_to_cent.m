clear all
load norm_prof_to_centroid

i_01=find(abs_dist<=.1);

good_id=loc_id(i_01);
good_pfile=loc_pfile(i_01);
good_jday=loc_jday(i_01);
good_loc=loc(i_01,:);
good_x=loc_x(i_01);
good_y=loc_y(i_01);

for m=1:length(i_01)
	load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(good_jday(m))])
	tx=good_x(m);
	ty=good_y(m);
	tmpxs=floor(tx)-1:.25:ceil(tx)+1;
	tmpys=floor(ty)-1:.25:ceil(ty)+1;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(lat(:,1)>=cy-2 & lat(:,1)<=cy+2); %added this because FUCKING MATLAB has some sort of inharent rounding error!
    c=find(lon(1,:)>=cx-2 & lon(1,:)<=cx+2);
    good_ssh(:,:,m)=ssh(r,c);
    figure(1)
    clf
    pcolor(lon(r,c),lat(r,c),double(ssh(r,c)));shading flat
    hold on
    plot(tx,ty,'k*')
    drawnow
    hold off
end    
    
