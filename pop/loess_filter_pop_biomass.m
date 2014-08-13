
%%%%%%%
%%%%%file name
HEAD='/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.';

out_var='hp66_biomass'
sm_span_x=2;
sm_span_y=2;
lp_span_x=6;
lp_span_y=6;

%%%%%%%%%%
% select time period
vv=[1740:2139]; %this is the whole encilada
% vv=[1965:2139];
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
        data1=read_pop(HEAD,flid,'diazc_vint104',1);
        data2=read_pop(HEAD,flid,'diatc_vint104',1);
        data3=read_pop(HEAD,flid,'spc_vint104',1);
        data=data1+data2+data3;
        %%grid
        ttt=griddata(lon,lat,data,glon,glat,'linear');
        
        %%smooth
        tic
        sm=smooth2d_loess(ttt,glon(1,:),glat(:,1),sm_span_x,sm_span_y,glon(1,:),glat(:,1));
        lp=smooth2d_loess(sm,glon(1,:),glat(:,1),lp_span_x,lp_span_y,glon(1,:),glat(:,1));
        toc
        
        %%grid 2
        lph=griddata(glon,glat,lp,lon,lat,'linear');
        smh=griddata(glon,glat,sm,lon,lat,'linear');
        
        eval([out_var,'=smh-lph;'])
%         figure(1)
%         clf
%         eval(['pmap(lon,lat,',out_var,')'])
%         drawnow
        if exist(['mat/run14_',num2str(nn),'.mat'])
                eval(['save -append mat/run14_',num2str(nn),' ',out_var])
        else
            eval(['save mat/run14_',num2str(nn),' ',out_var])
        end
    end
end
