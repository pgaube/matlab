clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO'};





for mm=2%[4 5 3 1 6 2]
    curs(mm)
    load(['V6_',curs{mm},'_comps']) 
    eval(['tt=',curs{mm},'_wek_a.mean;'])
    wek(1,1)=max(tt(:));
    wek(1,2)=min(tt(:));

    eval(['tt=',curs{mm},'_wek_c.mean;'])
    wek(2,1)=max(tt(:));
    wek(2,2)=min(tt(:));
    wek

    eval(['tt=',curs{mm},'_wek_crlg_a.mean;'])
    crl(1,1)=max(tt(:));
    crl(1,2)=min(tt(:));

    eval(['tt=',curs{mm},'_wek_crlg_c.mean;'])
    crl(2,1)=max(tt(:));
    crl(2,2)=min(tt(:));
    crl

    eval(['tt=',curs{mm},'_fixed_wek_sst_a.mean;'])
    sst(1,1)=max(tt(:));
    sst(1,2)=min(tt(:));

    eval(['tt=',curs{mm},'_fixed_wek_sst_c.mean;'])
    sst(2,1)=max(tt(:));
    sst(2,2)=min(tt(:));
    sst
    return
end

% clear
load FIANL_wind_midlat_rot_comps

tt=wek_a.mean;
wek(1,1)=max(tt(:));
wek(1,2)=min(tt(:));

tt=wek_c.mean;
wek(2,1)=max(tt(:));
wek(2,2)=min(tt(:));
wek

tt=wek_crlg_a.mean;
crl(1,1)=max(tt(:));
crl(1,2)=min(tt(:));

tt=wek_crlg_c.mean;
crl(2,1)=max(tt(:));
crl(2,2)=min(tt(:));
crl

tt=wek_sst_fixed_a.mean;
sst(1,1)=max(tt(:));
sst(1,2)=min(tt(:));

tt=wek_sst_fixed_c.mean;
sst(2,1)=max(tt(:));
sst(2,2)=min(tt(:));
sst