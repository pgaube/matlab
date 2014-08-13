

% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels

load ~/matlab/pop/mat/pop_model_domain.mat lat lon mask1 buff_mask
fname1='/Volumes/d1/larrya/public_html/0pt1/0pt1_run33/t.33.'; 

% read data
n=0;
load ~/data/gsm/cor_chl_ssh_out.mat lon lat
[rg,cg]=imap(10,55,280,355,lat,lon);
glat=lat(rg,cg);
glon=lon(rg,cg);

% load model box latitudes, longitudes, dx, dy
imt=992; jmt=1280; imtm1=imt-1; jmtm1=jmt-1;
fid=fopen('/Volumes/d1/larrya/public_html/0pt1/grid/grid.992x1280.da','r','ieee-be');
[aaa]=fread(fid,[992,1280],'float64'); % radians; lat of U points
ulat(1:1280)=aaa(1,1:1280)*180/pi;          % convert to degrees
[aaa]=fread(fid,[992,1280],'float64'); % radians; lon of U points
ulon(1:992)=aaa(1:992,1)*180/pi;            % convert to degrees
[aaa]=fread(fid,[992,1280],'float64'); % cm
htn(1:1280)=aaa(1,1:1280);                 % dx of T box N edge
[aaa]=fread(fid,[992,1280],'float64'); % cm
hte(1:1280)=aaa(1,1:1280);                 % dy of T box E edge
st=fclose(fid);
tlon(2:imt) = 0.5*(ulon(2:imt)+ulon(1:imtm1)); % lon of T points
tlon(1) = tlon(2) - 0.1;
tlat(2:jmt) = 0.5*(ulat(2:jmt)+ulat(1:jmtm1)); % lat of T points
ulat0 = ulat(1) - 0.1*cos(ulat(1)*pi/180);
tlat(1) = 0.5*(ulat(1)+ulat0);

dxu = htn; % dx at U points
dyu(1:jmtm1) = 0.5*(hte(1:jmtm1) + hte(2:jmt)); % dy at U points
dyu(jmt) = 2*dyu(jmtm1)-dyu(jmt-2); % guess; not important for W
dyt = hte; % dy at T points
dxt(2:jmt) = 0.5*(htn(2:jmt) + htn(1:jmtm1)); % dx at T points
dxt(1) = 2*dxt(2)-dxt(3); % guess; not important for W
tarea = dxt.*dyt; % T box areas (cm**2)
a(1:992)=1;
tarea2=a'*tarea; % 2-D array of T areas
deg2rad=pi/180;

% select subdomain
% % 25-43 W 25-40 N
% is=291; ie=570; js=463; je=709; im=ie-is+1; jm=je-js+1;
% most of the region
tlon(tlon<0)=180+(180+tlon(tlon<0));
[r,c]=imap(10,55,280,355,tlat,tlon);
is=c(1); ie=c(end); js=r(1); je=r(end); im=ie-is+1; jm=je-js+1;
lat=tlat(js:je)';
lon=tlon(is:ie)';


for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
        if exist([fname1 flid '.photoc_diaz_vint104'])
    
            pp_diaz=read_pop(fname1,flid,'photoc_diaz_vint104',1).*buff_mask;
            pp_diat=read_pop(fname1,flid,'photoc_diat_vint104',1).*buff_mask;;
            pp_small=read_pop(fname1,flid,'photoc_sp_vint104',1).*buff_mask;
            
            pp_total=pp_diaz+pp_diat+pp_small;
    
            ttt=griddata(lon,lat,pp_total,glon,glat,'linear');
            tic;lp=smooth2d_loess(ttt,glon(1,:),glat(:,1),6,6,glon(1,:),glat(:,1));toc
            lph=griddata(glon,glat,lp,lon,lat','linear');
            hp66_pp=pp_total-lph;
            
%             figure(1)
%             clf
%             pmap(lon,lat,pp_total);
%             caxis([0 .001])
%             drawnow
%             
%             figure(2)
%             clf
%             pmap(lon,lat,hp66_pp);
%             caxis([-.0001 .0001])
%             drawnow
%             
    
            eval(['save -append mat/run33_',num2str(nn),' hp66_pp pp_*'])
        end 
end;