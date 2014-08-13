%draws a box enclosing the domain.
function draw_domain(lon,lat)
min_lat=min(lat(:));
max_lat=max(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

hold on
m_plot([min_lon min_lon],[min_lat max_lat],'k','linewidth',1.5)
m_plot([min_lon max_lon],[max_lat max_lat],'k','linewidth',1.5)
m_plot([max_lon max_lon],[max_lat min_lat],'k','linewidth',1.5)
m_plot([min_lon max_lon],[min_lat min_lat],'k','linewidth',1.5)
hold off
