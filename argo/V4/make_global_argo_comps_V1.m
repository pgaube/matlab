load global_4deg_grid

olap = 8; %half span of overlap in deg
min_num_profs = 1200; %minimum number of profs with 2Ls to make comps
load ~/matlab/argo/v3/eddy_argo_prof_index_v5_fast eddy_x eddy_y eddy_dist_ext_x eddy_dist_ext_y

eddy_dist=sqrt(eddy_dist_ext_x.^2+eddy_dist_ext_y.^2);

for m=3106:length(mlat(:))
    
    %figure out lat/lon bounds
    clat=mlat(m);
    clon=mlon(m);
    [r,c]=imap(mlat(m)-olap,mlat(m)+olap,mlon(m)-olap,mlon(m)+olap,mlat,mlon);
    tt=mlat(r,c);minlat=min(tt(:));
    tt=mlat(r,c);maxlat=max(tt(:));
    tt=mlon(r,c);minlon=min(tt(:));
    tt=mlon(r,c);maxlon=max(tt(:));
    
    figure(100)
    clf
    pmap(mlon,mlat,mask)
    hold on
    m_plot(clon,clat,'k.','markersize',50)
    draw_domain(mlon(r,c),mlat(r,c))
    drawnow
    if ~isnan(mask(m))
        ii=find(eddy_x>=minlon & eddy_x<=maxlon & eddy_y>=minlat & eddy_y<=maxlat & eddy_dist<=2);
        if length(ii)>min_num_profs
            outname=['global_comps/output/global_4deg_',num2str(m)];
            argo_radial_comp_box(minlat,maxlat,minlon,maxlon,outname);
            if exist([outname,'_argo_comp.mat'])
                plot_rad_comps([outname,'_argo_comp.mat'],['global_comps/figs/box_',num2str(m)])
            end
        end
    end
end
