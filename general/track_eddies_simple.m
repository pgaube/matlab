function eddies=track_eddies_simple(lon,lat,jdays,ssh,dx)

%%%
%inputs
%lon[m,n]           longitudes
%lat[m,n]           latitudes
%jdays[p]           integer dates of each layer of data
%ssh[m,n,p]         SSH in cm
%dx[1]              grid spacing in degrees
%dtdt_step [1]      time step of jdays, so if jdays is days, dt=1. if jdays is
%                   5-day weeks, dt=5

%%%
%outputs
%eddies.x           longitudes of eddy SSH extrema
%eddies.y           Latitudes of eddy SSH extrema
%eddies.id          Unique ID for each eddy.  This ID is carried along it's track
%eddies.eid         Unique ID for each eddy in each time step.  EID is used to locate eddy in eddies.mask
%eddies.radius      Radius scale of the eddy defined as the radius of a
%                   circle with area equal to that of the area enclosed by the outer most
%                   closed contour of SSH, enclosing the eddy.
%eddies.k           Eddy age
%eddies.age         Maximum age of the eddy
%eddies.track_jday  Time stamp of the eddy
%eddies.cyc         Eddy polarity, cyc=1 is an anticyclone (positive SSH),
%                   cyc=-1 is a cyclone (negative SSH).
%eddies.amp         Eddy amplitude, defined as the difference of the SSH at
%                   the eddy SSH extrema and that along the outermost contour
%                   defining the eddy.
%eddies.mask        Mask the same size as ssh with pixels located within an
%                   eddy demarcated by the eddy EID



%%%%
%set thresholds; these can be adjusted to optimize the algorithm for any
%region
%%%%
im=length(lat(:,1));
jm=length(lon(1,:));
tm=length(jdays);

tm=4


ujd=unique(jdays);
dt=ujd(2)-ujd(1);

min_amp=1;                  %minimum amplitude of eddy
min_k=1;                    %minmim lifetime of eddy
npt=10;                     %number of points on each side of eddy centroid used to compute scale
min_pix=20*(.25/dx) ;        %min number of pixels within eddy
max_pix=1000*(.25/dx);       %maximum number of pixels within eddy
max_dist=150;               %maximum distance an eddy can propagate in one dt to be consider part of pervious observed eddy
max_dist_pnt=400;






mask=ones(size(ssh));

area=(111.11*dx)*(111.11*dx*cosd(lat));
edd_pnt=1;

display('Identifying eddies')
tic
for it=1:tm
    display(['Time step ',num2str(it),' of ',num2str(tm)])
    nmask=ones(size(mask(:,:,it)));
    eid_mask=nan(size(nmask));
    u=dfdy(ssh(:,:,it),dx);
    v=-dfdx(lat,ssh(:,:,it),dx);
    spd=9.81*sqrt(v.^2+u.^2)./f_cor(lat); %cm/s
    
    if ~isempty(find(~isnan(ssh(:,:,it))))
        %first identify anticyclones
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
                        %%%start thresholding eddy to see if it meets criteria
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
                                            y(edd_pnt)=lat(ii);
                                            x(edd_pnt)=lon(ii);
                                            cyc(edd_pnt)=1;
                                            amp(edd_pnt)=abs(rrc(ii))-abs(cont_ssh);
                                            
                                            
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
        
        %now identify cyclones
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
                        %%%start thresholding eddy to see if it meets criteria
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
                                            amp(edd_pnt)=abs(rrc(ii))-abs(cont_ssh);
                                            
                                            
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
        amask=ones(size(nmask));
        amask(~isnan(nmask))=nan;
        
        %%%plot
        figure(1)
        clf
%         subplot(211)
        pmap(lon,lat,ssh(:,:,it).*amask);caxis([-60 60])
        hold on
        ia=find(cyc==1 & track_jday==jdays(it));
        ic=find(cyc==-1 & track_jday==jdays(it));
        for m=1:length(ia)
            m_plot(x(ia),y(ia),'k*')
        end
        
        for m=1:length(ia)
            m_plot(x(ic),y(ic),'k.')
        end
%         subplot(212)
%         pmap(lon,lat,ssh(:,:,it));
%         hold on
%         for m=1:length(ia)
%             m_plot(x(ia),y(ia),'k*')
%         end
%         
%         for m=1:length(ia)
%             m_plot(x(ic),y(ic),'k.')
%         end
        drawnow
        
    end
end
toc


figure(2)
clf
pmap(lon,lat,nan*ssh(:,:,1));
hold on
ia=find(cyc==1);
ic=find(cyc==-1);
for m=1:length(ia)
    m_plot(x(ia(m)),y(ia(m)),'r.','markersize',15)
end

for m=1:length(ic)
    m_plot(x(ic(m)),y(ic(m)),'b.','markersize',15)
end
drawnow


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
    itime=find(track_jday==jdays(it) & cyc==1);
    itime1=find(track_jday==jdays(it)-dt & cyc==1);
    itime2=find(track_jday==jdays(it)-2*dt & cyc==1);
    itime3=find(track_jday==jdays(it)-3*dt & cyc==1);
    
    for m=1:length(itime)
        %first look at one dt in the past
        dist=sqrt((111.11*(y(itime(m))-y(itime1))).^2+(111.11*cosd(y(itime1)).*(x(itime(m))-x(itime1))).^2);
%         dist(dist==0)=nan;
        ii=find(dist==min(dist));
        if any(ii)
            ii=ii(1); 
            if dist(ii)<=max_dist %if pass, found an untaken eddy to attach it to
                id(itime(m))=id(itime1(ii)); %pass the id of the eddy attached to this eddy to this eddy
                status(itime1(ii))=0; %specify the eddy attached to this eddy as taken
                status(itime(m))=1; %specify todays eddy as alive
            else
                %now look two dt in the past
                if any(itime2)
                    dist=sqrt((111.11*(y(itime(m))-y(itime2))).^2+(111.11*cosd(y(itime2)).*(x(itime(m))-x(itime2))).^2);
%                     dist(dist==0)=nan;
                    ii=find(dist==min(dist));
                    if any(ii)
                        ii=ii(1);
                        if dist(ii)<=max_dist %if pass, found an untaken eddy to attach it to
                            id(itime(m))=id(itime2(ii)); %pass the id of the eddy attached to this eddy to this eddy
                            status(itime2(ii))=0; %specify the eddy attached to this eddy as taken
                            status(itime(m))=1; %specify todays eddy as alive
                        else
                            %now look three dt in the past
                            if any(itime3)
                                dist=sqrt((111.11*(y(itime(m))-y(itime3))).^2+(111.11*cosd(y(itime3)).*(x(itime(m))-x(itime3))).^2);
                                dist(dist==0)=nan;
                                ii=find(dist==min(dist));
                                if any(ii)
                                    ii=ii(1);
                                    if dist(ii)<=max_dist %if pass, found an untaken eddy to attach it to
                                        id(itime(m))=id(itime3(ii)); %pass the id of the eddy attached to this eddy to this eddy
                                        status(itime3(ii))=0; %specify the eddy attached to this eddy as taken
                                        status(itime(m))=1; %specify todays eddy as alive
                                    else
                                        id(itime(m))=id_pnt; %give this eddy a new id
                                        id_pnt=id_pnt+1;
                                        status(itime(m))=1; %specify this new eddy as alive
                                    end
                                end
                            else
                                id(itime(m))=id_pnt; %give this eddy a new id
                                id_pnt=id_pnt+1;
                                status(itime(m))=1; %specify this new eddy as alive
                            end
                        end
                    end
                else
                    id(itime(m))=id_pnt; %give this eddy a new id
                    id_pnt=id_pnt+1;
                    status(itime(m))=1; %specify this new eddy as alive
                end
            end
        end
    end
    
    
    %%%%Now do cyclones
    itime=find(track_jday==jdays(it) & cyc==-1);
    itime1=find(track_jday==jdays(it)-dt & cyc==-1);
    itime2=find(track_jday==jdays(it)-2*dt & cyc==-1);
    itime3=find(track_jday==jdays(it)-3*dt & cyc==-1);
    
    for m=1:length(itime)
        %first look at one dt in the past
        dist=sqrt((111.11*(y(itime(m))-y(itime1))).^2+(111.11*cosd(y(itime1)).*(x(itime(m))-x(itime1))).^2);
        ii=find(dist==min(dist));
        if any(ii)
            ii=ii(1);            
            if dist(ii)<=max_dist%if pass, found an untaken eddy to attach it to
                id(itime(m))=id(itime1(ii)); %pass the id of the eddy attached to this eddy to this eddy
                status(itime1(ii))=0; %specify the eddy attached to this eddy as taken
                status(itime(m))=1; %specify todays eddy as alive
            else
                %now look two dt in the past
                if any(itime2)
                    dist=sqrt((111.11*(y(itime(m))-y(itime2))).^2+(111.11*cosd(y(itime2)).*(x(itime(m))-x(itime2))).^2);
                    ii=find(dist==min(dist));
                    if any(ii)
                        ii=ii(1);
                        if dist(ii)<=max_dist%if pass, found an untaken eddy to attach it to
                            id(itime(m))=id(itime2(ii)); %pass the id of the eddy attached to this eddy to this eddy
                            status(itime2(ii))=0; %specify the eddy attached to this eddy as taken
                            status(itime(m))=1; %specify todays eddy as alive
                        else
                            %now look three dt in the past
                            if any(itime3)
                                dist=sqrt((111.11*(y(itime(m))-y(itime3))).^2+(111.11*cosd(y(itime3)).*(x(itime(m))-x(itime3))).^2);
                                ii=find(dist==min(dist));
                                if any(ii)
                                    ii=ii(1);
                                    if dist(ii)<=max_dist%if pass, found an untaken eddy to attach it to
                                        id(itime(m))=id(itime3(ii)); %pass the id of the eddy attached to this eddy to this eddy
                                        status(itime3(ii))=0; %specify the eddy attached to this eddy as taken
                                        status(itime(m))=1; %specify todays eddy as alive
                                    else
                                        id(itime(m))=id_pnt; %give this eddy a new id
                                        id_pnt=id_pnt+1;
                                        status(itime(m))=1; %specify this new eddy as alive
                                    end
                                end
                            else
                                id(itime(m))=id_pnt; %give this eddy a new id
                                id_pnt=id_pnt+1;
                                status(itime(m))=1; %specify this new eddy as alive
                            end
                        end
                    end
                else
                    id(itime(m))=id_pnt; %give this eddy a new id
                    id_pnt=id_pnt+1;
                    status(itime(m))=1; %specify this new eddy as alive
                end
            end
        end
    end
end



%%%%Compute k and threshold

ii=find(~isnan(id));


eddies.x=x(ii);
eddies.y=y(ii);
eddies.id=id(ii);
eddies.eid=eid(ii);
eddies.radius=radius(ii);
eddies.track_jday=track_jday(ii);
eddies.cyc=cyc(ii);
eddies.amp=amp(ii);


figure(1)
clf
pmap(lon,lat,nan*ssh(:,:,1));
hold on
ia=unique(eddies.id(find(eddies.cyc==1)));
ic=unique(eddies.id(find(eddies.cyc==-1)));
for m=1:length(ia)
    ii=find(eddies.id==ia(m));
    m_plot(eddies.x(ii),eddies.y(ii),'r')
    m_plot(eddies.x(ii(1)),eddies.y(ii(1)),'r.','markersize',15)
end

for m=1:length(ic)
    ii=find(eddies.id==ic(m));
    m_plot(eddies.x(ii),eddies.y(ii),'b')
    m_plot(eddies.x(ii(1)),eddies.y(ii(1)),'b.','markersize',15)
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


%function [f,b] = f(lat);% Calculates the Coriolis parameter (f)
% Inputs
% lat = [m,n]
%
% Outputs
% f = coriolis parameter
% b = Beta == df/dy

function [f,b] = f_cor(lat);

omega=2*pi/86400;
re=6371000;

f = 2*omega*sind(lat);


b = (2*omega*cosd(lat))./re;

function fx = dfdx(lat,f,space)
% function fx = dfdx(lat,f,space)
%Uses centered difference
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

for m=1:length(lat(:,1))
    if length(space)>1
        dx=111.11e3*cosd(lat(m,1)).*space(m,1);
    else
        dx=111.11e3*cosd(lat(m,1)).*space;
    end
    
    fx(m,:) = finitediff(f(m,:),dx);
end

function fy = dfdy(f,space)
% function fy = dfdy(f,space)
%Uses centered difference
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

dy=111.11e3.*space;
fy = finitediff(f,dy);

function varargout = finitediff(y,x,varargin)
% function dydx = finitediff(y,x,{'method',bc})
% function [dydx,xx] = finitediff(y,x,'frst')
% function [dydx,dydx_err] = finitediff(y,x,y_err,{x_err,'error','method',bc})
% function [dydx,dydx_err,xx] = finitediff(y,x,y_err,{x_err,'error'},'frst')
%
% first difference estimate and error of dy/dx from y = y(x)
% calculates along 1st non-singleton dimension of x
%   (ie: if x has m rows, derivative is taken along rows of y)
% returns dy/dx, error in dy/dx, and (1st diff. only) xx (new coordinates)
% INPUT arguments (required):
%   x : data coordinates
%       if size(x)==[1 1] then x is the coordinate spacing
%   y : a function of x [y = y(x)]
% INPUT arguments (optional):
%   y_err : error in y (default: errors not calculated)
%   x_err : error in x (default=0)
%       (note that as x_err approaches the grid spacing the errors
%       obtained using the stochastic method get very large!)
%   'error' : method for propogating errors (default='prop')
%       'prop' : std. propogation of errors formulae
%       'rand' : stochastic trials
%   trials : number of stochastic trials (default=1e4) {error='rand' only}
%   'method' : finite difference technique (default='cent')
%       'cent' : centered difference
%       'frst' : first difference
%   bc : cst. boundary condition {method='cent' only}
% OUTPUT arguments (required):
%   dydx : dy/dx (derivative of y w.r.t. x)
% OUTPUT arguments (optional):
%   dydx_err : error in dy/dx (y_err must be input)
%   xx : new data coordinates for derivative {method='frst' only}
%
% if x is a number, y can be any size, ie:
%   if size(x) = [1 1], size(y) = [m 1], [1 n], [m n], [m n p], ...
% if x has 1 non-singleton dimension, y must have that dimension matching, ie:
%   if size(x) = [m 1], size(y) = [m 1], [m n], [m n p], [m 1 p], ...
%   if size(x) = [1 n], size(y) = [1 n], [m n], [m n p], [1 n p], ...
%   if size(x) = [1 1 p], size(y) = [1 1 p], [m 1 p], [1 n p], [m n p] ...
% x n-d, y must have 1st n-dimensions matching, ie:
%   if size(x) = [m 1], size(y) = [m 1], [m n], [m n p] ...
%   if size(x) = [m n], size(y) = [m n], [m n p], ...
%   if size(x) = [m n p], size(y) = [m n p], [m n p q], ...
%
% x_err & y_err must have fewer dimensions than x & y (respectively)
% the common dimensions with (x,y) must be same size, ie:
%   if size(x) = [m n p], size(x_err) = [1 1], [m 1], [m n], [m n p]
%
% copyright (C) S.C.Kennan 1 April 2004
% copyright (C) S.C.Kennan 17 June 2004 (can use 1st difference on edges)

%-----------------------------------------
% check optional inputs and assign values
%-----------------------------------------
% possibilities
METHODS = [{'cent'},{'frst'}];
ERRORS = [{'prop'},{'rand'}];
% defaults
METHOD = METHODS(1); METHOD = METHOD{:};
ERROR = ERRORS(1); ERROR = ERROR{:};
% get optional inputs
NARG = length(varargin);
YE = false; XE = false; DIF = false;    ERR = false;    RAND = false;
MC = false; BC = false; FRST = false;   INVALID = false;
for i=1:NARG,   ARG = varargin{i};
    if BC,  INVALID = true; end
    if  isnumeric(ARG),
        if DIF, if ~FRST,   bc = ARG; BC = true;
            else,       INVALID = true; end
        else,   if (MC | (ERR & ~RAND)), INVALID = true;
            elseif RAND,    trials = ARG; MC = true;
            elseif ~YE, ye = ARG; YE = true;
            elseif ~XE, xe = ARG; XE = true;
            end
        end
    elseif  ischar(ARG),
        if (~DIF & sum(strcmp(METHODS,ARG))),
            METHOD = ARG;   DIF = true;
            if strcmp(METHOD,METHODS(2)),   FRST = true; end
        elseif (YE & sum(strcmp(ERRORS,ARG))),
            ERROR = ARG;    ERR = true;
            if strcmp(ERROR,ERRORS(2)), RAND = true; end
        else    INVALID = true; end
    end
    if INVALID, error('invalid input'); end
end
% if error data was given
if YE, ERR = true; if ~XE, XE = true; xe = 0; end;
    if ~MC, MC = true; trials = 1e4; end; end

% dimensions/sizes
xsize = size(x);    xdims = length(xsize);
ysize = size(y);    ydims = length(ysize);
if (xdims==2 & length(x)==1),   xdims = 0; end
if (xdims==2 & min(xsize)==1),  xdims = 1; end
if (ydims==2 & length(y)==1),   ydims = 0; end
if (ydims==2 & min(ysize)==1),  ydims = 1; end
% if dimensions of x > dimensions y
if (xdims>ydims), error('x dimensions > y dimensions'); end
% y must have be at least 1d
if (ydims<1), error('y must be a vector or matrix'); end
%  error dimensions/sizes
if ERR, xesize = size(xe);  xedims = length(xesize);
    yesize = size(ye);  yedims = length(yesize);
    if (xedims==2 & length(xe)==1),     xedims = 0; end
    if (xedims==2 & min(xesize)==1),    xedims = 1; end
    if (yedims==2 & length(ye)==1),     yedims = 0; end
    if (yedims==2 & min(yesize)==1),    yedims = 1; end
    % if dimensions of xe > dimensions x or y
    if (xedims>xdims), error('x_err dimensions > x dimensions'); end
    if (xedims>ydims), error('x_err dimensions > y dimensions'); end
    % if dimensions of ye > dimensions y
    if (yedims>ydims), error('y_err dimensions > y dimensions'); end
    % make ye,xe have same dimensions as y,x
    xe = matchdim(xe,x);
    ye = matchdim(ye,y);
end

% special case, x is 1x1 (xdims==0) (and xe also)
if (xdims==0), % derivative is taken along 1st non-singleton y-dimension
    xshft = 0;
    [y,yshft] = shiftdim(y);
    if ERR, ye = shiftdim(y,yshft); end
    dx = x;
else, % derivative is taken along 1st non-singleton x-dimension
    [x,xshft] = shiftdim(x);
    xsize = size(x);    xdims = length(xsize);
    [dummy,yshft] = shiftdim(y);
    y = shiftdim(y,xshft);
    if ERR, ye = shiftdim(ye,xshft);
        xe = shiftdim(xe,xshft);
    end
    if FRST,% calculate new coord. now before x changes
        xxsize = xsize;
        xxsize(1) = xxsize(1) - 1;
        xx = (x(2:xsize(1),:) + x(1:xsize(1)-1,:))/2;
        xx = shiftdim(reshape(xx,xxsize),-xshft);
    end
end
% redo sizes and dims
ysize = size(y);    ydims = length(ysize);
if (xdims==2 & min(xsize)==1),  xdims = 1; end
if (ydims==2 & min(ysize)==1),  ydims = 1; end
if (xdims>0),
    % if first xdims dimensions of y don't match x, can't do it
    if (sum(ysize(1:xdims)==xsize)~=xdims), error('x & y do not match');
    end
    % if x & y have different dimensions, make x same as y
    %   x = matchdim(x,y);
    if ERR, xe = matchdim(xe,y); end
end

% if doing stochastic trials, make the trials now
if RAND,% make "trials" randn errors for ea. data
    Ye = (ye(:)*ones(1,trials)).*randn(prod(ysize),trials);
    % add errors to data (have xtra dimension for trials)
    Y = reshape(y(:)*ones(1,trials) + Ye,[ysize,trials]);
    % careful with coordinates - prevent randn from making error too large
    R = randn(prod(ysize),trials); I = find(abs(R)>=1);
    while length(I)>0, R(I) = randn(length(I),1); I = find(abs(R)>=1); end
    if xdims==0,
        X = reshape(x*ones(prod(ysize),trials) + ...
            (xe*ones(prod(ysize),trials)).*R,[ysize,trials]);
    else,   X = reshape(x(:)*ones(1,trials) + ...
            (xe(:)*ones(1,trials)).*R,[ysize,trials]);
    end
end

%----------------------------------------------------------
% differences are taken along 1st non-singleton x-dimension
% the other dimensions get concatenated into columns
%----------------------------------------------------------
if FRST,% first difference
    if xdims>0, dx = x(2:ysize(1),:) - x(1:ysize(1)-1,:); end
    dy = y(2:ysize(1),:) - y(1:ysize(1)-1,:);
    if RAND,
        dX = (X(2:ysize(1),:) - X(1:ysize(1)-1,:))/2;
        dY = (Y(2:ysize(1),:) - Y(1:ysize(1)-1,:))/2;
    elseif ERR,
        if xdims> 0, xe = (xe(2:ysize(1),:) + xe(1:ysize(1)-1,:))/2;
        end
        dye2 = ye(2:ysize(1),:).^2 + ye(1:ysize(1)-1,:).^2;
    end
    ysize(1) = ysize(1) - 1;
else,   % centered difference
    if xdims>0, dx = [ ...
            x(2,:)          - x(1,:)                ; ...
            (x(3:ysize(1),:)    - x(1:ysize(1)-2,:))/2  ; ...
            x(ysize(1),:)       - x(ysize(1)-1,:)       ];
    end
    dy = [  y(2,:)          - y(1,:)                ; ...
        (y(3:ysize(1),:)    - y(1:ysize(1)-2,:))/2  ; ...
        y(ysize(1),:)       - y(ysize(1)-1,:)       ];
    if ~BC, %  use 1st diff. to fill in edges
        tmp = y([2,2:ysize(1)],:) - y([1,1:ysize(1)-1],:);
        I = find(isnan(dy)); if length(I)>0, dy(I) = tmp(I); end
        tmp = y([2:ysize(1),ysize(1)],:) - ...
            y([1:ysize(1)-1,ysize(1)-1],:);
        I = find(isnan(dy)); if length(I)>0, dy(I) = tmp(I); end
    end
    if RAND, dX = [ ...
            X(2,:)          - X(1,:)                ; ...
            (X(3:ysize(1),:)    - X(1:ysize(1)-2,:))/2  ; ...
            X(ysize(1),:)       - X(ysize(1)-1,:)       ];
        dY = [ ...
            Y(2,:)          - Y(1,:)                ; ...
            (Y(3:ysize(1),:)    - Y(1:ysize(1)-2,:))/2  ; ...
            Y(ysize(1),:)       - Y(ysize(1)-1,:)       ];
        if ~BC, %  use 1st diff. to fill in edges
            tmp = (Y([2,2:ysize(1)],:) - Y([1,1:ysize(1)-1],:))/2;
            I = find(isnan(dY)); if length(I)>0, dY(I) = tmp(I); end
            tmp = (Y([2:ysize(1),ysize(1)],:) - ...
                Y([1:ysize(1)-1,ysize(1)-1],:))/2;
            I = find(isnan(dY)); if length(I)>0, dY(I) = tmp(I); end
        end
    elseif ERR, dye2 = [ ... % propogation of errors
            ye(2,:).^2      + ye(1,:).^2        ; ...
            (ye(3:ysize(1),:).^2    + ye(1:ysize(1)-2,:).^2)/4; ...
            ye(ysize(1),:).^2   + ye(ysize(1)-1,:).^2   ];
        if ~BC, %  use 1st diff. to fill in edges
            tmp = ye([2,2:ysize(1)],:).^2 + ...
                ye([1,1:ysize(1)-1],:).^2;
            I = find(isnan(ye)); if length(I)>0, ye(I) = tmp(I); end
            tmp = ye([2:ysize(1),ysize(1)],:).^2 + ...
                ye([1:ysize(1)-1,ysize(1)-1],:).^2;
            I = find(isnan(ye)); if length(I)>0, ye(I) = tmp(I); end
        end
    end
end

% derivative
yx = dy./dx;
if RAND, % reshape so 3rd dim is trials, then take stdev. along 3rd dim
    yxe = std(reshape(dY./dX,[ysize(1),prod(ysize)/ysize(1),trials]),0,3);
elseif ERR, yxe = sqrt(dye2 + 2*((yx.*xe).^2))./dx;
end

% boundary condition
if BC,  yx(1,:) = bc*yx(1,:); yx(ysize(1),:) = bc*yx(ysize(1),:);
    if ERR, yxe(1,:) = bc*yxe(1,:);
        yxe(ysize(1),:) = bc*yxe(ysize(1),:);
    end
end

% put back to original size
yx = reshape(yx,ysize);
if ERR, yxe = reshape(yxe,ysize); end

% use shift to put back any leading singleton dimensions
%if FRST, xx = shiftdim(xx,-xshft); end
if (yshft==xshft),
    yx = shiftdim(yx,-xshft);
    if ERR, yxe = shiftdim(yxe,-xshft); end
    % if y didn't have same no. of leading singleton dimensions
else,   yx = shiftdim(yx,ydims-xshft);  % like a transpose
    yx = shiftdim(yx,-yshft);   % put the leading dims back
    if ERR, yxe = shiftdim(yxe,ydims-xshft);
        yxe = shiftdim(yxe,-yshft);
    end
end

varargout{1} = yx;
if ERR, varargout{2} = yxe; end
if (FRST & xdims>0),
    if ERR, varargout{3} = xx; else, varargout{2} = xx; end;
end






