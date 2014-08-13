
startjd=2452427;
endjd=2455159;
% 

% 
% 
% 
% % 
% %%%HAW
% load ~/data/eddy/V5/HAW_lat_lon_orgin_tracks
% ii=find(x>200 & x<207 & y<22 & y>18 & k==1);
% uid=unique(id(ii));
% % ii=sames(uid,id);
% % x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);amp=amp(ii);
% % 
% for m=1:length(uid)
%     ii=find(id==uid(m));
%     x(ii)=[];
%     y(ii)=[];
%     id(ii)=[];
%     cyc(ii)=[];
%     k(ii)=[];
%     track_jday(ii)=[];
%     amp(ii)=[];
% end
% 
% 
% 
% save test_HAW_tracks2
% 
% lat=min(y):max(y);lon=min(x):max(x);
% figure(1)
% clf
% max_lat=max(lat(:));
% min_lat=min(lat(:));
% max_lon=max(lon(:));
% min_lon=min(lon(:));
% lat_step=2;
% lon_step=5;
% m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
% %colormap('jet');
% m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
% hm=gca;
% set(hm,'clipping','off')
% hold on
% 
% [jdays,is]=sort(track_jday);
% x=x(is);
% y=y(is);
% id=id(is);
% k=k(is);
% cyc=cyc(is);
% ujd=unique(jdays);
% for qq=1:length(ujd)
%     dd=find(jdays==ujd(qq) & k==1);
%     uid=unique(id(dd));
%     for m=1:length(uid)
%         ii=find(id==uid(m));
%         if cyc(ii(1))>=1
%             m_plot(x(ii),y(ii),'r','linewidth',.5)
%         end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
%     end
% end
% grid
% m_coast('patch',[0 0 0],'edgecolor','k');
% hold off
% title(['mean amp of anticyclones = ',num2str(round(100*pmean(amp(cyc==1)))/100),' cm'])
% axis normal
% print -dpng -r300 figs/test_HAW_ac2
% % return
% 
% 
% figure(2)
% clf
% max_lat=max(lat(:));
% min_lat=min(lat(:));
% max_lon=max(lon(:));
% min_lon=min(lon(:));
% lat_step=2;
% lon_step=5;
% m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
% %colormap('jet');
% m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
% hm=gca;
% set(hm,'clipping','off')
% hold on
% 
% for qq=1:length(ujd)
%     dd=find(jdays==ujd(qq) & k==1);
%     uid=unique(id(dd));
%     for m=1:length(uid)
%         ii=find(id==uid(m));
%         if cyc(ii(1))<1
%             m_plot(x(ii),y(ii),'b','linewidth',.5)
%         end
%         if cyc(ii(1))<1
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
%     end
% end
% grid
% m_coast('patch',[0 0 0],'edgecolor','k');
% hold off
% title(['mean amp of cyclones = ',num2str(round(100*pmean(amp(cyc==-1)))/100),' cm'])
% 
% axis normal
% print -dpng -r300 figs/test_HAW_cc2
% 
% clear
% 
% load test_HAW_tracks2
% ii=find(track_jday>=startjd & track_jday<=endjd);
% uid=unique(id(ii));
% ii=sames(uid,id);
% x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);amp=amp(ii);
% 
% curs={'test_HAW2'}
% mm=1
% 
% ext_x=x;
% ext_y=y;
% 
%     eval(['[',curs{mm},'_wek_total_a,',curs{mm},'_wek_total_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_total_wek_est',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_wek_total_qscat_a,',curs{mm},'_wek_total_qscat_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_total_wek_qscat',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     %
%     eval(['[',curs{mm},'_wek_sst_a,',curs{mm},'_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_sst_week_cross',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_fixed_wek_sst_a,',curs{mm},'_fixed_wek_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_wek_sst_week_fixed',char(39),',',char(39),...
%         '~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_crlg_a,',curs{mm},'_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp66_crlg',char(39),',',char(39),...
%         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     eval(['[',curs{mm},'_ssh_a,',curs{mm},'_ssh_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'ssh',char(39),',',char(39),...
%         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
%         char(39),'n',char(39),');'])
%     
%     
%     eval(['[',curs{mm},'_sst_a,',curs{mm},'_sst_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp66_sst',char(39),',',char(39),...
%         '~/data/ReynoldsSST/mat/OI_25_30_',char(39),',',...
%         char(39),'n',char(39),');'])
% 
% save test_HAW_comps2


load test_HAW_comps

cranges= [ .15		.5		20		5		2		.2];		%test_HAW	1

x=1000*[-500:10:500];
y=1000*[-500:10:500];

[lon,lat]=meshgrid(x,y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

L=90e3; %m
Ls=L;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2
h=.1*exp((-dist.^2)/(2*L^2));
ssh=(zgrid_abs(real_lon,real_lat,30,30,double(h),Ls/1000));
% 
%     %crl and ssh
%     flc='crlg_c_with_ssh';
%     eval(['tmp = ',curs{mm},'_crlg_c;'])
%     eval(['tmp2 = ',curs{mm},'_ssh_c;'])
%     eval(['n = ',curs{mm},'_ssh_c.n_max_sample;'])
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-1e-5*cranges(mm,2) 1e-5*cranges(mm,2)],-100,2,100,[''],1,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='crlg_a_with_ssh';
%     eval(['tmp = ',curs{mm},'_crlg_a;'])
%     eval(['tmp2 = ',curs{mm},'_ssh_a;'])
%     eval(['n = ',curs{mm},'_ssh_a.n_max_sample;'])
%     
%     pcomps_raw(tmp.mean,tmp2.mean,[-1e-5*cranges(mm,2) 1e-5*cranges(mm,2)],-100,2,100,[''],1,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %%SST and SSh
    flc='sst_c_with_ssh';
    eval(['tmp = ',curs{mm},'_sst_c;'])
    eval(['tmp2 = ',curs{mm},'_ssh_c;'])
    eval(['n = ',curs{mm},'_sst_c.n_max_sample;'])

    pcomps_raw(.8*tmp.mean-ssh,.8*tmp2.mean-ssh,[-cranges(mm,1) cranges(mm,1)],-100,2,100,[''],1,30)
%     pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,1) cranges(mm,1)],-100,2,100,[''],1,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='sst_a_with_ssh';
    eval(['tmp = ',curs{mm},'_sst_a;'])
    eval(['tmp2 = ',curs{mm},'_ssh_a;'])
    eval(['n = ',curs{mm},'_sst_a.n_max_sample;'])
    
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,1) cranges(mm,1)],-100,2,100,[''],1,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    return
%     
% 
%     %%wek SST regional coupco
%     flc='wek_sst_reg_c_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_dtdn_c;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
%     eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
%     pcomps_raw(alpha_n_round(mm).*tmp.mean,alpha_n_round(mm).*tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='wek_sst_reg_a_with_wek_crl';
%     eval(['tmp = ',curs{mm},'_dtdn_a;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
%     eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
%     pcomps_raw(alpha_n_round(mm).*tmp.mean,alpha_n_round(mm).*tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     %w%ek total and wek fixed SST
%     flc='test_wek_add_reg_c';
%     eval(['tmp = ',curs{mm},'_wek_total_c;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_c;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
%     tmp.mean=tmp.mean+(alpha_n_round(mm).*tmp2.mean);
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
%     flc='test_wek_add_reg_a';
%     eval(['tmp = ',curs{mm},'_wek_total_a;'])
%     eval(['tmp2 = ',curs{mm},'_dtdn_a;'])
%     eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
%     tmp.mean=tmp.mean+(alpha_n_round(mm).*tmp2.mean);
%     pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
%     eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
%     
    
    %wek total
    flc='test_wek_total_c';
    eval(['tmp = ',curs{mm},'_wek_total_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_c;'])
    eval(['n = ',curs{mm},'_wek_total_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_total_a';
    eval(['tmp = ',curs{mm},'_wek_total_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_a;'])
    eval(['n = ',curs{mm},'_wek_total_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_total_qscat_c';
    eval(['tmp = ',curs{mm},'_wek_total_qscat_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_qscat_c;'])
    eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_total_qscat_a';
    eval(['tmp = ',curs{mm},'_wek_total_qscat_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_total_qscat_a;'])
    eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %wek total and wek fixed SST
    flc='test_wek_add_fix_qscat_c';
    eval(['tmp = ',curs{mm},'_wek_total_c;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['n = ',curs{mm},'_wek_total_qscat_c.n_max_sample;'])
    tmp.mean=tmp.mean+tmp2.mean;
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='test_wek_add_fix_qscat_a';
    eval(['tmp = ',curs{mm},'_wek_total_a;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['n = ',curs{mm},'_wek_total_qscat_a.n_max_sample;'])
    tmp.mean=tmp.mean+tmp2.mean;
    pcomps_raw(tmp.mean,tmp.mean,[-cranges(mm,3) cranges(mm,3)],-100,cranges(mm,4),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    %%wek fixed SST
    flc='wek_sst_fixed_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['n = ',curs{mm},'_wek_sst_c.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='wek_sst_fixed_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['n = ',curs{mm},'_wek_sst_a.n_max_sample;'])
    pcomps_raw(tmp.mean,tmp2.mean,[-cranges(mm,5) cranges(mm,5)],-100,cranges(mm,6),100,[''],2,30)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
