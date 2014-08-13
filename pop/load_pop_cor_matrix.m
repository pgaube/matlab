clear all


pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

load('~/data/eddy/V5/mat/AVISO_25_W_2448910.mat','lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
slat=lat(r,c);
slon=lon(r,c);

load mat/pop_model_domain lat lon
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
plat=lat(rp,cp);
plon=lon(rp,cp);



for drap=1:2
    clearallbut fnames drap norths minlat maxlat minlon maxlon slon slat bwr as bs fig_names lags save_names bwr sig_r bs as r c pdays plon plat rp cp
    [nCHL,nSSH]=deal(nan(length(slat(:,1)),length(slon(1,:)),length(pdays)));
    for m=1:length(pdays)
        if drap==1
            if exist(['~/matlab/pop/mat/run14_',num2str(pdays(m)),'.mat'])
                pdays(m)
                load(['~/matlab/pop/mat/run14_',num2str(pdays(m))],'bp21_ssh','hp66_chl')
            end
        else
            if exist(['~/matlab/pop/mat/run33_',num2str(pdays(m)),'.mat'])
                pdays(m)
                load(['~/matlab/pop/mat/run33_',num2str(pdays(m))],'bp21_ssh','hp66_chl')
            end
        end
        
        
        nSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear');
        nCHL(:,:,m)=griddata(plon,plat,hp66_chl(rp,cp),slon,slat,'linear');
    end
    if drap==1
        save pop_run_14_cor_matrix slat slon nSSH nCHL pdays r c rp cp plon plat
    else
        save pop_run_33_cor_matrix slat slon nSSH nCHL pdays r c rp cp plon plat
    end
end


