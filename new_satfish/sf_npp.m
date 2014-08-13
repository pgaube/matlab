function sf_npp(region,rname)

set(0,'DefaultFigureVisible','off')
close all

set_satfish
load(region)
maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(NPP_DATA_DIR)
!rm *

% % % % %get file list from server using wget
d=julian(s(2),s(3),s(1),s(1));
ye=num2str(s(1));
if s(2)<10
    mo=['0',num2str(s(2))];
else
    mo=num2str(s(2));
end
if s(3)<10
    da=['0',num2str(s(3))];
else
    da=num2str(s(3));
end
% eval(['!/usr/local/bin/wget --post-data="subID=2263&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | wget -i -'])
cmd = ['/usr/local/bin/wget --post-data="subID=2263&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | /usr/local/bin/wget -i -'];
system(cmd, '-echo');
% 
% 
% fobj = ftp('oceans.gsfc.nasa.gov');
% pasv(fobj);
% % cd(fobj,'/subscriptions/1382');
% cd(fobj,'/VIIRS/XM/gaube/2263');
% if d<10
%     fnameg = ['V' num2str(s(1)) '00' num2str(d) '*L2*hdf'];
% elseif d<100
%     fnameg = ['V' num2str(s(1)) '0' num2str(d) '*L2*hdf'];
% else
%     fnameg = ['V' num2str(s(1)) num2str(d) '*L2*hdf'];
% end
% mget(fobj,fnameg)
% close(fobj);
% 
% ye=num2str(s(1));
% if s(2)<10
%     mo=['0',num2str(s(2))];
% else
%     mo=num2str(s(2));
% end
% if s(3)<10
%     da=['0',num2str(s(3))];
% else
%     da=num2str(s(3));
% end
% eval(['!/usr/local/bin/wget --post-data="subID=2263&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | wget -i -'])


tmp=dir('V*NPP.bz2');

CHL = nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp(:,1)));
fCHL=CHL;



for m=1:length(tmp)
    fname=num2str(getfield(tmp,{m},'name'));
    %if ~exist([NPP_DATA_ARC fname])
    eval(['!cp ' fname ' ' NPP_DATA_ARC])
    eval(['!echo -n > ' [NPP_DATA_ARC fname]])  
    eval(['!bunzip2 ' fname])
    if fname(23:24)=='OC'
        type='OCEAN COLOR'
        chl = double(hdfread([NPP_DATA_DIR,fname],...
            'chlor_a','Index',{[1 1],[1 1],[]}));
        
        l2_flags=hdfread([NPP_DATA_DIR,fname],...
            'l2_flags','Index',{[1 1],[1 1],[]});
        l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
        l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget
        
        lat = double(hdfread([NPP_DATA_DIR,fname],...
            'latitude','Index',{[1 1],[1 1],[]}));
        lon = double(hdfread([NPP_DATA_DIR,fname],...
            'longitude','Index',{[1 1],[1 1],[]}));
        time(m,:)=str2num(char(fname(9:12)));
        
        %         %clearn up duplicate vlaues
        %         [C,IA,IC]=unique(lat);
        %         lat=lat(IA);
        %         lon=lon(IA);
        %         chl=chl(IA);
        %         l2_flags=l2_flags(IA);
        %
        %         [C,IA,IC]=unique(lon);
        %         lat=lat(IA);
        %         lon=lon(IA);
        %         chl=chl(IA);
        %         l2_flags=l2_flags(IA);
        %
        %
        %first save full fields
        full_chl=chl;
        
        % Use default flags from the OceanColor SeaDas processing notes. For the
        % Level 2 CHL imagery.
        %dfltBits = [1 2 4  5 6 9 10 11 13 15 16 17 20 22 23 26];
        %might need to use 4
        dfltBits = [1 2 4 10];
        for jBit = 1:length(dfltBits)
            flag = bitget(l2_flags,dfltBits(jBit));
            chl(flag == 1) = NaN; clear flag
        end
        [r,c]=imap(minlat-4,maxlat+4,minlon-4,maxlon+4,lat,lon);
        if length(r)>0 & length(c)>0
            lat=lat(r,c);
            lon=lon(r,c);
            chl=chl(r,c);
            full_chl=full_chl(r,c);
            interpalation='started'
            CHL(:,:,m) = griddata(lon,lat,full_chl,mlon,mlat,'linear');
        end
    end
    %end
end
chl=nanmean(log10(CHL),3);

[s(2),s(3),s(1)]=jul2date(str2num(fname(6:8)),str2num(fname(2:5)));
d=julian(s(2),s(3),s(1),s(1));
if s(2)<10 & s(3)<10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
elseif s(2)>=10 & s(3)<10
    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
elseif s(2)<10 & s(3)>=10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
else
    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
end
pd
hh=str2num(char(fname(9:12)))-(100*UTC);
if hh<1000
    hh=['0',num2str(hh)];
else
    hh=num2str(hh);
end
hh

sc=find(~isnan(chl));
perc=length(sc)./length(find(~isnan(mask(:))));
new_sfplot(chl,mask,cran(1),cran(2),'fdcolor',[CA1_IMAGE_DIR rname '_chl_'],pd,hh,'chl')

raw_chl=chl;
raw_lat=mlat;
raw_lon=mlon;
if region=='~/satfish/mask/ca1_mask'
    for nsub=2:6
        rname=['ca',num2str(nsub)]
        outdir=[IMAGE_DIR,'/ca',num2str(nsub),'_out/'];
        load([HOME_DIR,'/mask/ca',num2str(nsub),'_mask'])
        dchl=griddata(raw_lon,raw_lat,raw_chl,mlon,mlat,'nearest');
        dchl=dchl.*mask;
        new_sfplot(dchl,mask,cran(1),cran(2),'fdcolor',[outdir rname '_chl_'],pd,hh,'chl')
        clear dchl
    end
end
total_time=toc

cd(HOME_DIR)
end