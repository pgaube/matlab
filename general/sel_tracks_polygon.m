%select tracks within a polygon
load ~/data/eddy/v5/global_tracks_v5

lat=-80:80;
lon=0:360;
load ~/data/gsm/cor_chl_ssh_out.mat lat lon cor_0

figure(1)
clf
pmap(lon,lat,cor_0);caxis([-.5 .5])
%pmap(lon,lat,nan(length(lat),length(lon)));

reply = input('Zoom if you want, type D when done:','s');

zz=ginput;
[blon,blat]=m_xy2ll(zz(:,1),zz(:,2))

blon(end+1)=blon(1);
blat(end+1)=blat(1);

h=m_patch(blon,blat,'b');
drawnow

in = inpolygon(x,y,blon,blat);

ii=find(in==1);


amp         =   amp(ii);            
axial_speed =   axial_speed(ii);       
cyc         =   cyc(ii);      
eid         =   eid(ii);    
id          =   id(ii);                    
k           =   k (ii);             
scale       =   scale (ii);              
track_jday  =   track_jday(ii);   
x           =   x(ii);
y           =   y(ii);

ia=find(cyc==1);
ic=find(cyc==-1);
uid=unique(id);
uia=unique(id(ia));
uic=unique(id(ic));

figure(2)
clf
lon=min(x)-5:max(x)+5;
lat=min(y)-5:max(y)+5;
pmap(lon,lat,nan(length(lat),length(lon)));
for m=1:length(uia)
    ii=find(id==uia(m));
    m_plot(x(ii),y(ii),'r')
end
for m=1:length(uic)
    ii=find(id==uic(m));
    m_plot(x(ii),y(ii),'b')
end


clear lat lon blon h in ii zz reply
