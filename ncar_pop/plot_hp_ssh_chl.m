clear all
dir_list=dir(['/Volumes/ys-home/mat/POP_BEC_JAN_15_2014_*']);

load /Volumes/ys-home/mat/buff_mask_0_pt_25_degree

for m=1:length(dir_list)
    fname=['/Volumes/ys-home/mat/',getfield(dir_list(m),'name')];
    load(fname,'tlon','tlat','hp*','jdays')
    m
    
    figure(1)
    clf
    pmap(tlon,tlat,mask)
    caxis([-30 30])
    return

    figure(2)
    clf
    pmap(tlon,tlat,hp66_chl)
    caxis([-.1 .1])
    return
end
