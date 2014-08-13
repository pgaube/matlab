%
clear all
close all

lon  = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','LONGITUDE'); %lon looks to be fucked?
lat  = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','LATITUDE');
pres = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','PRESSURE');
time = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','TIME')+.5;
tbar = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','ARGO_TEMPERATURE_MEAN');
sbar = ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','ARGO_SALINITY_MEAN');
tanom= ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','ARGO_TEMPERATURE_ANOMALY');
sanom= ncread('/Users/new_gaube/data/argo/RG_ArgoClim_2012.nc','ARGO_SALINITY_ANOMALY');
%}
month=mod(time,12);
month(month==0)=12;

T_clima=nan(length(lon),length(lat),length(pres),12);
S_clima=T_clima;

f=2*pi/365.25/12;
x=1:12;

for m=1:length(lon)
    for n=1:length(lat)
        for p=1:length(pres)
            T=squeeze(tanom(m,n,p,:))+squeeze(tbar(m,n,p));
            S=squeeze(sanom(m,n,p,:))+squeeze(sbar(m,n,p));
            if nansum(T)~=0
                [dum,beta_t]=harm_reg(month,T,2,f);
                T_clima(m,n,p,:)=beta_t(1)+beta_t(2)*cos(f*x)+beta_t(3)*cos(2*f*x)+beta_t(4)*sin(f*x)+beta_t(5)*sin(2*f*x);
                [dum,beta_t]=harm_reg(month,S,2,f);
                S_clima(m,n,p,:)=beta_t(1)+beta_t(2)*cos(f*x)+beta_t(3)*cos(2*f*x)+beta_t(4)*sin(f*x)+beta_t(5)*sin(2*f*x);               
            end    
        end
    end
end

save argo_climatology T_clima S_clima lat lon pres

