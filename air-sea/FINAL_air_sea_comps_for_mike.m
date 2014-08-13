clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA'};

%			SSH     SSHi    SST    SSTi     crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	5         1     1        .1     .4		5		1		0.5		.1		%SP		1
            15        2     1        .1     .7		15		2		15		2		%AGR	2
            10        2     .25      .05    .5		10		2		1		.1		%HAW	3
            12        2     1        .1     .7		12		2		2		.25		%EIO	4
            12        2     .05      .01    .5		12		2		.5		.1   	%CAR	5
            30        4     1        .1     1		15		2		7		1 ];    %SEA	6

for mm=1:6
    load(['V6_',curs{mm},'_comps'])
    load bwr.pal
    pal=bwr;
    
    flc='sst_c';
    eval(['tmp = ',curs{mm},'_sst_c;'])

    imag=tmp.mean;
    cont=tmp.mean;
    cax=[-cranges(mm,3) cranges(mm,3)];
    mincont=-100;
    conti=cranges(mm,4);
    maxcont=100;
    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])

    
    flc='sst_a';
    eval(['tmp = ',curs{mm},'_sst_a;'])

    imag=tmp.mean;
    cont=tmp.mean;

    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])

    
    
    flc='ssh_c';
    eval(['tmp = ',curs{mm},'_ssh_c;'])
    
    
    imag=tmp.mean;
    cont=tmp.mean;
    cax=[-cranges(mm,1) cranges(mm,1)];
    mincont=-100;
    conti=cranges(mm,2);
    maxcont=100;
    
    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])

    
    flc='ssh_a';
    eval(['tmp = ',curs{mm},'_ssh_a;'])

    imag=tmp.mean;
    cont=tmp.mean;

    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])

    
    
    
    
    

    
    %%fixed sst wek and sst wek
    flc='fixed_wek_sst_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_c;'])
    eval(['n = ',curs{mm},'_fixed_wek_sst_c.n_max_sample;'])
    
    imag=-tmp.mean;
    cont=-tmp2.mean;
    cax=[-cranges(mm,8) cranges(mm,8)];
    mincont=-100;
    conti=cranges(mm,9);
    maxcont=100;
    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])

    flc='fixed_wek_sst_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['tmp2 = ',curs{mm},'_fixed_wek_sst_a;'])
    eval(['n = ',curs{mm},'_fixed_wek_sst_a.n_max_sample;'])
    
    imag=-tmp.mean;
    cont=-tmp2.mean;

    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
   
    
    %wek and wek
    flc='wek_c_with_wek';
    eval(['tmp = ',curs{mm},'_wek_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_c;'])
    eval(['n = ',curs{mm},'_wek_c.n_max_sample;'])
    
    
    imag=tmp.mean;
    cont=tmp2.mean;
    cax=[-cranges(mm,6) cranges(mm,6)];
    mincont=-100;
    conti=cranges(mm,7);
    maxcont=100;
    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)

    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='wek_a_with_wek';
    eval(['tmp = ',curs{mm},'_wek_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_a;'])
    eval(['n = ',curs{mm},'_wek_a.n_max_sample;'])
    
    imag=tmp.mean;
    cont=tmp2.mean;
    
    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    %
    %%crl wek and crl wek
    flc='wek_crl_c_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_c;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_c;'])
    eval(['n = ',curs{mm},'_wek_crlg_c.n_max_sample;'])
    
    
    imag=tmp.mean;
    cont=tmp2.mean;

    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    flc='wek_crl_a_with_wek_crl';
    eval(['tmp = ',curs{mm},'_wek_crlg_a;'])
    eval(['tmp2 = ',curs{mm},'_wek_crlg_a;'])
    eval(['n = ',curs{mm},'_wek_crlg_a.n_max_sample;'])

    
    imag=tmp.mean;
    cont=tmp2.mean;

    
    xi=linspace(-2,2,length(imag(1,:)));
    yi=xi';
    imag=double(interp2(imag));
    x=linspace(-2,2,length(imag(1,:)));
    y=x';
    
    figure(199)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 8.5])
    pcolor(x,y,imag);shading interp;
    caxis(cax)
    hold on
    [c,h]=contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    [c, h]=contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2);
    clabel(c,h,'labelspacing', 1000,'fontsize',30)
    dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
    % set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
    
    line([-2 2],[0 0],'color','k','LineWidth',1.5)
    line([0 0],[-2 2],'color','k','LineWidth',1.5)
    
    line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
    line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
    line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
    line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
    line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
    line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)
    
    line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
    line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)
    axis([-2 2 -2 2])
    box
    box
    colormap(pal)
    eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{mm},'_comps/',flc])
    
    
end
