clf
k=1:length(s_u(1,1,:))
o=1:10:length(lon);
a=1:10:length(lat);


for p=k;
	subplot(4,4,p)
	quiver(lon(o),lat(a),s_u(a,o,p),s_v(a,o,p),'k')
	t=[int2str(time(s(p))),' SST'];
	title(t,'FontSize',12,'FontWeight','bold')
end 	

