%first find good eddies
ids= 149011

load eddy_wind_example_tracks

for m=1:length(ids)
	ff=find(id==ids(m));
	if length(ff)>9 & track_jday(ff(1))>=2451395
	wek=interp(track_wek(ff),3);
	kk=interp(k(ff),3);
	chl=interp(track_bp26_chl(ff),3);
	r=pcor(track_wek(ff),track_bp26_chl(ff));
	%wsp=interp(track_wspd(ff),3);
	%gek=amp(ff)./(scale(ff).^2);
	%aa=interp(gek,3);

	figure(m)
	plot(k(ff),track_wek(ff),'k')
	hold on
	scatter(k(ff),track_wek(ff),'k')
	plot(k(ff),track_bp26_chl(ff),'g')
	scatter(k(ff),track_bp26_chl(ff),'g')
	title({['eddy id ' num2str(ids(m))],['  r = ',num2str(r)]})
	
	%{
	subplot(211)
	scatter(kk,wek,50,wek,'filled')
	%axis([0 max(kk) -.25 .25])
	caxis([-.25 .25])
	title({['eddy id ' num2str(ids(m))],['Ekman Pumping  r = ',num2str(r)]})
	grid on
	
	subplot(212)
	scatter(kk,chl,50,chl,'filled')
	title('CHL Anomaly   ')
	grid on

	%{
	subplot(413)
	scatter(kk,wsp,50,wsp,'filled')
	title({'Wind Speed   '})
	grid on

	subplot(414)
	scatter(kk,aa,50,aa,'filled')
	title({'A/L^2   '})
	grid on
	%}
	%}
	
	end

end	
	
	