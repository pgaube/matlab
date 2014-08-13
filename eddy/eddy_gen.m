
%load eddy_tracks_vocals

%find unique ids

unique_id=unique(id);


%find the first day of each unique id

for m=1:length(unique_id)
	fl = find(id==unique_id(m));
	tmp_x=x(fl);
	tmp_y=y(fl);
	gen_x(m)=tmp_x(1);
	gen_y(m)=tmp_y(1);
end

%Now make a map of gen_x and gen_y

min_lon=floor(min(gen_x));
max_lon=ceil(max(gen_x));
min_lat=floor(min(gen_y));
max_lat=ceil(max(gen_y));
lat=min_lat:max_lat;
lon=min_lon:max_lon;
gen_grid=zeros(length(lat),length(lon));

%now round x and y to nearest 1 degree
%now fix the x and y to fit to grid
STEP=[.25 .5 .75 1];

decx= gen_x-floor(gen_x);
decy = abs(gen_y)-floor(abs(gen_y));


for k=1:length(decx)
    if decx(k)<1/1.99
        gen_x(k)=floor(gen_x(k));
     elseif decx(k)>=1/2
         gen_x(k) = floor(gen_x(k))+1;
    end
end    

for k=1:length(decy)
	if decy(k)<1/1.99         
		if gen_y(k)>=0
         	gen_y(k) =floor(gen_y(k));
         	else
         	gen_y(k) =ceil(gen_y(k));
          end
     elseif decy(k)>=1/2
         if gen_y(k)>=0
         	gen_y(k) =floor(gen_y(k))+STEP(1);
         	else
         	gen_y(k) =ceil(gen_y(k))-STEP(1);
          end
     end    
end

%now loop through the grid and count how many eddys start in each point
for r=1:length(lat);
	for c=1:length(lon);
	fla = find(gen_x==lon(c) & gen_y == lat(r));
		if length(fla)>0
			gen_grid(r,c)=length(fla);
		end
	end
end

gGRIDX=lon;
gGRIDY=lat;


figure(1)
max_lat=double(max(lat(:))); 
min_lat=double(min(lat(:))); 
max_lon=double(max(lon(:))); 
min_lon=double(min(lon(:))); 
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon,lat,gen_grid);
m_grid('xtick',[round(min_lon):20:round(max_lon)],'ytick',[round(min_lat):10:round(max_lat)],'tickdir','out','color','k'); 
caxis([0 8])
shading flat
axis image
m_coast('patch',[.5 .5 .5]);
title('Number of Eddies Generated at Each Location')
c=colorbar;
axes(c)
ylabel('Number of Eddies')


save tmp_eddy_gen
