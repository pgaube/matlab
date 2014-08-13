function hm=pmap(varargin) 
%function h=pmap(lon,lat,data,TYPE,DATE)
load chelle.pal
load bwr.pal
load bwy.pal
load rwp.pal

if nargin == 3
	lon = double(varargin{1});
	lat = double(varargin{2});
	data = double(varargin{3});
	TYPE = 'blank';
	s=datevec(date);
else

lon = double(varargin{1});
lat = double(varargin{2});
data = double(varargin{3});
TYPE = varargin{4};
s=datevec(date);

if nargin == 5
   tmp = varargin{5};
   [month,day,year] = jul2date(str2num(tmp(5:7)),str2num(tmp(1:4)));
   dlabel = [num2str(year) '-' num2str(month) '-' num2str(day)];
   ydlabel = dlabel;
   
else
   dlabel=[num2str(s(1)) '-' num2str(s(2)) '-' num2str(s(3))];
   ydlabel=[num2str(s(1)) '-' num2str(s(2)) '-' num2str(s(3)-1)];
   tmp = num2str((s(1)*1000)+julian(s(2),s(3),s(1),s(1)));
end
end
ctmp=num2str((s(1)*1000)+julian(s(2),s(3),s(1),s(1)));


max_lat=max(lat(:)); 
min_lat=min(lat(:)); 
max_lon=max(lon(:)); 
min_lon=min(lon(:)); 
rlat=max_lat-min_lat;
rlon=max_lon-min_lon;

if rlat<=15
	lat_step=2;
	elseif (rlat > 15 & rlat <=40)
	lat_step=5;
	elseif (rlat > 40 & rlat <=60)
	lat_step=10;
	else
	lat_step = 20;
end


if rlon<=5
    lon_step=1;
	elseif (rlon > 5 & rlon <=20)
    lon_step=5;
	elseif (rlon > 20 & rlon <=40)
	lon_step=10;
	elseif (rlon > 40 & rlon <=100)
	lon_step=15;
	elseif (rlon > 100 & rlon <=180)
	lon_step = 25;
	else
	lon_step = 40;
end



min_c=18;
max_c=23;
fixed_min_c=10;
fixed_max_c=25;
yyyy=[min_c:2:max_c];
yyyylab=[min_c:2:max_c];

h=gca;
%if TYPE~= 'nolab'
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
hm=gca;
set(hm,'clipping','off')
hold on
%end
switch TYPE

case {'gumby'}
    clf
    m_pcolor(lon,lat,data);
    shading interp
   	colormap(chelle)
    m_gshhs_f('patch',[.5 .5 .5])
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  

    grid
    %title({'Blank Domain'}
    
case {'burk'}
    clf
    m_proj('UTM','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
	m_pcolor(lon,lat,data);
    %m_contourf(lon,lat,data);
    shading interp
   	colormap(chelle)
	m_gshhs_f('patch','k')
    %m_coast('patch',[0 0 0]);
    m_grid('xtick',[round(min_lon):1/6:round(max_lon)],'ytick',[round(min_lat):1/6:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  

    
    %title({'Blank Domain'})    
case {'stereo'}
    clf
    m_proj('stereographic','lat',-90,'long',0,'radius',50);
    m_pcolor(lon,lat,data);
    shading interp
    m_coast('patch',[0 0 0]);
    m_grid('xtick',[-180:20:180],'ytick',[-80:10:-40],'tickdir','in','color','k','lineweight',1.5);  
	grid
    title({'Blank Domain'})
    c=colorbar('horiz');
    %set(c,'position',[.15 .15 .74 .025])
case {'blankcb'}
    m_pcolor(lon,lat,data);
    shading interp
   
    m_coast('patch',[0 0 0]);
     grid
     title({'Blank Domain'})
     c=colorbar('horiz');
     set(c,'position',[.15 .15 .74 .025])
case {'blank'}
    m_pcolor(lon,lat,data);
    %m_contourf(lon,lat,data);
    shading interp
   	colormap(chelle)
    %m_gshhs_f('patch',[.5 .5 .5])
    m_coast('patch',[0 0 0]);
    grid
    %title({'Blank Domain'})  
    
case {'gs'}
    clf
    m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
    m_pcolor(lon,lat,data);
    %m_contourf(lon,lat,data);
    shading interp
   	colormap(chelle)
    m_gshhs_f('patch',[.5 .5 .5])
%     m_coast('patch',[0 0 0]);
    m_grid('xtick',[285:5:350],'ytick',[30:2.5:50],'tickdir','in','color','k','lineweight',1.5);  

    grid
    %title({'Blank Domain'})  
    
case {'blank_hr'}
    clf
    m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    m_pcolor(lon,lat,data);
    %m_contourf(lon,lat,data);
    shading interp
   	colormap(chelle)
	m_gshhs_f('patch','k')
    %m_coast('patch',[0 0 0]);
    %grid
    %title({'Blank Domain'})      
case {'argo_r'}
    x=data(:,1);
    y=data(:,2);
    for m=1:length(x)
    	m_plot(x(m),y(m),'r.','markersize',2)
    end	

    %m_gshhs_f('patch',[.5 .5 .5])
    m_coast('patch',[0 0 0]);
    grid
    %title({'Blank Domain'})  
case {'argo_b'}
    x=data(:,1);
    y=data(:,2);
    for m=1:length(x)
    	m_plot(x(m),y(m),'b.','markersize',2)
    end	

    %m_gshhs_f('patch',[.5 .5 .5])
    m_coast('patch',[0 0 0]);
    grid
    %title({'Blank Domain'}) 
case {'argo_k'}
    x=data(:,1);
    y=data(:,2);
    for m=1:length(x)
    	m_plot(x(m),y(m),'k.','markersize',2)
    end	

    %m_gshhs_f('patch',[.5 .5 .5])
    m_coast('patch',[0 0 0]);
    grid
    %title({'Blank Domain'})     
case {'nolab'}
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    %m_pcolor(lon,lat,data);
    %shading flat
    m_coast('patch',[0 0 0]);
    title({'Blank Domain'})  
    set(gca,'YTickLabel',[],'XTickLabel',[])
case {'idmask'}
   m_pcolor(lon,lat,data);
   shading flat
   m_coast('patch',[0 0 0]);
   grid
   title({'Eddy Mask'})

case {'f/h'}
    m_contour(lon,lat,data,[6e-9:1e-9:1.5e-8])
    m_coast('patch',[.5 .5 .5])
    grid
    title({'f/h'})
    
case {'f/h_k'}
    m_contour(lon,lat,data,[6e-9:2e-9:1.5e-8],'k')
    m_coast('patch',[.5 .5 .5])
    grid
    title({'f/h'})
    
case {'tracks'}
	
	set(gcf,'clipping','off')
    nneg=1;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    jdays=data(:,4);
    [jdays,is]=sort(jdays);
    x=x(is);
    y=y(is);
    id=id(is);
    cid=find(id<nneg);
    aid=find(id>=nneg);
    cunique=unique(id(cid));
    cx=x(cid);
    cy=y(cid);
    aunique=unique(id(aid));
    ax=x(aid);
    ay=y(aid);
    hold on
    %m_pcolor(x,y,amp);
    for m=1:length(cunique)
        r=find(id(cid)==cunique(m));
        bx=cx(r);
        by=cy(r);
        df=bx(2:end)-bx(1:end-1);
		ix=find(df>100);
		if any(ix)
			bx(1:ix)=bx(1:ix)+360;
		end
		m_plot(cx(r),cy(r),'b')
   	end
    for m=1:length(aunique)
         r=find(id(aid)==aunique(m));
         rx=ax(r);
         ry=ay(r);
         df=rx(2:end)-rx(1:end-1);
		 ix=find(df>100);
		 if any(ix)
			rx(1:ix)=rx(1:ix)+360;
		 end
		 m_plot(ax(r),ay(r),'r')
    end
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    %m_gshhs_f('patch',[.5 .5 .5])
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
    title({'Eddy Tracks  ',[num2str(length(cunique)) ' Cyclones in Blue, '...
           num2str(length(aunique)) ' Anticyclones in Red   ']})   
           
 
case {'tracks_starts'}
	
	set(gcf,'clipping','off')
    nneg=1;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    jdays=data(:,4);
    k=data(:,5);
    %{
    [jdays,is]=sort(jdays);
    x=x(is);
    y=y(is);
    id=id(is);
    k=k(is);
    %}
    cid=find(id<nneg);
    aid=find(id>=nneg);
    cunique=unique(id(cid));
    cx=x(cid);
    cy=y(cid);
    ck=k(cid);
    aunique=unique(id(aid));
    ax=x(aid);
    ay=y(aid);
    ak=k(aid);
    hold on
    %m_pcolor(x,y,amp);
    for m=1:length(cunique)
        r=find(id(cid)==cunique(m));
        bx=cx(r);
        by=cy(r);
        df=bx(2:end)-bx(1:end-1);
		ix=find(df>100);
		if any(ix)
			bx(1:ix)=bx(1:ix)+360;
		end
		m_plot(cx(r),cy(r),'b')
		m_plot(cx(r(1)),cy(r(1)),'b.','markersize',10)
   	end
    for m=1:length(aunique)
         r=find(id(aid)==aunique(m));
         rx=ax(r);
         ry=ay(r);
         df=rx(2:end)-rx(1:end-1);
		 ix=find(df>100);
		 if any(ix)
			rx(1:ix)=rx(1:ix)+360;
		 end
		 m_plot(ax(r),ay(r),'r')
		 m_plot(ax(r(1)),ay(r(1)),'r.','markersize',10)		 
    end
    
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    %m_gshhs_f('patch',[.5 .5 .5])
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
    title({'Eddy Tracks  ',[num2str(length(cunique)) ' Cyclones in Blue, '...
           num2str(length(aunique)) ' Anticyclones in Red   ']})   
           
  
           
case {'new_tracks'}
	
	%clf
	%m_proj('Miller','lon',100,'lat',60);   
	%colormap('jet');
	%m_grid('linestyle','none','box','fancy','tickdir','out');	
	set(gcf,'clipping','off')
    nneg=1;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    cyc=data(:,4);
    jdays=data(:,5);
    k=data(:,6);
    %prevent overlap over boundary
    fd=find(x>359);
    x(fd)=nan;
    %
    [jdays,is]=sort(jdays);
    x=x(is);
    y=y(is);
    id=id(is);
    k=k(is);
    cyc=cyc(is);
    ujd=unique(jdays);
    for qq=1:length(ujd)
		dd=find(jdays==ujd(qq) & k==1);
		uid=unique(id(dd));
		for m=1:length(uid);
			ii=find(id==uid(m));
			if cyc(ii(1))>=1
				m_plot(x(ii),y(ii),'r','linewidth',.1)
			else
				m_plot(x(ii),y(ii),'b','linewidth',.1)
			end
		end
	end  	
	%{
	for m=1:length(uid);
			ii=find(id==uid(m));
			fd=find(x(ii)>360);
			if ~exists(fd)
				if cyc(ii(1))>=1
					m_plot(x(ii),y(ii),'r','linewidth',.1)
				else
					m_plot(x(ii),y(ii),'b','linewidth',.1)
				end
			else
				xxx=x(ii);
				yyy=y(ii);
				dsp=find(xxx>200);
				
		end
		%}
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
           

case {'new_tracks_starts'}
	
	%clf
	%m_proj('Miller','lon',100,'lat',60);   
	%colormap('jet');
	%m_grid('linestyle','none','box','fancy','tickdir','out');	
	set(gcf,'clipping','off')
    nneg=1;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    cyc=data(:,4);
    jdays=data(:,5);
    k=data(:,6);
    [jdays,is]=sort(jdays);
    x=x(is);
    y=y(is);
    id=id(is);
    k=k(is);
    cyc=cyc(is);
    ujd=unique(jdays);
    for qq=1:length(ujd)
		dd=find(jdays==ujd(qq) & k==1);
		uid=unique(id(dd));
		for m=1:length(uid)
			ii=find(id==uid(m));
			if cyc(ii(1))>=1
				m_plot(x(ii),y(ii),'r','linewidth',.1)
			else
				m_plot(x(ii),y(ii),'b','linewidth',.1)
			end
			if cyc(ii(1))>=1
				m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
				m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
			else
				m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
				m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
			end
		end
	end  	
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
           
           
case {'new_track_dots'}
	
	%clf
	%m_proj('Miller','lon',100,'lat',60);   
	%colormap('jet');
	%m_grid('linestyle','none','box','fancy','tickdir','out');	
	set(gcf,'clipping','off')
    nneg=1;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    cyc=data(:,4);
    jdays=data(:,5);
    k=data(:,6);
    [jdays,is]=sort(jdays);
    x=x(is);
    y=y(is);
    id=id(is);
    k=k(is);
    cyc=cyc(is);
    ujd=unique(jdays);
    for qq=1:length(ujd)
		dd=find(jdays==ujd(qq) & k==1);
		uid=unique(id(dd));
		for m=1:length(uid)
			ii=find(id==uid(m));
			if max(x(ii))<364 & min(x(ii))>1
			   if cyc(ii(1))>=1
				   m_plot(x(ii),y(ii),'r','linewidth',.001)
			   else
				   m_plot(x(ii),y(ii),'b','linewidth',.001)
			   end
			end
		end
	end  	
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
                      
           
case {'tracks_big_dots'}
	
	set(gcf,'clipping','off')
    nneg=1;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    %amp=data(:,4);
    cid=find(id<nneg);
    aid=find(id>=nneg);
    cunique=unique(id(cid));
    cx=x(cid);
    cy=y(cid);
    aunique=unique(id(aid));
    ax=x(aid);
    ay=y(aid);
    hold on
    %m_pcolor(x,y,amp);
   for m=1:length(cunique)
        r=find(id(cid)==cunique(m));
        m_plot(cx(r),cy(r),'b.','markersize',4)
   end
    for m=1:length(aunique)
         r=find(id(aid)==aunique(m));
         m_plot(ax(r),ay(r),'r.','markersize',4)
    end
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
    %title({'Eddy Tracks  ',[num2str(length(cunique)) ' Cyclones in Blue, '...
    %       num2str(length(aunique)) ' Anticyclones in Red   ']})   
                      
case {'tracks_old'}
	
	set(gcf,'clipping','off')
    nneg=71893;
    x=data(:,1);
    y=data(:,2);
    id=data(:,3);
    %amp=data(:,4);
    cid=find(id<nneg);
    aid=find(id>=nneg);
    cunique=unique(id(cid));
    cx=x(cid);
    cy=y(cid);
    aunique=unique(id(aid));
    ax=x(aid);
    ay=y(aid);
    hold on
    %m_pcolor(x,y,amp);
   for m=1:length(cunique)
        r=find(id(cid)==cunique(m));
        m_plot(cx(r),cy(r),'b.','markersize',.5)
   end
    for m=1:length(aunique)
         r=find(id(aid)==aunique(m));
         m_plot(ax(r),ay(r),'r.','markersize',.5)
    end
    %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat): ...
    %        2:round(max_lat)],'tickdir','out','color','k');
    grid
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
    %        2);
    hold off
    title({'Eddy Tracks  ',[num2str(length(cunique)) ' Cyclones in Blue, '...
           num2str(length(aunique)) ' Anticyclones in Red   ']})              
           
case {'topo'}
     %m_proj('Equidistant Cylindrical',...
     %       'lon',[min_lon max_lon],'lat',[min_lat max_lat]);
     m_pcolor(lon,lat,data);
     %m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat):
     %               2:round(max_lat)],'tickdir','out','color','k');
     shading flat
     colormap(summer)
     caxis([0 6000])
     c=colorbar('horiz');
     grid
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('m')
     hold off
case {'bath'}
     m_pcolor(lon,lat,data);
     shading flat
     m_coast('patch',[0 0 0]);
     colormap(jet)
     caxis([-7000 0])
     c=colorbar('horiz');
     grid
     title({'Bathymetery'})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('m')
     hold off
  case {'logmerchl'}
    clf
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,log10(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    set(gca,'Clim',log10([0.01 10]))
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Log_{10} of Chlorophyll Concentration','Merged MODIS-Aqua & SeaWiFS', ...
    	   ydlabel},'color','w')
    Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    %axes(c);
    set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
          'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    hold off  

  case {'merchl_filled'}
    clf
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                            ...
                            max_lat]);
            m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
                   ...
            [round(min_lat):lat_step:round(max_lat)],'tickdir','out', ...
                'color','w','fontsize',8);
            grid off
            hold on
            m_pcolor(lon,lat,data);
            set(gcf,'color','k')
            set(gcf, 'InvertHardCopy', 'off');
            shading flat
            colormap(chelle)
            set(gca,'Clim',log10([0.01 10]))
            %c=colorbar('horiz');
            hold on
            %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
            %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
            %m_gshhs_h
            m_coast('color','w');
            %m_plot(275,-20,'+k','linewidth',2)
            %m_plot(285,-20,'+k','linewidth',2)
            grid
            title({'Log_{10} of Chlorophyll Concentration over Seasonal Cycle',...
                   'Merged MODIS-Aqua & SeaWiFS',ydlabel},'color','w')
            Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
            %axes(c);
            %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
            %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
            %xlabel('mg m^{-3}','color','w')
            hold off
            %                

 case {'mchlss'}
    clf
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out', ...
           'color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    %set(gca,'Clim',log10([0.01 10]))
    caxis([-2 1])
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Seasonal Cycle of Chlorophyll Concentration',...
           'MODIS-Aqua 4km',ydlabel},'color','w')
    Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    %axes(c);
    %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    hold off


 case {'mchlanom'}
    
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out', ...
           'color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    %set(gca,'Clim',log10([0.01 10]))
    caxis([-.4 .4])
    %c=colorbar
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Chlorophyll Concentration Anomaly','MODIS-Aqua 4km', ...
           ydlabel},'color','w')
    %Tick=[-.4:.2:.4];
    %axes(c);
    %set(c,'XTick',Tick,'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %set(c,'position',[.15 .15 .74 .025],'XTick',Tick,...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %ylabel('mg m^{-3}','color','w')
    hold off
    
    
  case {'schlanom'}
    
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out', ...
           'color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    %set(gca,'Clim',log10([0.01 10]))
    caxis([-.4 .4])
    %c=colorbar
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Chlorophyll Concentration Anomaly','SeaWiFS', ...
           ydlabel},'color','w')
    %Tick=[-.4:.2:.4];
    %axes(c);
    %set(c,'XTick',Tick,'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %set(c,'position',[.15 .15 .74 .025],'XTick',Tick,...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %ylabel('mg m^{-3}','color','w')
    hold off   


 case {'mchl'}
    clf
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w');
    grid off
    hold on
    m_pcolor(lon,lat,data);
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    set(gca,'Clim',log10([0.01 10]))
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Log_{10} of Chlorophyll Concentration','MODIS-Aqua 4km', ...
    	   ydlabel},'color','w')
    Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    %axes(c);
    %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    hold off
    
     case {'mchl_filled'}
    clf
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    set(gca,'Clim',log10([0.02 7]))
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Log_{10} of Chlorophyll Concentration Over Seasonal Cycle','MODIS-Aqua 4km', ...
    	   ydlabel},'color','w')
    Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    %axes(c);
    %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    hold off
    
    
 case {'logschl'}
    clf
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(log10(data)));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    set(gca,'Clim',log10([0.01 10]))
    %c=colorbar('horiz');
    %c=colorbar
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Log_{10} of Chlorophyll Concentration','SeaWiFS 9km', ...
    	   ydlabel},'color','w')
    %Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    Tick=[.01 .1 .5 1 10];
    %axes(c);
    %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    %set(c,'YTick',log10(Tick),...
    %      'YTickLabel', Tick,'xcolor','w','ycolor','w');
    %ylabel('mg m^{-3}','color','w')
    hold off
    
    case {'schl'}
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading interp
    colormap(chelle)
    set(gca,'Clim',log10([0.01 10]))
    %c=colorbar('horiz');
    %c=colorbar
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    %m_gshhs_f('patch',[1 1 1])
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title('SeaWiFS   ','color','w')
    %Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    Tick=[.01 .1 .5 1 10];
    %axes(c);
    %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    %set(c,'YTick',log10(Tick),...
    %      'YTickLabel', Tick,'xcolor','w','ycolor','w');
    %ylabel('mg m^{-3}','color','w')
    hold off
    
    case {'cc'}
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(data));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    caxis([0 .03])
    %c=colorbar('horiz');
    %c=colorbar
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title('GSM CHL:C   ','color','w')
    %Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    Tick=[.01 .1 .5 1 10];
    %axes(c);
    %set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    %set(c,'YTick',log10(Tick),...
    %      'YTickLabel', Tick,'xcolor','w','ycolor','w');
    %ylabel('mg m^{-3}','color','w')
    hold off
    
    case {'logmchl'}
    clf
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    grid off
    hold on
    m_pcolor(lon,lat,double(log10(data)));
    set(gcf,'color','k')
    set(gcf, 'InvertHardCopy', 'off');
    shading flat
    colormap(chelle)
    set(gca,'Clim',log10([0.035 7]))
    %c=colorbar('horiz');
    %c=colorbar
    hold on
    %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
    %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
    %m_gshhs_h
    m_coast('color','w');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Log_{10} of Chlorophyll Concentration','MODIS-Aqua 4km', ...
    	   ydlabel},'color','w')
    %Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    %Tick=[.04 .1 .5 1 7];
    %axes(c);
    %set(c,'position',[.15 .01 .74 .01],'XTick',log10(Tick),...
    %      'XTickLabel', Tick,'xcolor','w','ycolor','w');
    %xlabel('mg m^{-3}','color','w')
    %set(c,'YTick',log10(Tick),...
    %      'YTickLabel', Tick,'xcolor','w','ycolor','w');
    %ylabel('mg m^{-3}','color','w')
    hold off


     case {'chl'}
    m_pcolor(lon,lat,data);
    shading flat
    colormap(chelle)
    caxis([0 .6])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
     %clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
     m_coast
     %m_coast('patch',[0 0 0]);
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Chlorophyll Concentration from MODIS-Aqua',ydlabel})
     axes(c);
     set(c,'position',[.15 .05 .74 .025]);
     xlabel('mg m^{-3}')
     hold off
  case {'chl8'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .8])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
     clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     m_coast('patch',[.5 .5 .5]);
     grid
     title({'8-Day Composite Chlorophyll Concentration from MODIS-Aqua'...
           'Start Day ' dlabel}) 
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mg m^{-3}')
     hold off
  case {'chlr8'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .8])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
     clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5]);
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'8-Day Composite Chlorophyll Concentration from MODIS-Aqua',...
            dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mg m^{-3}')
     hold off
  case {'chl14'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .8])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
     clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     m_coast('patch',[.5 .5 .5]);
     grid
     title({'14-Day Composite Ocean Color from MODIS-Aqua'...
           'Start Day ' dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mg m^{-3}')
     hold off
case {'sargossh'}
      clf
      m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                         max_lat]);
     m_pcolor(lon,lat,data);
     shading interp
     %m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
     %       [round(min_lat):5:round(max_lat)],'tickdir','out','color','k');
     caxis([-30 30]);
     hold on
     %m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth',0.1);
     m_contour(lon,lat,data,[-30:5:-1],'k--','linewidth',1);
     m_contour(lon,lat,data,[1:5:30],'k');
          m_coast('patch',[.5 .5 .5],'edgecolor','k');
          %m_plot(275,-20,'+k','linewidth',2);
          %m_plot(285,-20,'+k','linewidth',2);
          title({'CLS Merged SSA High-Pass 10x10',ydlabel});
          %m_text(1045,84,'Contour interval 1 cm','fontsize',8)
          %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
          hold off
          
case {'clshpssh'}
     clf
     m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                         max_lat]);
     m_pcolor(lon,lat,data);
     colormap('jet');
     shading flat
     %m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick',[round(min_lat): ...
                         ...
     %               5:round(max_lat)],'tickdir','out','color','k');
     caxis([-20 20]);
     hold on
     m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth', ...
            0.1);
     h=m_contour(lon,lat,data,[-10:-1],'k--','linewidth',1);
     [cs,h]=m_contour(lon,lat,data,[1:10],'k');
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2);
     m_plot(285,-20,'+k','linewidth',2);
     title({'CLS Merged SSA High-Pass 10x10',ydlabel});
     m_text(1045,84,'Contour interval 1 cm','fontsize',8)
     m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     hold off
  case {'regssh'}
     clf
     %m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
     m_pcolor(lon,lat,data);
     colormap('jet')
     shading flat
     %m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick',[round(min_lat): ...
     %               5:round(max_lat)],'tickdir','out','color','k');
     caxis([-20 20])
     c=colorbar('horiz');
     hold on
     m_plot([292 272 272 292],[-12 -12 -25 -25],'color','k','linewidth',1);
     h=m_contour(lon,lat,data,[-20:2:-2],'k--','linewidth',1);
     %set(h,'markersize',6)
     [cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     %m_text(280.25,-36,'Contour interval 2 cm','fontsize',8)
     %m_text(277,-37,'Negative Contours Dashed   ','fontsize',8)
     title({'Regional Overview of Sea Surface Height',ydlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     xlabel('cm')
     hold off

   case {'hpssh_contour'}
    %m_pcolor(lon,lat,data);
    %shading interp
    %colormap(chelle)
    %caxis([-25 25])
    %c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k--');
     [cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height','High Pass Filtered',dlabel});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off


   case {'hpssh'}
    m_pcolor(lon,lat,data);
    shading interp
    colormap(chelle)
    caxis([-25 25])
    %c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k--');
     %[cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height','High Pass Filtered',dlabel});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off
     
   case {'hpssh_small'}
    m_pcolor(lon,lat,data);
    shading interp
    colormap(chelle)
    caxis([-8 8])
    %c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k--');
     %[cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height  ','High Pass Filtered  ',dlabel, '  '});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off
     
 case {'hpssh_med_w'}
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick', ...
           [round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','w','fontsize',8);
    m_pcolor(lon,lat,data);
    shading interp
    colormap(chelle)
    caxis([-15 15])
    %c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k--');
     %[cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height','High Pass Filtered',dlabel},'color','w');
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off
     
     
  case {'hpssh_med'}
    m_pcolor(lon,lat,data);
    shading interp
    colormap(chelle)
    caxis([-15 15])
    %c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k--');
     %[cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height  ','spatially high-pass filtered  ',dlabel, '  '});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off
     
    case {'hpssh_large'}
    m_pcolor(lon,lat,data);
    shading interp
    colormap(chelle)
    caxis([-25 25])
    %c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k--');
     %[cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height  ','spatially high-pass filtered  ',dlabel, '  '});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off   
     
    case {'ssh_mask_cont'}
    m_pcolor(lon,lat,data(:,:,1).*data(:,:,2));
    shading flat
    colormap(bwr)
    caxis([-10 10])
    %c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data(:,:,1).*data(:,:,2),[-100:2:-2],'k');
     [cs,h]=m_contour(lon,lat,data(:,:,1).*data(:,:,2),[2:2:100],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     title({'Sea Surface Height','High Pass Filtered',dlabel});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off   
     
     
     
  case {'ge_ssh_mask_cont'}
    clf
    m_proj('Equidistant Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	colormap('jet');
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','out','color','k');  
	hm=gca;
	set(hm,'clipping','off')
	hold on
	m_pcolor(lon,lat,data(:,:,1).*data(:,:,2));
    shading flat
    colormap(bwr)
    caxis([-10 10])
    %c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data(:,:,1),[-100:2:-2],'k');
     %[cs,h]=m_contour(lon,lat,data(:,:,1),[2:2:100],'k');
     %m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     %grid
     %title({'Sea Surface Height','High Pass Filtered',dlabel});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     %m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     %xlabel('cm')
     hold off  
     
     
     
 case {'ssh'}
 	lat=interp2(lat,2);
 	lon=interp2(lon,2);
 	data=interp2(data,2);
    m_pcolor(lon,lat,data);
    shading flat
    colormap(rwp)
    caxis([-15 15])
     %c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-200:2:-2],'k--');
     [cs,h]=m_contour(lon,lat,data,[2:2:200],'k');
     m_coast('patch',[0 0 0],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_text(288.4,-25.8,'Contour interval 2 cm','fontsize',8)
     %m_text(287.5,-26.2,'Negative Contours Dashed   ','fontsize',8)
     grid
     %axes(c);
     %set(c,'position',[.15 .06 .74 .025]);
     %xlabel('cm')
     hold off
  case {'crl'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([-2.25e-1 -2.249e-1])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Wind Stress Curl from QuikScat',dlabel});
     %axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Nm^{-2} per 100 km')
     hold off
  case {'div'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([-.2 .2])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Wind Stress Divergence from QuikScat',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Nm^{-2} per 100 km')
     hold off
  case {'sshpng'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([-20 20])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-20:2:-2],'k:');
     [cs,h]=m_contour(lon,lat,data,[2:2:20],'k');
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Sea Surface Height',ydlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     m_text(1045,84,'Contour interval 2 cm','fontsize',8)
     m_text(922,94,'Negative Contours Dashed   ','fontsize',8)
     xlabel('cm')
     hold off
 case {'gradtoi'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0.2 .5])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Magnitude of SST Gradient from','Daily Reynolds OI4 Optimally Interpolated SST',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius per 100 km')
     hold off
  case {'gradt'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0.1 1])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Magnitude of SST Gradient from 3-Day Composite TMI SST',...
            'Start Day ' dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius per 100 km')
     hold off
  case {'gradta'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0.1 1])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Magnitude of SST Gradient from 3-Day Composite AMSR-E',...
            'Start Day ' dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius per 100 km')
     hold off
  case {'gradtaarc'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0.1 1])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Magnitude of SST Gradient from 3-Day Composite AMSR-E',...
            'Start Day ' dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius per 100 km')
     hold off
  case {'mgradt'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0.1 1])
     load /Volumes/matlab/matlab/general/bwr.pal
     colormap(bwr)
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Magnitude of SST Gradient from 3-Day Composite MODIS',...
            'Start Day ' dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius per 100 km')
     hold off
  case {'mergedsst'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     hold on
     [cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Merged SST from TMI and AMSR-E',dlabel});
     c=colorbar('horiz');
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'mergedsstarc'}
    m_pcolor(lon,lat,data);
    shading flat
    hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Merged SST from TMI and AMSR-E',dlabel});
     c=colorbar('horiz');
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'oiarc'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c])
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Reynolds OI4 Optimally Interpolated SST',dlabel});
     c=colorbar('horiz');
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     xlabel('Degrees Celcius')
     hold off
  case {'oi'}
    m_pcolor(lon,lat,data);
    shading flat
	caxis([20 30])
	hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Reynolds SST  ',dlabel});
     %c=colorbar('horiz');
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     %xlabel('Degrees Celcius')
     hold off
   case {'crlhp'}
    m_pcolor(lon,lat,data);
    shading flat
	caxis([-3 3])
	hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'HP Filtered Wind Vorticity',dlabel});
     %c=colorbar('horiz');
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     %xlabel('Degrees Celcius')
     hold off  
   case {'crlg'}
    m_pcolor(lon,lat,data);
    shading flat
	caxis([-3 3])
	hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'HP Filtered Geostrophic Vorticity',dlabel});
     %c=colorbar('horiz');
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     %xlabel('Degrees Celcius')
     hold off    
   case {'oian'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([fixed_min_c fixed_max_c])
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Reynolds OI4 Optimally Interpolated SST',dlabel});
     c=colorbar('horiz');
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     xlabel('Degrees Celcius')
     hold off
  case {'tssthp'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([-2 2])
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
    %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
      title({'7 Day High-Pass Filtered TMI SST',dlabel})
                          
      %axes(c);
      %set(c,'position',[.15 .015 .74 .025]);
      %xlabel('Degrees Celcius')
      %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
      hold off
      
case {'oihp'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([-1.5 1.5])
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
    %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'7 Day High-Pass Filtered Reynolds OI4',' Optimally Interpolated SST',dlabel});
    %axes(c);
    %set(c,'position',[.15 .015 .74 .025]);
    %xlabel('Degrees Celcius')
    %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
    colormap(chelle)
    hold off
  case {'amsrehp'}
    m_pcolor(lon,lat,data);
    shading interp
    caxis([-1.1 1.1])
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
    %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'7 Day High-Pass Filtered AMSR-E SST',dlabel});
    %axes(c);
    %set(c,'position',[.15 .015 .74 .025]);
    %xlabel('Degrees Celcius')
    %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
    hold off
    
 case {'amsre'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([10 30])
    %c=colorbar('horiz');
    hold on
    %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
    %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
    m_coast('patch',[0 0 0],'edgecolor','k');
    %m_plot(275,-20,'+k','linewidth',2)
    %m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'7 Day AMSR-E SST',dlabel});
    %axes(c);
    %set(c,'position',[.15 .015 .74 .025]);
    %xlabel('Degrees Celcius')
    %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
    hold off

  case {'oi'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
    c=colorbar('horiz');
    hold on
    [cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
    clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
    m_coast('patch',[.5 .5 .5],'edgecolor','k');
    m_plot(275,-20,'+k','linewidth',2)
    m_plot(285,-20,'+k','linewidth',2)
    grid
    title({'Daily Reynolds OI4 Optimally Interpolated SST',dlabel});
    axes(c);
    set(c,'position',[.15 .015 .74 .025]);
    xlabel('Degrees Celcius')
    set(c,'yTick',yyyy,'yTicklabel',yyyylab);
       hold off

case {'tsst'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([19 31])
    %c=colorbar('horiz');
    %hold on
    %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
    %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[0 0 0],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'TMI SST',dlabel});
     %axes(c);
     %set(c,'position',[.15 .015 .74 .025]);
     %xlabel('Degrees Celcius')
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     %hold off
    
case {'ctt'}
  m_pcolor(lon,lat,data);
  shading flat
  caxis([210 310])
     c=colorbar;
     hold on
     %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     %m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_coast('color','k')
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Cloud Top Temperature from MODIS Aqua',dlabel});
     axes(c);
     ylabel('Kelvin')
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     
case {'ctp'}
  m_pcolor(lon,lat,data);
  shading flat
  caxis([500 850])
     c=colorbar;
     hold on
     %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Weekly Averged Cloud Top Pressure from MODIS Aqua',dlabel});
     %axes(c);
     ylabel('hPa')
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
case {'ctthp'}
  m_pcolor(lon,lat,data);
  shading flat
  caxis([-1 1])
     c=colorbar;
     hold on
     load chelle.pal
     colormap(chelle)
     %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_plot([23 56 56 23],[-36 -36 -41 -41],'color','k','linewidth',0.1);
v     grid
     title({'Monthly Averged High-Pass Cloud Top Temperature from MODIS Aqua',dlabel});
     %axes(c);
     %ylabel('Kelvin')
     % set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off  
case {'ctphp'}
  m_pcolor(lon,lat,data);
  shading flat
  caxis([-5 5])
     c=colorbar;
     hold on
     load chelle.pal
     colormap(chelle)
     %[cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     %clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     %m_plot(275,-20,'+k','linewidth',2)
     %m_plot(285,-20,'+k','linewidth',2)
     %m_plot([23 56 56 23],[-36 -36 -41 -41],'color','k','linewidth',0.1);
     grid
     title({'Annually Averged High-Pass Cloud Top Pressure from MODIS Aqua'});
     axes(c);
     ylabel('Kelvin')
     % set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
     
  case {'sst'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Averaged SST from TMI',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'sstarc'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     %     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Averaged SST from TMI',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'sstarca'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     %     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Averaged SST from AMSR-E',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'ssta'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[5:2:40],'k');
     clabel(cs,h,[5:2:40],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Averaged SST from AMSR-E',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'msstarc'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Daily Averaged SST from MODIS',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'msst'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c]) 
    caxis([10 30])
     %c=colorbar('horiz'); 
     hold on 
     %     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');   
     %clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10); 
     m_coast('patch',[0 0 0],'edgecolor','k');   
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'7 Day Averaged SST from MODIS',dlabel});
     %axes(c); 
     %set(c,'position',[.15 .015 .74 .025]);
     %xlabel('Degrees Celcius') 
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
     
    case {'mssthp'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c]) 
	caxis([-1.1 1.1])
	%c=colorbar('horiz'); 
     hold on 
     %     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');   
     %clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10); 
     m_coast('patch',[0 0 0],'edgecolor','k');   
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'7 Day Averaged High-Pass Filtered SST from MODIS',dlabel});
     %axes(c); 
     %set(c,'position',[.15 .015 .74 .025]);
     %xlabel('Degrees Celcius') 
     %set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
      
  case {'msst3'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'3-day Composite SST from MODIS-Aqua', 'Start Day ' dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'sst3a'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'3-day Composite SST from AMSR-E','Start Day ' dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
case {'sst3aarc'}
  m_pcolor(lon,lat,data);
  shading flat
  %caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     % [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     %clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'3-day Composite SST from AMSR-E','Start Day ' dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
     hold off
  case {'sst3'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'3-day Composite SST from TMI','Start Day ' dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'sst3arc'}
    m_pcolor(lon,lat,data);
    shading flat
    %caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     %clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'3-day Composite SST from TMI','Start Day ' dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'assta'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Ascending Pass SST from AMSR-E',dlabel});
     c=colorbar('horiz');
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'dssta'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid
     title({'Descending Pass SST from AMSR-E',dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off
  case {'asst'} 
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])  
     hold on  
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');    
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid 
     title({'Ascending Pass SST from TMI',dlabel});    
     c=colorbar('horiz');
     axes(c);  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')  
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off 
  case {'dsst'}  
    m_pcolor(lon,lat,data);
    shading flat
    caxis([min_c max_c])   
     c=colorbar('horiz');   
     hold on   
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');     
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     grid  
     title({'Descending Pass SST from TMI',dlabel})
     axes(c);   
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')   
     set(c,'yTick',yyyy,'yTicklabel',yyyylab);
     hold off  
  case {'clwarc'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');
     %clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Daily Averaged Cloud Liquid Water from TMI',dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')
     hold off
  case {'clw'} 
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])  
     c=colorbar('horiz');
     hold on  
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid
     title({'Daily Averaged Cloud Liquid Water from TMI',dlabel})
     axes(c);  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')
     hold off
  case {'aclw'}  
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])   
     c=colorbar('horiz'); 
     hold on   
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k'); 
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Ascending Pass Cloud Liquid Water from TMI',dlabel});
     axes(c);;
     set(c,'position',[.15 .015 .74 .025]);
     hold off 
     xlabel('mm')
  case {'dclw'}   
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])    
     c=colorbar('horiz');  
     hold on    
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');  
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);    
     m_coast('patch',[.5 .5 .5],'edgecolor','k');      
     grid  
     title({'Descending Pass Cloud Liquid Water from TMI',dlabel});
     axes(c);    
     set(c,'position',[.15 .015 .74 .025]);
     hold off  
     xlabel('mm')   
  case {'aclwarc'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])
     c=colorbar('horiz');
     hold on
     % [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');
     %clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Ascending Pass Cloud Liquid Water from TMI',dlabel});
     axes(c);;
     set(c,'position',[.15 .015 .74 .025]);
     hold off
     xlabel('mm')
  case {'dclwarc'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');
     %     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Descending Pass Cloud Liquid Water from TMI',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     hold off
     xlabel('mm')
  case {'awv'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([24 30])  
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k');
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid
     title({'Daily Averaged Atmospheric Water Vapor from TMI',dlabel});
     axes(c);  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')  
     hold off  
  case {'aawv'} 
    m_pcolor(lon,lat,data);
    shading flat
    caxis([24 30])   
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k'); 
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Ascending Pass Atmospheric Water Vapor from TMI',dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')   
     hold off 
   case {'dawv'} 
     m_pcolor(lon,lat,data);
     shading flat
     caxis([24 30])   
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k'); 
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Descending Pass Atmospheric Water Vapor from TMI',dlabel})
     set(c,'position',[.15 .015 .74 .025]);
     axes(c);    
     xlabel('mm')   
     hold off 
  case {'aawvarc'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([24 30])
     c=colorbar('horiz');
     hold on
     %[cs,h]=m_contour(lon,lat,data,[12:2:28],'k');
     %clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Ascending Pass Atmospheric Water Vapor from TMI',dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')
     hold off
   case {'dawvarc'}
     m_pcolor(lon,lat,data);
     shading flat
     caxis([24 30])
     c=colorbar('horiz');
     hold on
     %     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k');
     %clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Descending Pass Atmospheric Water Vapor from TMI',dlabel})
     set(c,'position',[.15 .015 .74 .025]);
     axes(c);
     xlabel('mm')
     hold off
     
  case {'clwa'} 
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])  
     c=colorbar('horiz');
     hold on  
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid
     title({'Daily Averaged Cloud Liquid Water from AMSR-E',dlabel})
     axes(c);  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')
     hold off
  case {'aclwa'}  
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])   
     c=colorbar('horiz'); 
     hold on   
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k'); 
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Ascending Pass Cloud Liquid Water from AMSR-E',dlabel});
     axes(c);;
     set(c,'position',[.15 .015 .74 .025]);
     hold off 
     xlabel('mm')
  case {'dclwa'}   
    m_pcolor(lon,lat,data);
    shading flat
    caxis([0 .4])    
     c=colorbar('horiz');  
     hold on    
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');  
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);    
     m_coast('patch',[.5 .5 .5],'edgecolor','k');      
     grid  
     title({'Descending Pass Cloud Liquid Water from AMSR-E',dlabel});
     axes(c);    
     set(c,'position',[.15 .015 .74 .025]);
     hold off  
     xlabel('mm')   
  case {'awva'}
    m_pcolor(lon,lat,data);
    shading flat
    caxis([24 30])  
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k');
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid
     title({'Daily Averaged Atmospheric Water Vapor from AMSR-E',dlabel});
     axes(c);  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')  
     hold off  
  case {'aawva'} 
    m_pcolor(lon,lat,data);
    shading flat
    caxis([24 30])   
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k'); 
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Ascending Pass Atmospheric Water Vapor from AMSR-E',dlabel})
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')   
     hold off 
   case {'dawva'} 
     m_pcolor(lon,lat,data);
     shading flat
     caxis([24 30])   
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k'); 
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Descending Pass Atmospheric Water Vapor from AMSR-E',dlabel})
     set(c,'position',[.15 .015 .74 .025]);
     axes(c);    
     xlabel('mm')   
     hold off 
end
clear c
%{
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'Papersize',[11 11])
set(gcf, 'Paperunits','normalized')
set(gcf,'paperposition',[.01 .01 .95 .70])
%}