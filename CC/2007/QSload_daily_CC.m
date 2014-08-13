
lon = [0.125:0.25:359.875];
lat=[-89.875:0.25:89.875]; 
%r=find(lat>=-20 &lat<-5);
%c=find(lon>=275 & lon<=285);
r=find(lat>=35&lat<=45);
c=find(lon>=232&lon<=240);
lat=lat(r);
lon=lon(c);
days=[1:31];
years=[2002:2005];
l = 1;
p = 1;
q = 50;
windspd = [];
intmat = [];
path='/Volumes/matlab/data/QuickScat/from_ssmi/';
g='.gz';


wind_spd=nan(length(lat),length(lon),2000);
U=nan(length(lat),length(lon),2000);
V=nan(length(lat),length(lon),2000);





for i=1:length(years);
    if years(i)==2002
        months = [6:12]
        else if years(i)==2005
            months=[1:8]
        else months = [1:12]
        end
    end
 
    for j=1:length(months);
        for k=1:length(days);
            fday = julian(months(j),days(k),years(i));
            if days(k)<10 & months(j)<10
                filename=[path,int2str(years(i)),'0',int2str(months(j)),'0',int2str(days(k))];
                fcheck=[path,int2str(years(i)),'0',int2str(months(j)),'0',int2str(days(k)),'.gz'];
            end
           
			if days(k)>=10 & months(j)<10
                filename=[path,int2str(years(i)),'0',int2str(months(j)),int2str(days(k))];
                fcheck=[path,int2str(years(i)),'0',int2str(months(j)),int2str(days(k)),'.gz'];
            end
            
			if days(k)<10 & months(j)>=10
                filename=[path,int2str(years(i)),int2str(months(j)),'0',int2str(days(k))];
                fcheck=[path,int2str(years(i)),int2str(months(j)),'0',int2str(days(k)),'.gz'];
            end
            
			if days(k)>=10 & months(j)>=10
                filename=[path,int2str(years(i)),int2str(months(j)),int2str(days(k))];
                fcheck=[path,int2str(years(i)),int2str(months(j)),int2str(days(k)),'.gz'];
            end
					
			
            if exist(fcheck)
                eval(['!gunzip ' fcheck]);
                [mingmt,windspd,winddir,scatflag,radrain]=get_scat_daily_v03(filename);
                eval(['!gzip ' filename]);
                clear mingmt;
                windspd=windspd(c,r,:);
                winddir=winddir(c,r,:);
                scatflag=scatflag(c,r,:);
                radrain=radrain(c,r,:);
                windspd(scatflag==1)=NaN;
                windspd(radrain==-1)=NaN;
                windspd(scatflag==-999)=NaN;
                winddir(scatflag==1)=NaN;
                winddir(scatflag==-999)=NaN;
                winddir(radrain==-1)=NaN;
                winddir=90-winddir;
                u=cosd(winddir);
                v=sind(winddir);
                wind_spd(:,:,p)=nanmean(windspd,3)';
                U(:,:,p)=nanmean(u,3)';
                V(:,:,p)=nanmean(v,3)';
                time(p,:)=filename;
                p=p+1;
                		 
            end
        end
    end
end

clear c days fcheck fday filename g i intmat j k l months num* p path q winddir windspd u v years scatflag radrain r
save qs_winds_cc
