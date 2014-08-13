
%load monthly
load /Volumes/matlab/data/modisa/L2/avg_fields/monthly/ctt_agulhas_M_2007_1.mat
ctt=nan(length(GRIDY),length(GRIDX),12);
ctp=ctt;

for m=1:12
    fname = [['/Volumes/matlab/data/modisa/L2/avg_fields/monthly/' ...
             'ctt_agulhas_M_2007_'],num2str(m),'.mat'];
    load(fname)
    ctt(:,:,m)=Mctt;
    
    fname = [['/Volumes/matlab/data/modisa/L2/avg_fields/monthly/' ...
             'ctp_agulhas_M_2007_'],num2str(m),'.mat'];
    load(fname)
    ctp(:,:,m)=Mctp;
end

%load daily
ctt_day=nan(length(GRIDY),length(GRIDX),365);
ctt_hi_day=nan(length(GRIDY),length(GRIDX),365);
ctt_lo_day=nan(length(GRIDY),length(GRIDX),365);
ctp_day=ctt_day;

p=1;
for m=2007001:2007365
    
    fname = [['/Volumes/matlab/data/modisa/L2/gridded_ctt_80km_tricub/' ...
              'ctt_agulhas_'],num2str(m),'.grid.mat'];
    load(fname)
    ctt_day(:,:,p)=grid_ctt;
    
    fname = [['/Volumes/matlab/data/modisa/L2/gridded_ctp_80km_tricub/' ...
              'ctp_agulhas_'],num2str(m),'.grid.mat'];
    load(fname)
    ctp_day(:,:,p)=grid_ctp;
    
    fname = [['/Volumes/matlab/data/modisa/L2/stratified_ctt_80km_tricub/' ...
              'ctt_agulhas_stratified_D_'],num2str(m),'.mat'];
    load(fname)
    ctt_lo_day(:,:,p)=ctt_lo;
    ctt_hi_day(:,:,p)=ctt_hi;
    %ctt_hi_hp_day(:,:,p)=ctt_hi_hp;
    %ctt_lo_hp_day(:,:,p)=ctt_lo_hp;
    iheight(:,:,p)=iheight;
    p=p+1;
end

