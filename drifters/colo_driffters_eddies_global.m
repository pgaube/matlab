clear all
close all

%
load ~/data/eddy/V5/global_tracks_v5_12_weeks track_jday x y
jdays=min(track_jday):7:max(track_jday);

load ~/data/drifter/drifters lat lon id jday spd
max_lat=max(y(:));
min_lat=min(y(:));
max_lon=max(x(:));
min_lon=min(x(:));
ii=find(lon>min_lon&lon<max_lon&lat>min_lat&lat<max_lat&jday>min(jdays)&jday<max(jdays));

tjday=jday(ii);
tlon=lon(ii);
tlat=lat(ii);
tagid=id(ii);
tspd=spd(ii);

head   = 'AVISO_25_W_';
loadpath   = '~/data/eddy/V5/mat/';

load ~/data/eddy/V5/global_tracks_v5_12_weeks
load([loadpath,head,num2str(jdays(10))],'lon','lat')

[eddy_tspd,eddy_speed,eddy_cyc,eddy_dist_x,eddy_dist_y,eddy_id,eddy_pjday,eddy_scale,eddy_x,eddy_y,...
eddy_pjday_round,eddy_plat,eddy_plon,eddy_eid,eddy_k,eddy_amp,eddy_axial_speed,...
eddy_ext_x,eddy_ext_y,eddy_ssh,eddy_dist_ext_x,eddy_dist_ext_y,eddy_enclosed,...
eddy_tagid]=deal(nan(length(tlat),1));

pp=1;
in_eddy=0;
in_trapp=0;

count_off=0;
for m=1:length(jdays)
    [ye,mo,da]=jd2jdate(jdays(m));
    display([num2str(ye) '-' num2str(mo) '-' num2str(da)])
    jdii=find(tjday>=jdays(m)-3 & tjday<=jdays(m)+3);
    kk=find(track_jday==jdays(m));
    if any(jdii) & exist([loadpath,head,num2str(jdays(m)),'.mat'])
        load([loadpath,head,num2str(jdays(m))],'idmask','ssh','u','v')
        spd=sqrt(u.^2+v.^2);
        %from Tags
        tplon=tlon(jdii);
        tplat=tlat(jdii);
        tpjday=tjday(jdii);
        tptagid=tagid(jdii);
        tptspd=tspd(jdii);
        
        %from eddy tracks
        tmp_x=x(kk);
        tmp_y=y(kk);
        tmp_ext_x=ext_x(kk);
        tmp_ext_y=ext_y(kk);;
        tmp_amp=amp(kk);        
        tmp_k=k(kk);
        tmp_id=id(kk);
        tmp_eid=eid(kk);
        tmp_cyc=cyc(kk);
        tmp_axial_speed=axial_speed(kk);
        tmp_scale=scale(kk);
        tmp_track_jday=track_jday(kk);
        
        for gfd=1:length(jdii)
            %interp profile location to 1/4 degree grid
            [r,c]=imap(tplat(gfd)-.125,tplat(gfd)+.125,tplon(gfd)-.125,tplon(gfd)+.125,lat,lon);
            r=r(1);
            c=c(1);
            cx=lon(r,c);
            cy=lat(r,c);

            %interp pjday to closest week
            tj=round(tpjday(gfd));
            tmpj=tj-3:tj+3;
            p=sames(tmpj,jdays);

            if any(p)
                dist_x=(111.11*(tplon(gfd)-tmp_x).*cosd(tplat(gfd)));
                dist_y=(111.11*(tplat(gfd)-tmp_y));
                dist=sqrt(dist_x.^2+dist_y.^2);
                ii=find(dist==min(dist));
                
                %fix if in one eddy but closer to the centroid of another
                test_if_ed=find(tmp_eid==abs(idmask(r,c)) & tmp_track_jday==jdays(m));
                if abs(idmask(r,c))~=tmp_eid(ii(1)) & ~isnan(idmask(r,c)) & length(test_if_ed)>0
                    count_off=count_off+1;
                    %display(['within one eddy but closer to another, fuck!!, thats ',num2str(count_off)])
                    old_ii=ii;
                    ii=find(tmp_eid==abs(idmask(r,c)) & tmp_track_jday==jdays(m));
                    
%                     if r>10 & r<630 & c>10 &c<1430 & eddy_enclosed(pp)~=0
%                         figure(10)
%                         clf
%                         pcolor(lon(r-10:r+10,c-10:c+10),lat(r-10:r+10,c-10:c+10),double(idmask(r-10:r+10,c-10:c+10)));shading flat;axis image
%                         colorbar
%                         hold on
%                         plot(tplon(gfd),tplat(gfd),'k.','markersize',30)
%                         plot(cx,cy,'g.','markersize',30)
%                         plot(tmp_x(ii),tmp_y(ii),'r.','markersize',30)
%                         plot(tmp_x(old_ii(1)),tmp_y(old_ii(1)),'b.','markersize',30)
%                         plot(tplon(gfd),tplat(gfd),'ko','markersize',30)
%                         plot(tmp_x(ii),tmp_y(ii),'ro','markersize',30)
%                         plot(cx,cy,'go','markersize',30)
%                         plot(tmp_x(old_ii(1)),tmp_y(old_ii(1)),'bo','markersize',30)
%                         legend('idmask','profile','grid loc','centroid','old centorid')
%                         drawnow
%                         pause(.8)
%                     end
%                     
                end    

                %test_min_dist=dist(ii)
                %now we know closest eddy (ii), check if in mask
                if any(r)
                    if any(c)
                        if idmask(r,c)==-tmp_eid(ii(1))
                            eddy_enclosed(pp)=-1;
                            in_trapp=in_trapp+1;
                        elseif idmask(r,c)==tmp_eid(ii(1))
                            eddy_enclosed(pp)=1;
                            in_eddy=in_eddy+1;
                        else
                            eddy_enclosed(pp)=0;
                        end
                    end
                end

                %calculate distances from centroid and extrema
                eddy_dist_ext_x(pp)=((111.11*cosd(tplat(gfd)))*(tplon(gfd)-tmp_ext_x(ii(1))))./tmp_scale(ii(1));
                eddy_dist_ext_y(pp)=(111.11*(tplat(gfd)-tmp_ext_y(ii(1))))./tmp_scale(ii(1));

                eddy_dist_x(pp)=((111.11*cosd(tplat(gfd)))*(tplon(gfd)-tmp_x(ii(1))))./tmp_scale(ii(1));
                eddy_dist_y(pp)=(111.11*(tplat(gfd)-tmp_y(ii(1))))./tmp_scale(ii(1));

                %add SSH info to output
                eddy_speed(pp)=pmean(spd(r,c));
                eddy_ssh(pp)=pmean(ssh(r,c));
                
                %add Tag info to output
                eddy_pjday(pp)=tpjday(gfd);
                eddy_plat(pp)=tplat(gfd);
                eddy_plon(pp)=tplon(gfd);
                eddy_tagid(pp)=tptagid(gfd);
                eddy_tspd(pp)=tptspd(gfd);

                %time stap
                eddy_pjday_round(pp)=jdays(p);

                %add eddy info to output
                eddy_eid(pp)=idmask(r,c);
                eddy_id(pp)=tmp_id(ii(1));
                eddy_x(pp)=tmp_x(ii(1));
                eddy_y(pp)=tmp_y(ii(1));
                eddy_cyc(pp)=tmp_cyc(ii(1));
                eddy_scale(pp)=tmp_scale(ii(1));
                eddy_amp(pp)=tmp_amp(ii(1));
                eddy_axial_speed(pp)=tmp_axial_speed(ii(1));
                eddy_k(pp)=tmp_k(ii(1));
                eddy_ext_x(pp)=tmp_ext_x(ii(1));
                eddy_ext_y(pp)=tmp_ext_y(ii(1));
                
                %rest coutner and clear tmps
                pp=pp+1;
                clear mask imx tmp_ssh
            else
                display('missing plat or plon')
            end
        end
    end
end





fprintf('\n')

% %clear nan's out of output file;                    
% ii=find(isnan(eddy_x));
% eddy_x(ii)=[];
% eddy_y(ii)=[];
% eddy_cyc(ii)=[];
% eddy_k(ii)=[];
% eddy_id(ii)=[];
% eddy_eid(ii)=[];
% eddy_scale(ii)=[];
% eddy_plat(ii)=[];
% eddy_plon(ii)=[];
% eddy_dist_x(ii)=[];
% eddy_dist_y(ii)=[];
% eddy_pjday(ii)=[];
% eddy_pjday_round(ii)=[];
% eddy_pfile(ii)=[];
% eddy_amp(ii)=[];
% eddy_axial_speed(ii)=[];
% eddy_ext_x(ii)=[];
% eddy_ext_y(ii)=[];
% eddy_ssh(ii)=[];
% eddy_dist_ext_x(ii)=[];
% eddy_dist_ext_y(ii)=[];
% eddy_enclosed(ii)=[];
% eddy_qual(ii)=[];

save eddy_drifter_colo eddy_*
