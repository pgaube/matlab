
%%%%%%%
%%%%%file name
HEAD='/Volumes/d1/larrya/public_html/0pt1/0pt1_run33/t.33.';

%%%%%%%%%%
% select time period
vv=[1740:2139]; %this is the whole encilada
[i,tm]=size(vv); % tm = number of time levels

% read data
n=0;
load ~/data/gsm/cor_chl_ssh_out.mat lon lat
glon=lon;
glat=lat;
load ~/matlab/pop/mat/pop_model_domain.mat lat lon z
[rg,cg]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
glat=glat(rg,cg);
glon=glon(rg,cg);

for nn=vv; % time
    n=n+1;
    flid=num2str(nn);
    fname=[HEAD flid '.diazc_vint104']
    if exist(fname)
        diaz_biomass=read_pop(HEAD,flid,'diazc_vint104',1);
        diat_biomass=read_pop(HEAD,flid,'diatc_vint104',1);
        small_biomass=read_pop(HEAD,flid,'spc_vint104',1);
        
        eval(['save -append mat/run33_',num2str(nn),' *biomass'])
        
    end
end
