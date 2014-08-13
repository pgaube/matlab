clear


% load GS_rings_cor_tracks_jan_5 x y id cyc
load GS_rings_cor_tracks_jan_28 x y id cyc
figure(1)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
subplot(211)
axis([-10 5 -5 5])
hold on
uid=unique(id(cyc==-1));
for m=1:length(uid)
    ii=find(id==uid(m));
    rr=plot(x(ii)-x(ii(1)),y(ii)-y(ii(1)),'b');
    set(rr,'clipping','off')
end
box on
line([-10 5],[0 0],'color','k')
line([0 0],[-5 5],'color','k')

subplot(212)
axis([-10 5 -5 5])
hold on
uid=unique(id(cyc==1));
for m=1:length(uid)
    ii=find(id==uid(m));
    rr=plot(x(ii)-x(ii(1)),y(ii)-y(ii(1)),'r');
    set(rr,'clipping','off')
end
box on
line([-10 5],[0 0],'color','k')
line([0 0],[-5 5],'color','k')

% print -dpng -r300 figs/pop_ring_orgin_plot_from_sla
print -dpng -r300 figs/pop_ring_orgin_plot_from_mdt


