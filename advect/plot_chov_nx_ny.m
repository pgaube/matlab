clear
set_advect
load chelle.pal
jdays=[2450821:2454489];


for p=1:length(lat)
	load(['line_',num2str(p),'_hov'],'hp_chov','nx','ny','raw_clon','clon','cjdays')
	[y,m,d]=jd2jdate(cjdays);
	uy=unique(y);
	for m=1:length(uy)
		i_y=find(y==uy(m));
		ttick(m)=i_y(1);
		ttick_lab(m)=uy(m);
	end	
	figure(10)
	clf
	subplot(3,3,[1 4])
	ny=smooth1d_loess(ny,jdays,40,cjdays);
	plot(100*ny./length(nx),cjdays)
	axis tight
	title('%_t')
	set(gca,'ytick',cjdays(ttick)','yticklabel',{int2str(ttick_lab')})
	subplot(3,3,[8 9]) 
	nx=smooth1d_loess(nx,raw_clon,2.5,clon);
	plot(clon,100*nx./length(jdays))
	axis tight
	title('%_x')
	subplot(3,3,[2 3 5 6])
    pcolor(clon,cjdays,double(hp_chov));shading flat
    colormap(chelle)
    caxis([-.13 .13])
    set(gca,'xtick',[],'ytick',[])
    title('hp chov')
    subplot(3,3,7)
    text(.01,.3,['\mu_{%t} = ',num2str(round(100*pmean(ny)./length(raw_clon)))])
    text(.01,.6,['\mu_{%x} = ',num2str(round(100*pmean(nx)./length(jdays)))])
    set(gca,'Visible','off')
    eval(['print -dpng figs/chov_nx_ny_',num2str(p)])
    clear ttick ttick_lab
end
