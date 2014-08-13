clear all
%
ff=1;
minlat=-45;
maxlat=45;
minlon=0;
maxlon=360;

% % % Now track eddies in model
spath='/Volumes/ys-home/mat/POP_BEC_JAN_15_2014_';
% spath='/glade/u/home/pgaube/mat/POP_BEC_JAN_15_2014_';

pdays=[1:5:386];


% now load pop SSH data
load /Volumes/ys-home/mat/buff_mask_0_pt_25_degree
% load /glade/u/home/pgaube/mat/buff_mask_0_pt_25_degree

[rp,cp]=imap(minlat,maxlat,minlon,maxlon,tlat,tlon);
plat=tlat(rp,cp);
plon=tlon(rp,cp);

for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'hp66_chl','hp66_ssh')
        
        figure(1)
        clf
        set(gcf,'PaperPosition',[1 1 7 3])
        pmap(plon,plat,hp66_chl(rp,cp));
        title('Surface CHL from eddy-resolving POP-BEC Simulation')
        caxis([-.3 .3])
        eval(['print -dpng -r300 frames/hp66_chl/frame_',num2str(ff)])
        
        figure(2)
        clf
        set(gcf,'PaperPosition',[1 1 7 3])
        pmap(plon,plat,hp66_ssh(rp,cp));
        title('SLA from eddy-resolving POP-BEC Simulation')
        caxis([-40 40])
        eval(['print -dpng -r300 frames/hp66_ssh/frame_',num2str(ff)])
        ff=ff+1;
        return
    end
end
%
%
