
ff=1;


%
%
%ii=1:length(eddy_id);
%
%
for m=1:length(ii)
	 if nansum(eddy_it(:,ii(m)))>0
		 dfs=diff(eddy_is_anom(:,ii(m)));
		 dfs=dfs./max(dfs);
		 dft=diff(eddy_it_anom(:,ii(m)));
		 dft=dft./max(dft);
		 dfdf=dft-dfs;
		 dfdf=dfdf/max(dfdf);
		 
		 figure(10)
		 clf
		 subplot(251)
		 plot(eddy_ist_anom(:,ii(m)),-ppres,'g')
		 hold on
		 axis([-.75 .75 -1000 0])
		 title(['dist_x=',num2str(eddy_dist_x(ii(m)))])
		 grid on
		 subplot(252)
		 plot(eddy_it_anom(:,ii(m)),-ppres,'r')
		 title(num2str(ii(m)))
		 hold on
		 plot(3*sigma_it,-tpres,'color',[.5 .5 .5])
		 axis([-3 3 -1000 0])
		 grid on
		 subplot(253)
		 plot(eddy_is_anom(:,ii(m)),-ppres)
		 hold on
		 plot(3*sigma_is,-tpres,'color',[.5 .5 .5])
		 axis([-.75 .75 -1000 0])
		 title(['dist_y=',num2str(eddy_dist_y(ii(m)))])	
		 grid on
		 
		 subplot(256)
		 plot(eddy_ist(:,ii(m)),-ppres,'g')
		 xlabel('\sigma_{\theta}')
		 subplot(257)
		 plot(eddy_it(:,ii(m)),-ppres,'r')
		 xlabel('^\circ C')
		 subplot(258)
		 plot(eddy_is(:,ii(m)),-ppres,'b')
		 xlabel('PSU')
		 title(['eddy id = ',num2str(eddy_id(ii(m)))])
		 
		 subplot(2,5,[4 5 9 10])
		 plot(eddy_is(:,ii(m)),eddy_it(:,ii(m)),'k')
		 hold on
		 plot(mean_s_cc,mean_t_cc,'b')
		 plot(mean_s_ac,mean_t_ac,'r') 
		 axis([33 37 0 30])
		 
		 
		 eval(['print -dpng -r100 figs/test_profiles/frame_',num2str(ff)])
		 ff=ff+1;
	 end
end 
cd figs/test_profiles/
png2mpg
cd /matlab/matlab/argo