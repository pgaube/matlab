function h=pmap_vec(varargin) 
%function h=pmap(lon,lat,data,TYPE,U,V,DATE)
lon = varargin{1};
lat = varargin{2};
data = varargin{3};
TYPE = varargin{4};
s=datevec(date) 
if nargin >= 5,
   U = varargin{5};
   V = varargin{6};
end

if nargin == 7
   tmp = varargin{7};
   [month,day,year] = jul2date(str2num(tmp(5:7)),str2num(tmp(1:4)));
   dlabel = [num2str(year) '-' num2str(month) '-' num2str(day)];
   ydlabel = dlabel;
else
   dlabel=[num2str(s(1)) '-' num2str(s(2)) '-' num2str(s(3))];
   ydlabel=[num2str(s(1)) '-' num2str(s(2)) '-' num2str(s(3)-1)];
end


figure(1)
clf
cla
%axes('parent',gcf);
max_lat=max(lat(:)); 
min_lat=min(lat(:)); 
max_lon=max(lon(:)); 
min_lon=min(lon(:)); 
s=datevec(date);

m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon,lat,data); 
m_grid('xtick',[round(min_lon):3:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 

switch TYPE
case {'ssh_geo'}
     caxis([-20 20])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[-20:5:20],'k');
     clabel(cs,h,[-20:5:20],'color','k','rotation',0,'FontSize',10);
     m_quiver(lon(2:2:79,2:2:35),lat(2:2:79,2:2:35),U(2:2:79,2:2:35),V(2: ...
              2:79,2:2:35),'color','k');
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Sea Surface Height with Geostrophic Velocity Vectors',dlabel})
     axes(c)
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('cm')
     hold off
     hold off
  case {'wind'}
    % caxis([0 15]) 
     c=colorbar('horiz'); 
     hold on 
     %[cs,h]=m_contour(lon,lat,data,[0:4:20],'k');   
     %clabel(cs,h,[0:4:20],'color','k','rotation',0,'FontSize',10); 
     m_quiver(lon(2:2:52,2:2:80),lat(2:2:52,2:2:80),U(2:2:52,2:2:80),V(2:2:52,2:2:80),.5,'k'); 
     m_plot(275,-20,'+k','linewidth',2)
     m_plot(285,-20,'+k','linewidth',2)
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Vector Winds from QuikScat',dlabel})
     axes(c)  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('m s^{-1}')  
     hold off
  case {'tau'}
    %caxis([0 10])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[0:4:20],'k');
     clabel(cs,h,[0:4:20],'color','k','rotation',0,'FontSize',10);
     m_quiver(lon(2:2:52,2:2:80),lat(2:2:52,2:2:80),U(2:2:52,2:2:80),V(2:2:52,2:2:80),.7,'k');
     m_plot(275,-20,'+k','linewidth',2)
          m_plot(285,-20,'+k','linewidth',2)
          m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'Daily Wind Stress from QuikScat',dlabel})
     axes(c)
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('N m^{-2}')
     hold off
case {'wind7'}
     caxis([0 15])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[0:4:20],'k');
     clabel(cs,h,[0:4:20],'color','k','rotation',0,'FontSize',10);
     m_quiver(lon(2:2:52,2:2:80),lat(2:2:52,2:2:80),U(2:2:52,2:2:80),V(2:2:52,2:2:80),.3,'k');
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'7-day Composite Vector Winds from QuikScat'})
     axes(c)
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('m s^{-1}')
     hold off
  case {'sst'}
     caxis([12 22]) 
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');   
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10); 
     m_coast('patch',[.5 .5 .5],'edgecolor','k');   
     grid
     title({'Daily Averaged SST from TMI',dlabel});
     axes(c) 
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius') 
     hold off
  case {'sst3'}
     caxis([12 22])
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);
     m_coast('patch',[.5 .5 .5],'edgecolor','k');
     grid
     title({'3-day Composite SST from TMI'})
     axes(c)
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')
     hold off
  case {'asst'} 
     caxis([12 22])  
     hold on  
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');    
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid 
     title({'Ascending Pass SST from TMI',dlabel});    
     c=colorbar('horiz');
     axes(c)  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')  
     hold off 
  case {'dsst'}  
     caxis([12 22])   
     c=colorbar('horiz');   
     hold on   
     [cs,h]=m_contour(lon,lat,data,[14:2:20],'k');     
     clabel(cs,h,[14:2:20],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid  
     title({'Descending Pass SST from TMI',dlabel})
     axes(c)   
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('Degrees Celcius')   
     hold off  
  case {'clw'} 
     caxis([0 .4])  
     c=colorbar('horiz');
     hold on  
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid
     title({'Daily Averaged Cloud Liquid Water from TMI',dlabel})
     axes(c)  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')
     hold off
  case {'aclw'}  
     caxis([0 .4])   
     c=colorbar('horiz'); 
     hold on   
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k'); 
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Ascending Pass Cloud Liquid Water from TMI',dlabel});
     axes(c);
     set(c,'position',[.15 .015 .74 .025]);
     hold off 
     xlabel('mm')
  case {'dclw'}   
     caxis([0 .4])    
     c=colorbar('horiz');  
     hold on    
     [cs,h]=m_contour(lon,lat,data,[.02:.1:.3],'k');  
     clabel(cs,h,[.02:.2:.5],'color','k','rotation',0,'FontSize',10);    
     m_coast('patch',[.5 .5 .5],'edgecolor','k');      
     grid  
     title({'Descending Pass Cloud Liquid Water from TMI',dlabel});
     axes(c)    
     set(c,'position',[.15 .015 .74 .025]);
     hold off  
     xlabel('mm')   
  case {'awv'}
     caxis([10 30])  
     c=colorbar('horiz');
     hold on
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k');
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);  
     m_coast('patch',[.5 .5 .5],'edgecolor','k');    
     grid
     title({'Daily Averaged Atmospheric Water Vapor from TMI',dlabel});
     axes(c)  
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')  
     hold off  
  case {'aawv'} 
     caxis([10 30])   
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k'); 
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Ascending Pass Atmospheric Water Vapor from TMI',dlabel})
     axes(c)
     set(c,'position',[.15 .015 .74 .025]);
     xlabel('mm')   
     hold off 
   case {'dawv'} 
     caxis([10 30])   
     c=colorbar('horiz'); 
     hold on 
     [cs,h]=m_contour(lon,lat,data,[12:2:28],'k'); 
     clabel(cs,h,[12:2:28],'color','k','rotation',0,'FontSize',10);   
     m_coast('patch',[.5 .5 .5],'edgecolor','k');     
     grid 
     title({'Descending Pass Atmospheric Water Vapor from TMI',dlabel})
     set(c,'position',[.15 .015 .74 .025]);
     axes(c)    
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