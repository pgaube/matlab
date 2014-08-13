clear all
spath='~/matlab/pop/mat/run33_';
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];


load ~/data/gsm/cor_chl_ssh_out.mat lon lat
glon=lon;
glat=lat;
load ~/matlab/pop/mat/pop_model_domain.mat lat lon mask1 buff_mask

[rg,cg]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
glat=glat(rg,cg);
glon=glon(rg,cg);

for m=17:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'total_chl')
        
        data=total_chl.*buff_mask;
        
%             figure(1)
%             clf
%             pmap(lon,lat,data);
%             title(num2str(m))
% %             caxis([-.1 .1])
%             drawnow
        

        ttt=griddata(lon,lat,data,glon,glat,'linear');
        
        %%smooth
        tic
        lp=smooth2d_loess(ttt,glon(1,:),glat(:,1),6,6,glon(1,:),glat(:,1));
        toc
        
        %%grid 2
        lph=griddata(glon,glat,lp,lon,lat,'linear');
        
        hp66_chl=data-lph;

%             figure(2)
%             clf
%             pmap(lon,lat,hp66_chl);
%             title(num2str(m))
%             caxis([-.1 .1])
%             drawnow

        eval(['save -append mat/run33_',num2str(pdays(m)),' hp66_chl'])
        clear hp66* data
    end
end
    
    
    
