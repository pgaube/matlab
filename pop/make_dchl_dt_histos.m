clear all
fnames={'GS_rings_tracks_run14_sla2','GS_rings_tracks_run14_sla2','GS_rings_tracks_run33_sla2'};


for drap=1:length(fnames)
    clearallbut fnames drap
    load(fnames{drap})
    if drap==1
        pop_eddies=aviso_eddies;
    end
    
    tbins_chl=-.008:.0005:.008;
    tbins_a=-5:.2:5;
%     tbins_chl=-.01:.001:.01;
%     tbins_a=-2:.2:2;
%     
    [hist_2d_prop_speed_ac,hist_2d_prop_speed_cc]=deal(nan(length(tbins_chl),length(tbins_a)));

    %%select only ac
    ii=find(pop_eddies.cyc==-1)
    for m=1:length(tbins_chl)-1
        for n=1:length(tbins_a)-1
            nn=find(pop_eddies.dchl_dt(ii)>tbins_chl(m) & pop_eddies.dchl_dt(ii)<=tbins_chl(m+1) & ...
                    pop_eddies.prop_speed(ii)>=tbins_a(n)    & pop_eddies.prop_speed(ii)<=tbins_a(n+1));
            if any(ii)
                hist_2d_prop_speed_ac(m,n)=length(nn);
            end
        end
    end
    
    hist_2d_prop_speed_ac=100*(hist_2d_prop_speed_ac./(max(hist_2d_prop_speed_ac(:))));
    load pgray.pal
    figure(1)
    set(gca,'Position',[0 0 7 7])
    clf
    pcolor(tbins_a,tbins_chl,hist_2d_prop_speed_ac);shading flat
    colormap(pgray)
    colorbar
    hold on
%     contour(tbins_a,tbins_chl,hist_2d,[10:10:100],'color','k')
    line([0 0],[min(tbins_chl) max(tbins_chl)],'color','k')
    line([min(tbins_a) max(tbins_a)],[0 0],'color','k')
    xlabel('Prop Speed')
    ylabel('\partial CHL/\partial t')
    title([fnames{drap},'  AC'])
    eval(['print -dpng -r300 figs/2d_histo_ac_dchl_prop_speed_',num2str(drap)])
    
     %%select only ac
    ii=find(pop_eddies.cyc==1)
    for m=1:length(tbins_chl)-1
        for n=1:length(tbins_a)-1
            nn=find(pop_eddies.dchl_dt(ii)>tbins_chl(m) & pop_eddies.dchl_dt(ii)<=tbins_chl(m+1) & ...
                    pop_eddies.prop_speed(ii)>=tbins_a(n)    & pop_eddies.prop_speed(ii)<=tbins_a(n+1));
            if any(ii)
                hist_2d_prop_speed_cc(m,n)=length(nn);
            end
        end
    end
    
    hist_2d_prop_speed_cc=100*(hist_2d_prop_speed_cc./(max(hist_2d_prop_speed_cc(:))));
    load pgray.pal
    figure(1)
    set(gca,'Position',[0 0 7 7])
    clf
    pcolor(tbins_a,tbins_chl,hist_2d_prop_speed_cc);shading flat
    colormap(pgray)
    colorbar
    hold on
%     contour(tbins_a,tbins_chl,hist_2d,[10:10:100],'color','k')
    line([0 0],[min(tbins_chl) max(tbins_chl)],'color','k')
    line([min(tbins_a) max(tbins_a)],[0 0],'color','k')
    xlabel('Prop Speed')
    ylabel('\partial CHL/\partial t')
    title([fnames{drap},'  CC'])
    eval(['print -dpng -r300 figs/2d_histo_cc_dchl_prop_speed_',num2str(drap)])
    return
    eval(['save -append histo_2d_output_',num2str(drap),' hist_* tbin*'])
    
end



return

for drap=1:length(fnames)
    clearallbut fnames drap
    load(fnames{drap})
    if drap==1
        pop_eddies=aviso_eddies;
    end
    
    tbins_chl=-.008:.004:.008;
    tbins_a=-.4:.2:.4;
%     tbins_chl=-.01:.001:.01;
%     tbins_a=-2:.2:2;
%     
    [hist_2d_am,hist_2d_cm,hist_2d_ae,hist_2d_ce]=deal(nan(length(tbins_chl),length(tbins_a)));

    %%select only ac meanders
    ii=find(pop_eddies.prop_dir>0 & pop_eddies.cyc==1)
    for m=1:length(tbins_chl)-1
        for n=1:length(tbins_a)-1
            nn=find(pop_eddies.dchl_dt(ii)>tbins_chl(m) & pop_eddies.dchl_dt(ii)<=tbins_chl(m+1) & ...
                    pop_eddies.da_dt(ii)>=tbins_a(n)    & pop_eddies.da_dt(ii)<=tbins_a(n+1));
            if any(ii)
                hist_2d_am(m,n)=length(nn);
            end
        end
    end
    
    hist_2d_am=100*(hist_2d_am./(max(hist_2d_am(:))));
    load pgray.pal
    figure(1)
    set(gca,'Position',[0 0 7 7])
    clf
    pcolor(tbins_a,tbins_chl,hist_2d_am);shading flat
    colormap(pgray)
    colorbar
    hold on
%     contour(tbins_a,tbins_chl,hist_2d,[10:10:100],'color','k')
    line([0 0],[min(tbins_chl) max(tbins_chl)],'color','k')
    line([min(tbins_a) max(tbins_a)],[0 0],'color','k')
    xlabel('\partial A/\partial t')
    ylabel('\partial CHL/\partial t')
    title([fnames{drap},'  ACM'])
    eval(['print -dpng -r300 figs/2d_histo_ac_dchl_da_meanders_',num2str(drap)])
    
    %%select only cc meanders
    ii=find(pop_eddies.prop_dir>0 & pop_eddies.cyc==-1)
    for m=1:length(tbins_chl)-1
        for n=1:length(tbins_a)-1
            nn=find(pop_eddies.dchl_dt(ii)>tbins_chl(m) & pop_eddies.dchl_dt(ii)<=tbins_chl(m+1) & ...
                    pop_eddies.da_dt(ii)>=tbins_a(n)    & pop_eddies.da_dt(ii)<=tbins_a(n+1));
            if any(ii)
                hist_2d_cm(m,n)=length(nn);
            end
        end
    end
    
    hist_2d=100*(hist_2d_cm./(max(hist_2d_cm(:))));
    load pgray.pal
    figure(1)
    set(gca,'Position',[0 0 7 7])
    clf
    pcolor(tbins_a,tbins_chl,hist_2d_cm);shading flat
    colormap(pgray)
    colorbar
    hold on
%     contour(tbins_a,tbins_chl,hist_2d,[10:10:100],'color','k')
    line([0 0],[min(tbins_chl) max(tbins_chl)],'color','k')
    line([min(tbins_a) max(tbins_a)],[0 0],'color','k')
    xlabel('\partial A/\partial t')
    ylabel('\partial CHL/\partial t')
    title([fnames{drap},'  CCM'])
    eval(['print -dpng -r300 figs/2d_histo_cc_dchl_da_meanders_',num2str(drap)])
    
    %%select only ac eddies
    ii=find(pop_eddies.prop_dir<0 & pop_eddies.cyc==1)
    for m=1:length(tbins_chl)-1
        for n=1:length(tbins_a)-1
            nn=find(pop_eddies.dchl_dt(ii)>tbins_chl(m) & pop_eddies.dchl_dt(ii)<=tbins_chl(m+1) & ...
                    pop_eddies.da_dt(ii)>=tbins_a(n)    & pop_eddies.da_dt(ii)<=tbins_a(n+1));
            if any(ii)
                hist_2d_am(m,n)=length(nn);
            end
        end
    end
    
    hist_2d_am=100*(hist_2d_am./(max(hist_2d_am(:))));
    load pgray.pal
    figure(1)
    set(gca,'Position',[0 0 7 7])
    clf
    pcolor(tbins_a,tbins_chl,hist_2d_am);shading flat
    colormap(pgray)
    colorbar
    hold on
%     contour(tbins_a,tbins_chl,hist_2d,[10:10:100],'color','k')
    line([0 0],[min(tbins_chl) max(tbins_chl)],'color','k')
    line([min(tbins_a) max(tbins_a)],[0 0],'color','k')
    xlabel('\partial A/\partial t')
    ylabel('\partial CHL/\partial t')
    title([fnames{drap},'  ACE'])
    eval(['print -dpng -r300 figs/2d_histo_ac_dchl_da_eddies_',num2str(drap)])
    
    %%select only cc eddies
    ii=find(pop_eddies.prop_dir<0 & pop_eddies.cyc==-1)
    for m=1:length(tbins_chl)-1
        for n=1:length(tbins_a)-1
            nn=find(pop_eddies.dchl_dt(ii)>tbins_chl(m) & pop_eddies.dchl_dt(ii)<=tbins_chl(m+1) & ...
                    pop_eddies.da_dt(ii)>=tbins_a(n)    & pop_eddies.da_dt(ii)<=tbins_a(n+1));
            if any(ii)
                hist_2d_cm(m,n)=length(nn);
            end
        end
    end
    
    hist_2d=100*(hist_2d_cm./(max(hist_2d_cm(:))));
    load pgray.pal
    figure(1)
    set(gca,'Position',[0 0 7 7])
    clf
    pcolor(tbins_a,tbins_chl,hist_2d_cm);shading flat
    colormap(pgray)
    colorbar
    hold on
%     contour(tbins_a,tbins_chl,hist_2d,[10:10:100],'color','k')
    line([0 0],[min(tbins_chl) max(tbins_chl)],'color','k')
    line([min(tbins_a) max(tbins_a)],[0 0],'color','k')
    xlabel('\partial A/\partial t')
    ylabel('\partial CHL/\partial t')
    title([fnames{drap},'  CCE'])
    eval(['print -dpng -r300 figs/2d_histo_cc_dchl_da_eddies_',num2str(drap)])
    
    eval(['save histo_2d_output_',num2str(drap),' hist_* tbin*'])
    
end

