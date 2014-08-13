% % % track eddies in 0.1 degree model
clear all
load ~/matlab/pop/mat/pop_model_domain lon lat z

jdays=[1740:2139]; %this is the whole encilada
clatfac=0.5*pi/180;
im=length(lat(:,1));
jm=length(lon(1,:));
tm=length(jdays);
clatfac=0.5*pi/180;

%%%%
tm=5
%%%%

%%%%
%set thresholds
%%%%

min_amp=3
min_k=4
npt=10    %number of points on each side of eddy centroid used to compute scale
dx=0.1    %grid spacing of ssh fields, in degrees

head='~/matlab/pop/mat/run14_'

%%make arries
[ssh,pdens]=deal(nan(length(lat(:,1)),length(lat(1,:)),length(jdays)));

tic
for m=1:tm; % time
    fname=[head,num2str(jdays(m))]
    if exist([fname,'.mat'])
        load(fname,'hp21_ssh','pdens_anom')
        ssh(:,:,m)=hp21_ssh;
        pdens(:,:,m)=pdens_anom(:,:,9);
        clear hp21_ssh pdens_anom
    end
end
toc


%first find all eddies of the first week
clear aaa cgi cgj agi agj cgs ags ci cj ai aj dist
agn=0; cgn=0; % number of AC and CY, global
it=1;
aaa(1:im,1:jm)=ssh(:,:,it);
for i=3:(im-2)
    ip2=i+2;
    im2=i-2;
    for j=3:(jm-2)
        jp2=j+2;
        jm2=j-2;
        if aaa(i,j)<=-min_amp & aaa(i,j)==min(min(aaa(im2:ip2,jm2:jp2))), % CY center
            cgn=cgn+1;
            cgi(cgn,it)=i;
            cgj(cgn,it)=j; % just record location
            cgs(cgn)=1; % specify status as "alive"
        end;
        if aaa(i,j)>=min_amp & aaa(i,j)==max(max(aaa(im2:ip2,jm2:jp2))), % AC center
            agn=agn+1;
            agi(agn,it)=i; agj(agn,it)=j; % just record location
            ags(agn)=1; % specify status as "alive"
        end;

    end;
end;


% then search the next time level
for it=2:tm;
    an=0; cn=0; % number of AC and CY, this timestep
    aaa(1:im,1:jm)=ssh(:,:,it);
    for i=3:(im-2)
        ip2=i+2;
        im2=i-2;
        for j=3:(jm-2)
            jp2=j+2;
            jm2=j-2;
            if aaa(i,j)<=-min_amp & aaa(i,j)==min(min(aaa(im2:ip2,jm2:jp2))), % CY center
                cn=cn+1;
                ci(cn)=i;
                cj(cn)=j; % just record location
                cs(cn)=1; % specify status as "alive"
            end;
            if aaa(i,j)>=min_amp & aaa(i,j)==max(max(aaa(im2:ip2,jm2:jp2))), % AC center
                an=an+1;
                ai(an)=i;
                aj(an)=j; % just record location
                as(an)=1; % specify status as "alive"
            end;
        end; end;
    % then for the "new" eddies find the closest "alive" global eddy;
    % if within a given distance, assign it as the same global eddy;
    % otherwise specify it as a new global eddy (give it a new id number)
    % specify non-updated global eddies that have vanished as "dead"
    % first search cyclones
    itm1=it-1;
    for kk=1:cgn;
        if cgs(kk)==1,
            for k=1:cn;
                clat=clatfac*(lat(cgi(kk,itm1),1)+lat(ci(k),1)); % radians
                delx=111*cos(clat)*(lon(1,cgj(kk,itm1))-lon(1,cj(k))); % km
                dely=111*(lat(cgi(kk,itm1),1)-lat(ci(k),1));
                dist(k)=sqrt(delx*delx+dely*dely); % km
            end;
            [dmin,k]=min(dist(1:cn)); % find the closest one
            if dist(k)<=100,
                cgi(kk,it)=ci(k);
                cgj(kk,it)=cj(k);
                cs(k)=0; % specify this new eddy as taken
            else
                cgs(kk)=0;
            end % specify this old eddy as dead
        end
    end
    % now assign new eddies
    for k=1:cn;
        if cs(k)==1, % untaken
            cgn=cgn+1;
            cgi(cgn,it)=ci(k);
            cgj(cgn,it)=cj(k); % just record location
            cgs(cgn)=1; % specify status as "alive"
        end;
    end;
    % if an old eddy splits into 2 new ones, it assigns the closer new
    % eddy as the continuation; good
    % if 2 old eddies merge into 1 new eddy, it continues both eddies
    % with the new one; is this ok? or just want to continue the closer (or
    % stronger) one? keep as is for now
    % now do anticyclones
    for kk=1:agn;
        if ags(kk)==1,
            for k=1:an;
                clat=clatfac*(lat(agi(kk,itm1),1)+lat(ai(k),1)); % radians
                delx=111*cos(clat)*(lon(1,agj(kk,itm1))-lon(1,aj(k))); % km
                dely=111*(lat(agi(kk,itm1),1)-lat(ai(k),1));
                dist(k)=sqrt(delx*delx+dely*dely); % km
            end;
            [dmin,k]=min(dist(1:an)); % find the closest one
            if dist(k)<=100,
                agi(kk,it)=ai(k);
                agj(kk,it)=aj(k);
                as(k)=0; % specify this new eddy as taken
            else,
                ags(kk)=0;
            end; % specify this old eddy as dead
        end;
    end;
    % now assign new eddies
    for k=1:an;
        if as(k)==1, % untaken
            agn=agn+1;
            agi(agn,it)=ai(k);
            agj(agn,it)=aj(k); % just record location
            ags(agn)=1; % specify status as "alive"
        end;
    end;
end; % it=2:tm

% get record of ssh, pden at eddy centers
mask(1:im,1:jm)=1; clear aaa bbb cg_ssh cg_pden
clear ag_ssh ag_pden

%first cyclones
cg_ssh=cgi;
cg_pden=cgi;

for k=1:cgn;
    for it=1:tm;
        if cgi(k,it)>0,
            i=cgi(k,it);
            j=cgj(k,it);
            cg_ssh(k,it)=ssh(i,j,it);
            cg_pden(k,it)=pdens(i,j,it);
        end;
    end;
end;

%now annticyclones
ag_ssh=agi;
ag_pden=agi;
for k=1:agn;
    for it=1:tm;
        if agi(k,it)>0,
            i=agi(k,it);
            j=agj(k,it);
            ag_ssh(k,it)=ssh(i,j,it);
            ag_pden(k,it)=pdens(i,j,it);
        end;
    end;
end;

%%now convert into somthing that makes sense to me
%%make arrays
[id,x,y,cyc,track_jday,k]=deal(nan(cgn+agn,1));
%%set counters
st=1;
tid=1;

%first do cyclones
for k=1:cgn
    is1=1; while cgi(k,is1)==0, is1=is1+1; end;
    ie1=tm; while cgi(k,ie1)==0, ie1=ie1-1; end;
    if is1<ie1 & ie1>=min_k
        xx=smooth1d_loess(lon(1,cgj(k,is1:ie1)),is1:ie1,3,is1:ie1);
        yy=smooth1d_loess(lat(cgi(k,is1:ie1),1)',is1:ie1,3,is1:ie1);
        ed=st+length(xx)-1;
        x(st:ed)=xx;
        y(st:ed)=yy;
        id(st:ed)=tid;
        cyc(st:ed)=-1;
        track_jday(st:ed)=jdays(is1:ie1);
        kk(st:ed)=(st:ed)-(st-1);
        amp(st:ed)=cg_ssh(cgi(k,is1:ie1));
        adens(st:ed)=cg_pden(cgi(k,is1:ie1));

        tid=tid+1;
        st=ed+1;
    end
end

%now do anticyclones
for k=1:agn
    is1=1; while agi(k,is1)==0, is1=is1+1; end;
    ie1=tm; while agi(k,ie1)==0, ie1=ie1-1; end;
    if is1<ie1 & ie1>=min_k
        xx=smooth1d_loess(lon(1,agj(k,is1:ie1)),is1:ie1,3,is1:ie1);
        yy=smooth1d_loess(lat(agi(k,is1:ie1),1)',is1:ie1,3,is1:ie1);
        ed=st+length(xx)-1;
        x(st:ed)=xx;
        y(st:ed)=yy;
        id(st:ed)=tid;
        cyc(st:ed)=1;
        track_jday(st:ed)=jdays(is1:ie1);
        kk(st:ed)=(st:ed)-(st-1);
        amp(st:ed)=ag_ssh(agi(k,is1:ie1));
        adens(st:ed)=ag_pden(agi(k,is1:ie1));

        tid=tid+1;
        st=ed+1;
    end
end

k=kk';
id=id';
amp=amp';
adens=adens';
axial_speed=nan*x;
scale=nan*x;

%%%%now compute U and Ls
for it=1:tm;
    tic
    spd=9.81*sqrt(dfdx(lat,ssh(:,:,it),.1).^2+dfdy(ssh(:,:,it),.1).^2)./f_cor(lat); %cm/s
    
    ii=find(track_jday==jdays(it));
    for k=1:length(ii)
        clear lastx lasty lastspd
        if ~isnan(x(ii(k))) & ~isnan(y(ii(k)))
            [r,c]=imap(y(ii(k))-.05,y(ii(k))+.05,x(ii(k))-.05,x(ii(k))+.05,lat,lon);
            r=r(1)-npt:r(1)+npt;
            c=c(1)-npt:c(1)+npt;
            if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
                tssh=ssh(r,c,it);
                tlat=lat(r,1);
                tlon=lon(1,c);
                mask=nan*tssh;
                if cyc(ii(k))==-1
                    mask(tssh<0)=1;
                else
                    mask(tssh>0)=1;
                end
                tspd=spd(r,c).*mask;
                tssh=tssh.*mask;
                C=contourc(tlon,tlat,tspd,[200:-1:1]);
                if length(C(1,:))>5
                    tmp=nan*C;
                    st=2;
                    ed=C(2,1)+1;
                    %find closed contours
                    while ed<length(C(1,:))
                        if C(1,st)==C(1,ed) & C(2,st)==C(2,ed)
                            tmp(1,st-1:ed+1)=C(1,st-1:ed+1);
                            tmp(2,st-1:ed+1)=C(2,st-1:ed+1);
                            st=ed+2;
                            ed=st-1+C(2,st-1);
                        else
                            st=ed+2;
                            ed=st-1+C(2,st-1);
                        end
                    end
                    %find fastest closed contour
                    st=2;
                    ed=tmp(2,1)+1;
                    while ed<length(tmp(1,:))
                        if ~isnan(tmp(1,st)) & ...
                                min(tmp(1,st:ed))<=x(ii(k)) & ...
                                max(tmp(1,st:ed))>=x(ii(k)) & ...
                                min(tmp(2,st:ed))<=y(ii(k)) & ...
                                max(tmp(2,st:ed))>=y(ii(k))
                            
                            lastspd=tmp(1,st-1);
                            lastx=tmp(1,st:ed);
                            lasty=tmp(2,st:ed);
                            st=ed+2;
                            ed=st-1+tmp(2,st-1);
                        else
                            st=ed+2;
                            ed=st-1+tmp(2,st-1);
                        end
                    end
                    if exist('lastspd')
                        %find area enclode by contour
                        [tlon,tlat]=meshgrid(tlon,tlat);
                        [inmask,onmask] = inpolygon(tlon,tlat,lastx,lasty);
                        inmask(onmask==1)=1;
                        nmask=nan*mask;
                        nmask(inmask==1)=1;
                        area=(111.11*dx)*(111.11*dx*cosd(tlat));
                        tt=area.*nmask;
                        in_area=nansum(tt(:));
                        scale(ii(k))=sqrt(in_area./pi);
                        axial_speed(ii(k))=lastspd;
                        
                        %                     figure(1)
                        %                     clf
                        %                     pcolor(tlon,tlat,tspd);shading flat;axis image
                        %                     hold on
                        %                     plot(x(ii(k)),y(ii(k)),'k*')
                        %                     contour(tlon,tlat,tspd,[200:-1:1],'b');
                        %                     caxis([0 20])
                        %                     plot(lastx,lasty,'k')
                        %                     title(['Ls = ',num2str(scale(ii(k))),' km, U = ',num2str(axial_speed(ii(k)))])
                        %                     xlabel(['cyc = ',num2str(cyc(ii(k)))])
                        %                     pause(1)
                        %                     clear lastx lasty lastspd
                    end
                end
            end
        end
    end
    toc
end

return


save pop_run14_tracks2 x y id cyc track_jday k amp adens

%%plot
figure(4)
clf
pmap(lon,lat,nan(length(lat(:,1)),length(lon(1,:))))
hold on
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    if cyc(ii(1))==1
        m_plot(x(ii),y(ii),'r')
    else
        m_plot(x(ii),y(ii),'k')
    end
end
set(gca,'tickdir','out','fontsize',15);
xlabel('Longitude')
ylabel('Latitude')
title('Run 33, Yr 18, day 120-275: C (k), A (r)')