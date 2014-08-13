function eddies=track_eddies(lon,lat,jdays,ssh,dx)

%%%
%inputs
%lon[m,n]       longitudes
%lat[m,n]       latitudes
%jdays[p]       julian dates of each layer of data
%ssh[m,n,p]     SSH in cm
%dx[1]          grid spacing in degrees



%%%%
%set thresholds
%%%%

min_amp=1;                  %minimu amplitude of eddy
min_k=1;                    %minmim lifetime of eddy
npt=10;                     %number of points on each side of eddy centroid used to compute scale
min_pix=20*(.25/dx)         %min number of pixels within eddy
max_pix=1000*(.25/dx)       %maximim number of pixels within eddy
max_dist=150;
max_dist_pnt=400;

im=length(lat(:,1));
jm=length(lon(1,:));
tm=length(jdays);
ujd=unique(jdays);
dt=ujd(2)-ujd(1);
%%Contour SSH to find eddies


mask=ones(size(ssh));

area=(111.11*dx)*(111.11*dx*cosd(lat));
edd_pnt=1;


for it=1:tm
    tic
    nmask=ones(size(mask(:,:,it)));
    eid_mask=nan(size(nmask));
    u=dfdy(ssh(:,:,it),dx);
    v=-dfdx(lat,ssh(:,:,it),dx);
    spd=9.81*sqrt(v.^2+u.^2)./f_cor(lat); %cm/s
    
    %first track anticyclones
    for ll=-100:100 %loop through SSH filed 1 cm at a time
        C=contourc(lon(1,:),lat(:,1),ssh(:,:,it).*nmask,[ll ll]);
        %find closed contours
        if length(C(1,:))>5
            tmp=nan*C;
            st=2;
            ed=C(2,1)+1;
            while ed<length(C(1,:))
                if C(1,st)==C(1,ed) & C(2,st)==C(2,ed)
                    tmp(1,st-1:ed+1)=C(1,st-1:ed+1);
                    tmp(2,st-1:ed+1)=C(2,st-1:ed+1);
                    cont_ssh=tmp(1,st-1);
                    
                    %make eddy mask
                    [inmask,onmask] = inpolygon(lon,lat,tmp(1,st:ed),tmp(2,st:ed));
                    inmask(onmask==1)=1;
                    ttm=nan(size(inmask));
                    ttm(inmask==1)=1;
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%
                    %%%start thresholding eddy to see if it meets criteris
                    %%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %check to see how many pixels in eddy
                    if length(find(inmask==1))>min_pix & length(find(inmask==1))<max_pix
                        %check to make sure SSH is of the right sign
                        rrc=ssh(:,:,it).*ttm;
                        if min(rrc(:))>eps
                            %check to make sure there is only one SSH maxima
                            if length(find(rrc==max(rrc(:))))==1
                                %find eddy SSH extremum
                                ii=find(rrc==max(rrc(:)));
                                %check to make sure amp is large enough
                                if rrc(ii)-cont_ssh>min_amp
                                    %check dist of each point within eddy
                                    %from all others
                                    inpnts=find(~isnan(ttm));
                                    clear distpnt
                                    for npr=1:length(inpnts)
                                        distpnt(npr)=max(sqrt((111.11*(lat(inpnts(npr))-lat(inpnts))).^2+(111.11*cosd(lat(inpnts(npr))).*(lon(inpnts(npr))-lon(inpnts))).^2));
                                    end
                                    if max(distpnt(:))<=max_dist_pnt;
                                        
                                        %%figure out speed along contour
                                        %%and speed-based scale
                                        %                                         [rs,cs]=imap(lat(ii)-2,lat(ii)+2,lon(ii)-2,lon(ii)+2,lat,lon);
                                        %                                         slat=interp2(lat(rs,cs),3);
                                        %                                         slon=interp2(lon(rs,cs),3);
                                        %                                         tmpspd=interp2(spd(rs,cs).*ttm(rs,cs),3);
                                        %                                         tmpssh=interp2(ssh(rs,cs,it).*ttm(rs,cs),3);
                                        %
                                        %
                                        %                                         tmps_area=interp2(area(rs,cs),3);
                                        %                                         S=contourc(slon(1,:),slat(:,1),tmpssh,[-100:1:100]);
                                        %                                         Sst=2;
                                        %                                         Sed=S(2,1)+1;
                                        %                                         dspd=0;
                                        %
                                        %                                         while Sed<length(S(1,:))
                                        %                                             if S(1,Sst)==S(1,Sed) & S(2,Sst)==S(2,Sed)
                                        %                                                 clear Stmp
                                        %                                                 Stmp(1,:)=C(1,Sst-1:Sed+1);
                                        %                                                 Stmp(2,:)=C(2,Sst-1:Sed+1);
                                        %                                                 [dumb,sponmask] = inpolygon(slon,slat,Stmp(1,:),Stmp(2,:));
                                        %                                                 sttm=nan(size(sponmask));
                                        %                                                 sttm(dumb==1)=1;
                                        %                                                 figure(1);clf;pcolor(slon,slat,sttm);shading flat
                                        %                                                 dspd=dspd+1;
                                        %                                                 cont_spd(dspd)=pmean(tmpspd.*sponmask);
                                        %                                                 raga=tmps_area.*dumb;
                                        %                                                 tmp_area(dspd)=sqrt(nansum(raga(:))./pi);
                                        %                                                 Sst=Sed+2;
                                        %                                                 Sed=Sst-1+S(2,Sst-1);
                                        %                                             else
                                        %                                                 Sst=Sed+2;
                                        %                                                 Sed=Sst-1+S(2,Sst-1);
                                        %                                             end
                                        %                                         end
                                        %                                         spir=find(cont_spd==max(cont_spd));
                                        %                                         cont_spd(spir)
                                        
                                        y(edd_pnt)=lat(ii);
                                        x(edd_pnt)=lon(ii);
                                        cyc(edd_pnt)=1;
                                        amp(edd_pnt)=rrc(ii)-cont_ssh;
                                        
                                        
                                        tt=area.*ttm;
                                        in_area=nansum(tt(:));
                                        radius(edd_pnt)=sqrt(in_area./pi);
                                        
                                        
                                        %now add eddy to nmask and dataset
                                        nmask(inmask==1)=nan;
                                        
                                        %add to eid mask
                                        eid_mask(inmask==1)=edd_pnt;
                                        eid(edd_pnt)=edd_pnt;
                                        track_jday(edd_pnt)=jdays(it);
                                        
                                        %
                                        
                                        %update eddy_pnt counter
                                        edd_pnt=edd_pnt+1;
                                    end
                                end
                            end
                        end
                    end
                    
                    %update contours and move to next contour
                    st=ed+2;
                    ed=st-1+C(2,st-1);
                    
                else
                    %not a close contour, so update contours and move to next contour
                    st=ed+2;
                    ed=st-1+C(2,st-1);
                end
            end
        end
    end
    
    %first track cyclones
    for ll=100:-1:-100 %loop through SSH filed 1 cm at a time
        C=contourc(lon(1,:),lat(:,1),ssh(:,:,it).*nmask,[ll ll]);
        %find closed contours
        if length(C(1,:))>5
            tmp=nan*C;
            st=2;
            ed=C(2,1)+1;
            while ed<length(C(1,:))
                if C(1,st)==C(1,ed) & C(2,st)==C(2,ed)
                    tmp(1,st-1:ed+1)=C(1,st-1:ed+1);
                    tmp(2,st-1:ed+1)=C(2,st-1:ed+1);
                    cont_ssh=tmp(1,st-1);
                    
                    %make eddy mask
                    [inmask,onmask] = inpolygon(lon,lat,tmp(1,st:ed),tmp(2,st:ed));
                    inmask(onmask==1)=1;
                    ttm=nan(size(inmask));
                    ttm(inmask==1)=1;
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%
                    %%%start thresholding eddy to see if it meets criteris
                    %%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%
                    
                    %check to see how many pixels in eddy
                    if length(find(inmask==1))>min_pix & length(find(inmask==1))<max_pix
                        %check to make sure SSH is of the right sign
                        rrc=ssh(:,:,it).*ttm;
                        if min(rrc(:))<-eps
                            %check to make sure there is only one SSH maxima
                            if length(find(rrc==min(rrc(:))))==1
                                %find eddy SSH extremum
                                ii=find(rrc==min(rrc(:)));
                                %check to make sure amp is large enough
                                if abs(rrc(ii)-cont_ssh)>min_amp
                                    %check dist of each point within eddy
                                    %from all others
                                    inpnts=find(~isnan(ttm));
                                    clear distpnt
                                    for npr=1:length(inpnts)
                                        distpnt(npr)=max(sqrt((111.11*(lat(inpnts(npr))-lat(inpnts))).^2+(111.11*cosd(lat(inpnts(npr))).*(lon(inpnts(npr))-lon(inpnts))).^2));
                                    end
                                    if max(distpnt(:))<=max_dist_pnt;
                                        
                                        y(edd_pnt)=lat(ii);
                                        x(edd_pnt)=lon(ii);
                                        cyc(edd_pnt)=-1;
                                        amp(edd_pnt)=abs(rrc(ii)-cont_ssh);
                                        
                                        
                                        tt=area.*ttm;
                                        in_area=nansum(tt(:));
                                        radius(edd_pnt)=sqrt(in_area./pi);
                                        
                                        %now add eddy to nmask and dataset
                                        nmask(inmask==1)=nan;
                                        
                                        %add to eid mask
                                        eid_mask(inmask==1)=edd_pnt;
                                        eid(edd_pnt)=edd_pnt;
                                        track_jday(edd_pnt)=jdays(it);
                                        %update eddy_pnt counter
                                        edd_pnt=edd_pnt+1;
                                    end
                                end
                            end
                        end
                    end
                    
                    %update contours and move to next contour
                    st=ed+2;
                    ed=st-1+C(2,st-1);
                    
                else
                    %not a close contour, so update contours and move to next contour
                    st=ed+2;
                    ed=st-1+C(2,st-1);
                end
            end
        end
    end
    
    %update mask with eddies
    mask(:,:,it)=eid_mask;
    toc
    
    %     clf
    %     pmap(lon,lat,ssh(:,:,it).*nmask)
    %     title(['week ',num2str(jdays(it))])
    %     caxis([-80 80])
    amask=ones(size(nmask));
    amask(~isnan(nmask))=nan;
    %     figure(1)
    %     clf
    %     pmap(lon,lat,ssh(:,:,it).*amask)
    %     hold on
    %     caxis([-60 60])
    %     title(['week ',num2str(it),' of ',num2str(tm)])
    %     ii=find(track_jday==jdays(it) & cyc==1);
    %     for tt=1:length(ii)
    %         m_plot(x(ii(tt)),y(ii(tt)),'k*')
    %     end
    %     ii=find(track_jday==jdays(it) & cyc==-1);
    %     for tt=1:length(ii)
    %         m_plot(x(ii(tt)),y(ii(tt)),'k*')
    %     end
    %
    %     drawnow
end


%%%
%%%Now track eddies
%%%

id_pnt=1;
id=nan*x;
status=zeros(size(x)); %set all eddy status to 0 (dead)

%%%prep eddies from jdays(1)
ii=find(track_jday==jdays(1));
status(ii)=1; %set all of jdays(1) eddies to alive
for m=1:length(ii);
    id(ii(m))=id_pnt; %asign them a unique id
    id_pnt=id_pnt+1;
end

%now look back in time
for it=2:tm
    %%%%First do anticyclones
    itime=find(track_jday==jdays(it) & cyc==1);
    itime1=find(track_jday==jdays(it)-dt & cyc==1);
    
    for m=1:length(itime)
        dist=sqrt((111.11*(y(itime(m))-y(itime1))).^2+(111.11*cosd(y(itime1)).*(x(itime(m))-x(itime1))).^2);
        ii=find(dist==min(dist));
        if any(ii)
            ii=ii(1);
            if dist(ii)<=max_dist & ...
                    dist>0  & ...
                    status(itime1(ii))==1 & ...
                    amp(itime1(ii))>=0.25*amp(itime(m)) & ...
                    amp(itime1(ii))<=2.5*amp(itime(m))%if pass, found an untaken eddy to atatch it to
                id(itime(m))=id(itime1(ii)); %pass the id of the eddy attached to this eddy to this eddy
                status(itime1(ii))=0; %specify the eddy attached to this eddy as taken
                status(itime(m))=1; %specify todays eddy as alive
            else
                id(itime(m))=id_pnt; %give this eddy a new id
                id_pnt=id_pnt+1;
                status(itime(m))=1; %specify this new eddy as alive
            end
        end
    end
    
    %%%%Now do cyclones
    itime=find(track_jday==jdays(it) & cyc==-1);
    itime1=find(track_jday==jdays(it)-dt & cyc==-1);
    
    for m=1:length(itime)
        dist=sqrt((111.11*(y(itime(m))-y(itime1))).^2+(111.11*cosd(y(itime1)).*(x(itime(m))-x(itime1))).^2);
        ii=find(dist==min(dist));
        if any(ii)
            ii=ii(1);
            if dist(ii)<=max_dist & ...
                    dist>0  & ...
                    status(itime1(ii))==1 & ...
                    amp(itime1(ii))>=0.25*amp(itime(m)) & ...
                    amp(itime1(ii))<=2.5*amp(itime(m))%if pass, found an untaken eddy to atatch it to
                id(itime(m))=id(itime1(ii)); %pass the id of the eddy attached to this eddy to this eddy
                status(itime1(ii))=0; %specify the eddy attached to this eddy as taken
                status(itime(m))=1; %specify todays eddy as alive
            else
                id(itime(m))=id_pnt; %give this eddy a new id
                id_pnt=id_pnt+1;
                status(itime(m))=1; %specify this new eddy as alive
            end
        end
    end
end

%%%%Compute k and threshold
k=nan*id;
age=nan*k;
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    k(ii)=1:length(ii);
    age(ii)=length(ii);
%     if length(ii)>6
%         x(ii)=smooth1d_loess(x(ii),1:length(ii),3,1:length(ii));
%         y(ii)=smooth1d_loess(y(ii),1:length(ii),3,1:length(ii));
%     end
end
%
ii=find(age>=min_k);
% ii=1:length(x);

eddies.x=x(ii);
eddies.y=y(ii);
eddies.id=id(ii);
eddies.eid=eid(ii);
% eddies.scale=scale(ii);
eddies.radius=radius(ii);
eddies.k=k(ii);
eddies.age=age(ii);
eddies.track_jday=track_jday(ii);
eddies.cyc=cyc(ii);
eddies.amp=amp(ii);
