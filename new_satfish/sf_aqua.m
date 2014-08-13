function sf_aqua(region,rname)
tic
rname2=rname;
set(0,'DefaultFigureVisible','off')
close all

set_satfish
load(region)
maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(AQUA_DATA_DIR)
!rm A*
slope=0.005; inter=0;


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

if region=='~/satfish/mask/ca1_mask'
    cmd = ['/usr/local/bin/wget --post-data="subID=1022&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | /usr/local/bin/wget -i -'];
    cran=[-1.2 .8];
elseif region=='~/satfish/mask/wa1_mask'
    cmd = ['/usr/local/bin/wget --post-data="subID=1026&addurl=1&results_as_file=1" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | /usr/local/bin/wget -i -'];
    cran=[-1.2 1];
elseif region=='~/satfish/mask/ne1_mask'
    cmd = ['/usr/local/bin/wget --post-data="subID=1527&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | /usr/local/bin/wget -i -'];
    cran=[-1.3 1];
end

system(cmd, '-echo');
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%CHL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmp=dir(['A*OC.bz2']);
% % tmp0=dir(['A*',num2str(d+1),'*OC*']);
% % tmp1=dir(['A*',num2str(d),'*OC*']);
% tmp2=dir(['A*',num2str(d-1),'*OC*']);
% tmp3=dir(['A*',num2str(d-2),'*OC*']);
% tmp=cat(1,tmp0,tmp1,tmp2,tmp3);
CHL = nan(size(mlat));
nchl= zeros(size(mlat));

ff=1;
for m=1:length(tmp)
    fname=num2str(getfield(tmp,{m},'name'))
    %     if ~exist([AQUA_DATA_ARC fname])
    eval(['!cp ' fname ' ' AQUA_DATA_ARC])
    eval(['!echo -n > ' [AQUA_DATA_ARC fname]])
    eval(['!bunzip2 ' fname])
    fname(23:24)
    if fname(23:24)=='OC'
        type='OCEAN COLOR'
        chl = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
            'chlor_a','Index',{[1 1],[1 1],[]}));
        
        l2_flags=hdfread([AQUA_DATA_DIR,fname(1:25)],...
            'l2_flags','Index',{[1 1],[1 1],[]});
        l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
        l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget
        
        lat = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
            'latitude','Index',{[1 1],[1 1],[]}));
        lon = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
            'longitude','Index',{[1 1],[1 1],[]}));
        time(m,:)=str2num(char(fname(9:12)));
        
        %first save full fields
        full_chl=chl;
        
        % Use default flags from the OceanColor SeaDas processing notes. For the
        % Level 2 CHL imagery.
        %dfltBits = [1 2 4  5 6 9 10 11 13 15 16 17 20 22 23 26];
        %summertime use dfltBits = [1 2 4 10];
        %wintertime use dfltBits = [1 2 4 5 6 9 10 11 13 15 16 17 20 22 23 26];
        dfltBits = [1 2 4 10];
        for jBit = 1:length(dfltBits)
            flag = bitget(l2_flags,dfltBits(jBit));
            chl(flag == 1) = NaN; clear flag
        end
        [r,c]=imap(minlat-1,maxlat+1,minlon-1,maxlon+1,lat,lon);
        
        if length(r)>0 & length(c)>0
            lat=lat(r,c);
            lon=lon(r,c);
            chl=chl(r,c);
            full_chl=full_chl(r,c);
            interpalation='started'
            tmp_chl = log10(double(griddata(lon,lat,chl,mlon,mlat,'linear')));
            
            pnchl=nchl;
            nchl(~isnan(tmp_chl))=nchl(~isnan(tmp_chl))+1;            
            CHL=nansum(cat(3,CHL.*pnchl,tmp_chl),3)./nchl;
        end
    end
    %     end
end

chl=CHL.*mask;


[s(2),s(3),s(1)]=jul2date(str2num(fname(6:8)),str2num(fname(2:5)));
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

hh=str2num(char(fname(9:12)))+(100*UTC);
if hh<1000
    hh=['0',num2str(hh)];
else
    hh=num2str(hh);
end
hh

sc=find(~isnan(chl));
perc=length(sc)./length(find(~isnan(mask(:))));
if perc>.01
    new_sfplot(chl,mask,cran(1),cran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_chl_'],pd,hh,'chl')
end

raw_chl=double(chl);
raw_lat=double(mlat);
raw_lon=double(mlon);
if region=='~/satfish/mask/ca1_mask'
    for nsub=2:6
        rname=['ca',num2str(nsub)]
        outdir=[IMAGE_DIR,'/ca',num2str(nsub),'_out/'];
        load([HOME_DIR,'/mask/ca',num2str(nsub),'_mask'])
        dchl=griddata(raw_lon,raw_lat,raw_chl,mlon,mlat,'nearest');
        dchl=dchl.*mask;
        sc=find(~isnan(dchl));
        perc=length(sc)./length(find(~isnan(mask(:))));
        if perc>.01
            new_sfplot(dchl,mask,cran(1),cran(2),'fdcolor',[outdir rname '_chl_'],pd,hh,'chl')
        end
        clear dchl
    end
end
total_time=toc

% if region=='~/satfish/mask/ne1_mask'
%     eval(['save test_ne1_chl',pd,' chl mask cran mlon mlat'])
% end

!rm A*OC*

cd(HOME_DIR)
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%SST
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear CHL chl lat lon full_CHL
% cd(HOME_DIR)
% slope=0.005; inter=0;
% set_satfish
%
% rname=rname2;
% load(region)
% maxlat=max(mlat(:));
% minlat=min(mlat(:));
% maxlon=max(mlon(:));
% minlon=min(mlon(:));
%
% cd(AQUA_DATA_DIR)
% tmp=dir(['A*SST.bz2']);
% tmp=dir(['A*SST']);
%
% [SST,fSST] = deal(single(nan(length(mlat(:,1)),length(mlon(1,:)),1)));
% n=0;
% load([HOME_DIR '/' rname '_fishran'])
% tmp.name
% for m=1:length(tmp)
%     fname=num2str(getfield(tmp,{m},'name'))
%     %     if ~exist([AQUA_DATA_ARC fname])
%     eval(['!cp ' fname ' ' AQUA_DATA_ARC])
%     eval(['!echo -n > ' [AQUA_DATA_ARC fname]])
%     eval(['!bunzip2 ' fname])
%     fname(22:24)
%     sst = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
% 			'/sst','Index',{[1 1],[1 1],[]}));
%     sst=slope*sst;
%     l2_flags=hdfread([AQUA_DATA_DIR,fname(1:25)],...
%         'l2_flags','Index',{[1 1],[1 1],[]});
%     l2_flags = uint32(2^31 + double(l2_flags)); % first, we need to get a form
%     l2_flags = bitset(l2_flags,32,~bitget(l2_flags,32)); % we can use with bitget
%
%     lat = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
%         'latitude','Index',{[1 1],[1 1],[]}));
%     lon = double(hdfread([AQUA_DATA_DIR,fname(1:25)],...
%         'longitude','Index',{[1 1],[1 1],[]}));
%     time(m,:)=str2num(char(fname(9:12)));
%     n=n+1
%
%     % Use default flags from the OceanColor SeaDas processing notes. For the
%     % Level 2 CHL imagery.
%     %dfltBits = [1 2 4  5 6 9 10 11 13 15 16 17 20 22 23 26];
%     %might need to use 4
%     fsst=sst;
%     dfltBits = [2 28 29];
%     for jBit = 1:length(dfltBits)
%         flag = bitget(l2_flags,dfltBits(jBit));
%         sst(flag == 1) = NaN; clear flag
%     end
%     [r,c]=imap(minlat-1,maxlat+1,minlon-1,maxlon+1,lat,lon);
%     if length(r)>0 & length(c)>0
%         lat=lat(r,c);
%         lon=lon(r,c);
%         sst=sst(r,c);
%         fsst=fsst(r,c);
%         interpalation='started'
%         tmpsst = single(griddata(lon,lat,sst,mlon,mlat,'linear'));
%         tmpfsst = single(griddata(lon,lat,fsst,mlon,mlat,'linear'));
%
%         rr=cat(3,tmpsst,(n*SST./(n+1)));
%         SST = nansum(rr,3);
%         rr=cat(3,tmpfsst,(n*fSST./(n+1)));
%         fSST = nansum(rr,3);
%         SST(SST==0)=nan;
%         fSST(fSST==0)=nan;
%     end
% end
% t=1
% sst=double(SST);
% fsst=double(fSST);
%
% save /Users/fish/Desktop/test_aqua_data sst fsst mlat mlon
% t=2
% whos mlon mlat sst
% % figure(1)
% % clf
% % pcolor(mlon,mlat,double(sst));shading flat;axis image;print -dpng -r300 ~/Desktop/test_aqua_sst
% t=3
% [s(2),s(3),s(1)]=jul2date(str2num(fname(6:8)),str2num(fname(2:5)));
% if s(2)<10 & s(3)<10
%     pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
% elseif s(2)>=10 & s(3)<10
%     pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
% elseif s(2)<10 & s(3)>=10
%     pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
% else
%     pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
% end
% pd
%
%
%
% hh=str2num(char(fname(9:12)))-(100*UTC);
% if hh<1000
%     hh=['0',num2str(hh)];
% else
%     hh=num2str(hh);
% end
% hh
% sc=find(~isnan(sst));
% perc=length(sc)./length(find(~isnan(mask(:))));
% % if perc>.01
%     sfplot((9/5)*sst+32,mask,ran(1),ran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,hh,'sst')
% %     new_sfplot((9/5)*fsst+32,mask,ran(1),ran(2),'fdcolor',[FULL_IMAGE_DIR rname '_bdsc_'],pd,hh,'sst')
% % end
%
% raw_sst=sst;
% raw_lat=mlat;
% raw_lon=mlon;
% if region=='~/satfish/mask/ca1_mask'
%     for nsub=2:6
%         rname=['ca',num2str(nsub)]
%         outdir=[IMAGE_DIR,'/ca',num2str(nsub),'_out/'];
%         load([HOME_DIR,'/mask/ca',num2str(nsub),'_mask'])
%         dsst=griddata(raw_lon,raw_lat,raw_sst,mlon,mlat,'nearest');
%         dsst=dsst.*mask;
%         sc=find(~isnan(dsst));
%         perc=length(sc)./length(find(~isnan(mask(:))));
%         if perc>.01
%             new_sfplot((9/5)*dsst+32,mask,ran(1),ran(2),'fdcolor',[outdir rname '_bdsc_'],pd,hh,'sst')
%         end
%         clear dsst
%     end
% end
% total_time=toc
% end
