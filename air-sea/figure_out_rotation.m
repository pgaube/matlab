test

thetas=180:25:360;
for m=1:length(thetas)
    [ubar,vbar]=pol2cart(deg2rad(thetas(m)),1);
    thet=rad2deg(cart2pol(ubar,vbar));
    
%     if thet<0
% 
%         thet=thet+180;
%         
%     end
    
    ndata=wgrid(double(lon), ...
        double(lat), ...
        double(25), ...
        double(25), ...
        double(qquad), ...
        double(-thet), ...
        double(100));
    
    %%%%now plot
    figure(1)
    clf
    subplot(221)
    compass(ubar,vbar);title(num2str(rad2deg(cart2pol(ubar,vbar))))
    subplot(223)
    pcolor(double(qquad));shading flat;axis image
    subplot(222)
    compass(ubar,vbar);title(thet)
    subplot(224)
    pcolor(ndata);shading flat;axis image;
    pause(7)
end