clear all
close all

load argo_profile_index.mat pjday plat plon pfile
head   = 'AVISO_25_W_';
loadpath   = '/matlab/data/eddy/V5/mat/';

load /matlab/data/eddy/V5/global_tracks_V5
startjd=min(track_jday); %from mid_week_jdays of eddy files
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
eddy_ext_x,eddy_ext_y,eddy_ssh,eddy_dist_ext_x,eddy_dist_ext_y]=deal(nan(length(plat),1));
eddy_pfile=cell(length(plat),1);

in_eddy=0;
load /matlab/data/eddy/V5/global_tracks_V5
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
    if any(jdii)
        load([loadpath,head,num2str(jdays(m))],'idmask','ssh')
        tplon=plon(jdii);
        tplat=plat(jdii);
        tpfile=pfile(jdii);
        tpjday=pjday(jdii);
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

                if any(r)
                if any(c)
                    %interp pjday to closest week
                    tj=round(tpjday(gfd));
                    tmpj=tj-3:tj+3;
                    p=sames(tmpj,jdays);

                    if any(p)
                        %now look to see if float is in eddy
                         %if r>1 & r<length(lat(:,1)) &  c>1 & c<length(lat(1,:)) & ~isnan(idmask(r-1:r+1,c-1:c+1))
                            ii=find(track_jday==jdays(p) & eid==abs(idmask(r,c)));
                            if any(ii)
        %                        display('good')
                                in_eddy=in_eddy+1;
%                                 if r>10 & r<630 & c>10 &c<1430
%                                     figure(10)
%                                     clf
%                                     pcolor(lon(r-10:r+10,c-10:c+10),lat(r-10:r+10,c-10:c+10),double(idmask(r-10:r+10,c-10:c+10)));shading flat;axis image
%                                     hold on
%                                     plot(tplon(gfd),tplat(gfd),'k*','markersize',10)
%                                     plot(x(ii),y(ii),'r*','markersize',10)
%                                     drawnow
%                                     pause(.8)
%                                 end
                                mask=nan*idmask;
                                mask(abs(idmask)==eid(ii))=1;
                                tmp_ssh=ssh.*mask;
                                eddy_ssh(pp)=max(abs(tmp_ssh(:)));
                                imax=find(abs(tmp_ssh)==eddy_ssh(pp));
                                imax=imax(1);
                                eddy_ext_x(pp)=lon(imax);
                                eddy_ext_y(pp)=lat(imax);
                                clear mask imx tmp_ssh
                                
                                eddy_dist_ext_x(pp)=((111.11*cosd(tplat(gfd)))*(tplon(gfd)-eddy_ext_x(pp)))./scale(ii);
                                eddy_dist_ext_y(pp)=(111.11*(tplat(gfd)-eddy_ext_y(pp)))./scale(ii);

                                eddy_dist_x(pp)=((111.11*cosd(tplat(gfd)))*(tplon(gfd)-x(ii)))./scale(ii);
                                eddy_dist_y(pp)=(111.11*(tplat(gfd)-y(ii)))./scale(ii);
                                
                                eddy_pfile(pp)=tpfile(gfd);
                                eddy_pjday(pp)=tpjday(gfd);
                                eddy_plat(pp)=tplat(gfd);
                                eddy_plon(pp)=tplon(gfd);
                                
                                eddy_pjday_round(pp)=jdays(p);
                                
                                eddy_eid(pp)=idmask(r,c);
                                eddy_id(pp)=id(ii);
                                eddy_x(pp)=x(ii);
                                eddy_y(pp)=y(ii);
                                eddy_cyc(pp)=cyc(ii);
                                eddy_scale(pp)=scale(ii);
                                eddy_amp(pp)=amp(ii);
                                eddy_axial_speed(pp)=axial_speed(ii);
                                eddy_k(pp)=k(ii);
                                pp=pp+1;
                            else
                                %display('no ii')
                                %idmask(r,c)

                            end
                        %else
                            %display('not in eddy')
                        %end
                    else
                        display('not in time range')
                    end
                else
                    display('no r')
                end
                else
                    display('no c')
                end
            else
                display('missing plat or plon')
            end
            end
        n=n+1;
        end
    end    
end
fprintf('\n')

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

save eddy_argo_prof_index_V5_fast.mat eddy_*

display(['portion of total profiles within eddies = ',num2str(in_eddy/lap)])
    