function eddies=track_eddies_OW(lon,lat,jdays,ow,dx,cmax,ci,cmin)

%%%
%inputs
%lon[m,n]           longitudes
%lat[m,n]           latitudes
%jdays[p]           integer dates of each layer of data
%ow[m,n,p]          Okubu-Weiss
%dx[1]              grid spacing in degrees
%cmax[1]            max contour value used to identify eddy
%ci[1]              contour interval for eddy identificaiton
%cmin[1]            min contour value


%%%
%outputs
%eddies.x           longitudes of eddy ow extrema
%eddies.y           Latitudes of eddy ow extrema
%eddies.id          Unique ID for each eddy.  This ID is carried along it's track
%eddies.eid         Unique ID for each eddy in each time step.  EID is used to locate eddy in eddies.mask
%eddies.radius      Radius scale of the eddy defined as the radius of a
%                   circle with area equal to that of the area enclosed by the outer most
%                   closed contour of ow, enclosing the eddy.
%eddies.k           Eddy age
%eddies.age         Maximum age of the eddy
%eddies.track_jday  Time stamp of the eddy
%eddies.mask        Mask the same size as ow with pixels located within an
%                   eddy demarcated by the eddy EID



%%%%
%set thresholds; these can be adjusted to optimize the algorithm for any
%region
%%%%
im=length(lat(:,1));
jm=length(lon(1,:));
tm=length(jdays);

ujd=unique(jdays);
dt=ujd(2)-ujd(1);

max_dist_x=50;             %maximum x distance an eddy can propagate in one dt to be consider part of pervious observed eddy
max_dist_y=10;             %maximum y distance an eddy can propagate in one dt to be consider part of pervious observed eddy

mask=ones(size(ow));

edd_pnt=1;
area=dx*ones(size(lat));

display('Identifying eddies')
tic
for it=1:tm
    display(['Time step ',num2str(it),' of ',num2str(tm)])
    nmask=ones(size(mask(:,:,it)));
    eid_mask=nan(size(nmask));
    
    if ~isempty(find(~isnan(ow(:,:,it))))
        %first identify anticyclones
        for ll=cmax:ci:cmin %loop through ow filed
            C=contourc(lon(1,:),lat(:,1),ow(:,:,it).*nmask,[ll ll]);
            %find closed contours
            if length(C(1,:))>5
                tmp=nan*C;
                st=2;
                ed=C(2,1)+1;
                while ed<length(C(1,:))
                    if C(1,st)==C(1,ed) && C(2,st)==C(2,ed)
                        tmp(1,st-1:ed+1)=C(1,st-1:ed+1);
                        tmp(2,st-1:ed+1)=C(2,st-1:ed+1);
                        cont_ow=tmp(1,st-1);
                        
                        %make eddy mask
                        [inmask,onmask] = inpolygon(lon,lat,tmp(1,st:ed),tmp(2,st:ed));
                        inmask(onmask==1)=1;
                        ttm=nan(size(inmask));
                        ttm(inmask==1)=1;
                        rrc=ow(:,:,it).*ttm;
                        ii=find(rrc==min(rrc(:)));
                        
                        %%%uncomment following two lines and comment the
                        %%%two after if you want to track eddy centroids vs
                        %%%extrema
                        
                        %y(edd_pnt) = mean(lat(ttm==1)); %%find the centroid of the eddy
                        %x(edd_pnt) = mean(lon(ttm==1));
                        %
                        y(edd_pnt)=lat(ii);
                        x(edd_pnt)=lon(ii);
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
        amask=ones(size(nmask));
        amask(~isnan(nmask))=nan;
        
        %%%plot
        figure(1)
        clf
        subplot(211)
        pcolor(lon,lat,ow(:,:,it).*amask);shading flat;axis image
        title('O-W masked with eddy mask')
        hold on
        ia=find(track_jday==jdays(it));
        for m=1:length(ia)
            plot(x(ia),y(ia),'k*')
        end
        subplot(212)
        pcolor(lon,lat,ow(:,:,it));shading flat;axis image
        title('O-W')
        hold on
        for m=1:length(ia)
            plot(x(ia),y(ia),'k*')
        end
        drawnow
%         eval(['print -dpng -r300 frame_',num2str(it)])
        
    end
end
toc


%%%
%%%Now track eddies
%%%

display('Tracking eddies')
tic

id_pnt=1;
id=nan*x;
status=zeros(size(x)); %set all eddy status to 0 (dead)

%%%prep eddies from jdays(1)
ii=find(track_jday==jdays(1));
status(ii)=1; %set all of jdays(1) eddies to alive
for m=1:length(ii);
    id(ii(m))=id_pnt; %assign them a unique id
    id_pnt=id_pnt+1;
end

%now look back in time
for it=2:tm
    %%%%First do anticyclones
    itime=find(track_jday==jdays(it));
    itime1=find(track_jday==jdays(it)-dt);
    itime2=find(track_jday==jdays(it)-2*dt);
    
    for m=1:length(itime)
        %first look at one dt in the past
        dist_x=x(itime(m))-x(itime1);
        dist_y=sqrt((y(itime(m))-y(itime1)).^2);
        dist=abs(dist_x)+dist_y;
        dist(dist_x>0)=nan; %Limit search to eddies offshore of currnet eddy.  Change to < if x is defined as postive to left
        ii=find(dist==min(dist));
        if any(ii)
            ii=ii(1);
            if dist_y(ii)<=max_dist_y && ...
                    dist_x(ii)<=max_dist_x && ...
                    status(itime1(ii))==1 && ...
                    radius(itime1(ii))>=0.25*radius(itime(m)) && ...  %this checks to make sure eddies are about the same size
                    radius(itime1(ii))<=2.5*radius(itime(m))
                
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
end

ii=find(age>=1);


%make structure array
eddies.x=x(ii);
eddies.y=y(ii);
eddies.id=id(ii);
eddies.eid=eid(ii);
eddies.radius=radius(ii);
eddies.k=k(ii);
eddies.age=age(ii);
eddies.track_jday=track_jday(ii);
eddies.mask=mask;

figure(2)
clf
pcolor(lon,lat,nan*ow(:,:,1));shading flat;axis image
hold on
ia=unique(eddies.id);
for m=1:length(ia)
    ii=find(eddies.id==ia(m));
    plot(eddies.x(ii),eddies.y(ii),'r')
    plot(eddies.x(ii),eddies.y(ii),'k*')
    plot(eddies.x(ii(1)),eddies.y(ii(1)),'r.','markersize',15)
end

drawnow


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Eddy tracking ends here%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%% Sub functions
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%


%function [mean] = pmean(x);% Calculates the mean of x

function mean = pmean(x)
warning('OFF','all')
x=x(:);
p=~isnan(x);
y=x(p);
mean=sum(y)/length(y);
warning('ON','all')

function [r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);

%[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);


%check to see if lat lon are matrix or vectors
[m,n]=size(lat);
if m==1 | n==1
    r=find(lat>=min_lat-.001 & lat<=max_lat+.001);
    c=find(lon>=min_lon-.001 & lon<=max_lon+.001);
else
    r=find(lat(:,1)>=min_lat-.001 & lat(:,1)<=max_lat+.001);
    c=find(lon(1,:)>=min_lon-.001 & lon(1,:)<=max_lon+.001);
end








