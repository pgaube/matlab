load chelle.pal
load tmp_cor_tracks x y k id cyc adens amp track_jday radius
figure(1)
clf
hold on
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    if length(ii)>2
        scatter(x(ii),y(ii),ones(size(ii)),amp(ii));
        caxis([0 20])
    end
end
colormap(chelle)