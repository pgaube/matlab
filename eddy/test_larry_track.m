
%first load ssh data
%
jdays=2448910:7:2448910+(7+52);
%jdays=2452130:7:2455539;
spath='~/data/eddy/V5/mat/AVISO_25_W_';

load ~/matlab/domains/new_opac_lat_lon
dlon=lon;
dlat=lat;

load([spath '2454713'],'lat','lon')
[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
lon=lon(r,c);
lat=lat(r,c);

SSH=nan(length(r),length(c),length(jdays));

for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
        SSH(:,:,m)=fillnans(ssh(r,c));
%         figure(1)
%         clf
%         pmap(lon,lat,SSH(:,:,m))
%         drawnow
end
load ~/data/eddy/V5/global_tracks_V5 x y id cyc k track_jday
ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat) & track_jday>=min(jdays) & track_jday<=max(jdays));
x=x(ii);
y=y(ii);
id=id(ii);
cyc=cyc(ii);
k=k(ii);
track_jday=track_jday(ii);

save ssh_and_tracks_opac SSH lat lon x y id cyc k track_jday r c jdays
%}
  

clear
load ssh_and_tracks_opac


jm=length(c);
im=length(r);

lat=lat(:,1);
lon=lon(1,:);
clatfac=0.5*pi/180;
agn=0; cgn=0; % number of AC and CY, global
it=1;
jm=length(r);
im=length(c);
tm=length(jdays);
aaa(1:im,1:jm)=SSH(:,:,it)';
for i=3:(im-2); ip2=i+2; im2=i-2; 
  for j=3:(jm-2); jp2=j+2; jm2=j-2;
    if aaa(i,j)<=-1 & aaa(i,j)==min(min(aaa(im2:ip2,jm2:jp2))), % CY center
       cgn=cgn+1;
       cgi(cgn,it)=i; cgj(cgn,it)=j; % just record location
       cgs(cgn)=1; % specify status as "alive"
    end;
    if aaa(i,j)>=1 & aaa(i,j)==max(max(aaa(im2:ip2,jm2:jp2))), % AC center
       agn=agn+1;
       agi(agn,it)=i; agj(agn,it)=j; % just record location
       ags(agn)=1; % specify status as "alive"
    end;     
end; end;
% then search the next time level
for it=2:tm;
  an=0; cn=0; % number of AC and CY, this timestep
  aaa(1:im,1:jm)=SSH(:,:,it)';
  for i=3:(im-2); ip2=i+2; im2=i-2; 
    for j=3:(jm-2); jp2=j+2; jm2=j-2;
      if aaa(i,j)<=-1 & aaa(i,j)==min(min(aaa(im2:ip2,jm2:jp2))), % CY center
         cn=cn+1;
         ci(cn)=i; cj(cn)=j; % just record location
         cs(cn)=1; % specify status as "alive"
      end;
      if aaa(i,j)>=1 & aaa(i,j)==max(max(aaa(im2:ip2,jm2:jp2))), % AC center
         an=an+1;
         ai(an)=i; aj(an)=j; % just record location
         as(an)=1; % specify status as "alive"
      end;     
  end; end;
  % then for the "new" eddies find the closest "alive" global eddy;
  % if within a given distance, assign it as the same global eddy; 
  % otherwise specify it as a new global eddy (give it a new id number)
  % specify non-updated global eddies that have vanished as "dead"
  % first search cyclones
  itm1=it-1; 
  for kk=1:cgn; if cgs(kk)==1,
    for k=1:cn;
        clat=clatfac*(lat(cgj(kk,itm1))+lat(cj(k))); % radians
        delx=111*cos(clat)*(lon(cgi(kk,itm1))-lon(ci(k))); % km
        dely=111*(lat(cgj(kk,itm1))-lat(cj(k)));
        dist(k)=sqrt(delx*delx+dely*dely); % km
    end;     
    [dmin,k]=min(dist(1:cn)); % find the closest one
    if dist(k)<=100,
       cgi(kk,it)=ci(k); cgj(kk,it)=cj(k);
       cs(k)=0; % specify this new eddy as taken
    else, cgs(kk)=0; end; % specify this old eddy as dead
  end; end;
  % now assign new eddies
  for k=1:cn; if cs(k)==1, % untaken
    cgn=cgn+1;
    cgi(cgn,it)=ci(k); cgj(cgn,it)=cj(k); % just record location
    cgs(cgn)=1; % specify status as "alive"    
  end; end;
  % if an old eddy splits into 2 new ones, it assigns the closer new
  % eddy as the continuation; good
  % if 2 old eddies merge into 1 new eddy, it continues both eddies
  % with the new one; is this ok? or just want to continue the closer (or
  % stronger) one? keep as is for now
  % now do anticyclones
  for kk=1:agn; if ags(kk)==1,
    for k=1:an;
        clat=clatfac*(lat(agj(kk,itm1))+lat(aj(k))); % radians
        delx=111*cos(clat)*(lon(agi(kk,itm1))-lon(ai(k))); % km
        dely=111*(lat(agj(kk,itm1))-lat(aj(k)));
        dist(k)=sqrt(delx*delx+dely*dely); % km
    end;     
    [dmin,k]=min(dist(1:an)); % find the closest one
    if dist(k)<=100,
       agi(kk,it)=ai(k); agj(kk,it)=aj(k);
       as(k)=0; % specify this new eddy as taken
    else, ags(kk)=0; end; % specify this old eddy as dead
  end; end;
  % now assign new eddies
  for k=1:an; if as(k)==1, % untaken
    agn=agn+1;
    agi(agn,it)=ai(k); agj(agn,it)=aj(k); % just record location
    ags(agn)=1; % specify status as "alive"    
  end; end;
end; % it=2:tm
%}  

%now get rid of all eddies with lifetimes less than 4 weeks
for kk=1:agn
    age=length(find(agi(kk,:)>0))
    if age<6
        agi(kk,:)=0;
        agj(kk,:)=0;
    end
end
for kk=1:cgn
    age=length(find(cgi(kk,:)>0));
    if age<6
        cgi(kk,:)=0;
        cgj(kk,:)=0;
    end
end

% plot the tracks of all the eddies

figure(1); clf
subplot(211)
hold on
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    if cyc(ii(1))==1
        plot(x(ii),y(ii),'r')
    else
        plot(x(ii),y(ii),'b')
    end
end
axis([200 250 -25 -15])

set(gca,'tickdir','out','fontsize',15);
xlabel('Longitude')
ylabel('Latitude')
title('Mikes tracks')

subplot(212)
for k=1:cgn; 
    ii=find(cgi(k,:)>0);
    jj=find(cgj(k,:)>0);
    plot(lon(cgi(k,ii)),lat(cgj(k,jj)),'b'); hold on
end; 

for k=1:agn; 
    ii=find(agi(k,:)>0);
    jj=find(agj(k,:)>0);
    plot(lon(agi(k,ii)),lat(agj(k,jj)),'r'); hold on
end; 
set(gca,'tickdir','out','fontsize',15);
axis([200 250 -25 -15])
xlabel('Longitude')
ylabel('Latitude')
title('Larrys tracks)')
%  print -dpng eddy_tracks1.png
  