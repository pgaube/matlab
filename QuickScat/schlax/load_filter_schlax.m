home_dir='~/data/QuickScat/schlax/';
cd([home_dir '/averages'])
tmp=dir(['qscat_reyn*']);
load bwr.pal
load chelle.pal
for m=1:length(tmp)
    display(['file ',num2str(m),' of ',num2str(length(tmp))])
    fname=num2str(getfield(tmp,{m},'name'));
    jd=date2jd(str2num(fname(12:15)),str2num(fname(16:17)),str2num(fname(18:19)))+.5;
    eval(['!gunzip ',fname])
    fid=fopen(fname(1:19));
    xmin=str2num(fscanf(fid,'%s',1));
    xmax=str2num(fscanf(fid,'%s',1));
    ymin=str2num(fscanf(fid,'%s',1));
    ymax=str2num(fscanf(fid,'%s',1));
    nx=str2num(fscanf(fid,'%s',1));
    ny=str2num(fscanf(fid,'%s',1));
    dx_grid=str2num(fscanf(fid,'%s',1));
    dy_grid=str2num(fscanf(fid,'%s',1));
    
    strcrl_week=10^-7.*fscanf(fid,'%f',[nx ny])';
    strcrl_week(strcrl_week>1e20)=nan;
    taux_week=10^-7.*fscanf(fid,'%f',[nx ny])';
    taux_week(taux_week>1e20)=nan;
    tauy_week=10^-7.*fscanf(fid,'%f',[nx ny])';
    tauy_week(tauy_week>1e20)=nan;
    
    sm_u_week=fscanf(fid,'%f',[nx ny])';
    sm_u_week(sm_u_week>1e20)=nan;
    sm_v_week=fscanf(fid,'%f',[nx ny])';
    sm_v_week(sm_v_week>1e20)=nan;
    
    dtds_week=10^-5.*fscanf(fid,'%f',[nx ny])';
    dtds_week(dtds_week>1e20)=nan;
    
    hp66_wspd=fscanf(fid,'%f',[nx ny])';
    hp66_wspd(hp66_wspd>1e20)=nan;
    hp66_sst=fscanf(fid,'%f',[nx ny])';
    hp66_sst(hp66_sst>1e20)=nan;


    dtdx_week=10^-5.*fscanf(fid,'%f',[nx ny])';
    dtdx_week(dtdx_week>1e20)=nan;
    dtdy_week=10^-5.*fscanf(fid,'%f',[nx ny])';
    dtdy_week(dtdy_week>1e20)=nan;

    
    for j=1:ny
        lat(j)=ymin+dy_grid/2.+(j-1)*dy_grid;
    end
    for i=1:nx
        lon(i)=xmin+dx_grid/2.+(i-1)*dx_grid;
    end
    fclose(fid)
    eval(['!gzip ',fname(1:19)])

    eval(['save ',home_dir,'mat/schlax_',num2str(jd),' *_week lat lon hp66*'])
    
%     
%     %%%plot
%     figure(1)
%     clf
%     pmap(lon,lat,sqrt(sm_u_week.^2+sm_v_week.^2))
%     caxis([0 15])
%     colorbar
%     print -dpng -r300 sm_wspd
%     
%     clf
%     pmap(lon,lat,hp66_wspd)
%     caxis([-1 1])
%     colorbar
%     print -dpng -r300 hp66_wspd
%     
%     clf
%     pmap(lon,lat,hp66_sst)
%     caxis([-1 1])
%     colorbar
%     print -dpng -r300 hp66_sst
%     
%     [lon,lat]=meshgrid(lon,lat);
%     ff=f_cor(lat);
%     clf
%     pmap(lon,lat,60*60*24*100*strcrl_week./ff./1020)
%     caxis([-50 50])
%     colorbar
%     colormap(bwr)
%     print -dpng -r300 wek
%     
%     clf
%     pmap(lon,lat,1e5*sqrt(dtdx_week.^2+dtdy_week.^2))
%     caxis([0 1])
%     colorbar
%     print -dpng -r300 gradt
%     

    
end
cd(home_dir)
    