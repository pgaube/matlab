clear all
close all

load argo_profile_index.mat pjday plat plon pfile
head   = 'AVISO_25_W_';
loadpath   = '/matlab/data/eddy/V5/mat/';
eddy_files = '/matlab/data/eddy/V5/global_tracks_V5_12_weeks'
load(eddy_file,'track_jdays')
startjd=min(track_jday); 
endjd=max(track_jday);
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd+3);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);
pfile=pfile(tt);


tt=find(jdays>=min(pjday)&jdays<=max(pjday));
jdays=jdays(tt);
[eddy_cyc,eddy_dist_x,eddy_dist_y,eddy_id,eddy_pjday,eddy_scale,eddy_x,eddy_y,...
eddy_pjday_round,eddy_plat,eddy_plon,eddy_eid,eddy_k,eddy_amp,eddy_axial_speed,...
eddy_ext_x,eddy_ext_y,eddy_ssh,eddy_dist_ext_x,eddy_dist_ext_y,eddy_enclosed]=deal(nan(length(plat),1));
eddy_pfile=cell(length(plat),1);

in_eddy=0;
load(eddy_file)
load([loadpath,head,num2str(jdays(10))],'lon','lat')
%
pp=1;
%now go through each float and find out if it is in an eddy
%
progressbar('Checking Float')
lap=length(pjday);

total_number_of_float=lap
n=1;

for m=n:length(jdays)
    progressbar(m/length(jdays))
    [ye,mo,da]=jd2jdate(jdays(m));
    display([num2str(ye) '-' num2str(mo) '-' num2str(da)])
    jdii=find(pjday>=jdays(m)-3 & pjday<=jdays(m)+3);
    kk=find(track_jday==jdays(m));
    if any(jdii)
        load([loadpath,head,num2str(jdays(m))],'idmask','ssh')
        %from Argo
        tplon=plon(jdii);
        tplat=plat(jdii);
        tpfile=pfile(jdii);
        tpjday=pjday(jdii);
        
        %from eddy tracks
        tmp_x=x(kk);
        tmp_y=y(kk);
        tmp_k=k(kk);
        tmp_id=id(kk);
        tmp_cyc=cyc(kk);
        tmp_axial_speed=axial_speed(kk);
        tmp_scale=scale(kk);
        
        for gfd=1:length(jdii)
            %interp profile location to 1/4 degree grid
            tx=tplon(gfd);
            ty=tplat(gfd);
            
            if ~isnan(tx)
                if ~isnan(ty)
                    [r,c]=imap(ty-.125,ty+.125,tx-.125,tx+.125,lat,lon);
                    r=r(1);
                    c=c(1);
                    cx=lon(r,c);
                    cy=lat(r,c);
                    
                    
                    %interp pjday to closest week
                    tj=round(tpjday(gfd));
                    tmpj=tj-3:tj+3;
                    p=sames(tmpj,jdays);
                    
                    if any(p)
                        ii=find(track_jday==jdays(p));
                        if any(ii)
                            dist_x=(111.11*(tplon((gfd))-tmp_x).*cosd(tplat((gfd))))./tmp_scale;
                            dist_y=(111.11*(tplat((gfd))-tmp_y))./tmp_scale;
                            ii=find(dist==min(dist));
                            %now we know closest eddy (ii), check if in mask
                            if any(r)
                                if any(c)
                                    in_eddy=in_eddy+1;
                                    if idmask(r,c)<0
                                        eddy_enclosed(pp)=-1;
                                    elseif idmask(r,c)>0
                                        eddy_enclosed(pp)=1;
                                    else
                                        eddy_enclosed(pp)=0;
                                    end
                                end
                            end
                            
                            %figure out location of SSH extrema
                            mask=nan*idmask;
                            mask(abs(idmask)==eid(ii))=1;
                            tmp_ssh=ssh.*mask;
                            eddy_ssh(pp)=max(abs(tmp_ssh(:)));
                            imax=find(abs(tmp_ssh)==eddy_ssh(pp));
                            imax=imax(1);
                            eddy_ext_x(pp)=lon(imax);
                            eddy_ext_y(pp)=lat(imax);
                            clear mask imx tmp_ssh
                            
                            %calculate distances from centroid and extrema
                            eddy_dist_ext_x(pp)=((111.11*cosd(tplat(gfd)))*(tplon(gfd)-eddy_ext_x(pp)))./scale(ii);
                            eddy_dist_ext_y(pp)=(111.11*(tplat(gfd)-eddy_ext_y(pp)))./scale(ii);
                            
                            eddy_dist_x(pp)=((111.11*cosd(tplat(gfd)))*(tplon(gfd)-x(ii)))./scale(ii);
                            eddy_dist_y(pp)=(111.11*(tplat(gfd)-y(ii)))./scale(ii);
                            
                            %add Argo info to output
                            eddy_pfile(pp)=tpfile(gfd);
                            eddy_pjday(pp)=tpjday(gfd);
                            eddy_plat(pp)=tplat(gfd);
                            eddy_plon(pp)=tplon(gfd);
                            %times stap
                            eddy_pjday_round(pp)=jdays(p);
                            %add eddy info to output
                            eddy_eid(pp)=idmask(r,c);
                            eddy_id(pp)=id(ii(1));
                            eddy_x(pp)=x(ii(1));
                            eddy_y(pp)=y(ii(1));
                            eddy_cyc(pp)=cyc(ii(1));
                            eddy_scale(pp)=scale(ii(1));
                            eddy_amp(pp)=amp(ii(1));
                            eddy_axial_speed(pp)=axial_speed(ii(1));
                            eddy_k(pp)=k(ii(1));
                            %rest coutner
                            pp=pp+1;
                            
                            %plot
                            if r>10 & r<630 & c>10 &c<1430
                                figure(10)
                                clf
                                pcolor(lon(r-10:r+10,c-10:c+10),lat(r-10:r+10,c-10:c+10),double(idmask(r-10:r+10,c-10:c+10)));shading flat;axis image
                                hold on
                                plot(eddy_plon(pp),eddy_plat(pp),'k.','markersize',30)
                                plot(eddy_x(pp),eddy_y(pp),'r.','markersize',30)
                                plot(eddy_ext_x(pp),eddy_ext_y(ppr),'r.','markersize',30)
                                plot(eddy_plon(pp),eddy_plat(pp),'ko','markersize',30)
                                plot(eddy_x(pp),eddy_y(pp),'ro','markersize',30)
                                plot(eddy_ext_x(pp),eddy_ext_y(ppr),'ro','markersize',30)
                                drawnow
                                pause(.8)
                            end
                        else
                            display('missing plat or plon')
                        end
                    end
                    n=n+1;
                end
            end
        end
    end
end



fprintf('\n')

%clear nan's out of output file;                    
ii=find(isnan(eddy_x));
eddy_x(ii)=[];
eddy_y(ii)=[];
eddy_cyc(ii)=[];
eddy_k(ii)=[];
eddy_id(ii)=[];
eddy_eid(ii)=[];
eddy_scale(ii)=[];
eddy_plat(ii)=[];
eddy_plon(ii)=[];
eddy_dist_x(ii)=[];
eddy_dist_y(ii)=[];
eddy_pjday(ii)=[];
eddy_pjday_round(ii)=[];
eddy_pfile(ii)=[];
eddy_amp(ii)=[];
eddy_axial_speed(ii)=[];
eddy_ext_x(ii)=[];
eddy_ext_y(ii)=[];
eddy_ssh(ii)=[];
eddy_dist_ext_x(ii)=[];
eddy_dist_ext_y(ii)=[];
eddy_enclosed(ii)=[];

save eddy_argo_prof_index_V5_fast.mat eddy_*

display(['portion of total profiles within eddies = ',num2str(in_eddy/lap)])
    