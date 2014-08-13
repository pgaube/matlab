
%%%%%%%
%%%%%file name
HEAD='/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.';

out_var='hp66_chl'
lp_span_x=20;
lp_span_y=10;

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
    fname=[HEAD flid '.ssh']
    if exist(fname)
        data=read_pop(HEAD,flid,'ssh',1);
        
        %%grid
        ttt=griddata(lon,lat,data,glon,glat,'linear');
        
        %%smooth
        tic
        lp=smooth2d_loess(ttt,glon(1,:),glat(:,1),lp_span_x,lp_span_y,glon(1,:),glat(:,1));
        toc
        
        %%grid 2
        lph=griddata(glon,glat,lp,lon,lat,'linear');
        
        hp21_ssh=data-lph;
        
%         figure(1)
%         clf
%         pmap(lon,lat,hp21_ssh)
%         drawnow
       
        if exist(['mat/run33_',num2str(nn),'.mat'])
                eval(['save -append mat/run33_',num2str(nn),' hp21_ssh'])
        else
            eval(['save mat/run33_',num2str(nn),' hp21_ssh'])
        end
    end
end
