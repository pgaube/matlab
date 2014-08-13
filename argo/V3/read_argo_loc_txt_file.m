%load the argo float profile txt file
clear all
[A DELIM NHEADERLINES]=importdata('ar_index_global_prof.txt');
pfile=A.textdata(:,1);
pfile(1:NHEADERLINES,:)=[];
tdate=A.textdata(:,2);
tdate(1:NHEADERLINES,:)=[];
tlat=A.textdata(:,3);
tlat(1:NHEADERLINES,:)=[];
tlon=A.textdata(:,4);
tlon(1:NHEADERLINES,:)=[];
[pjday,plat,plon]=deal(nan(length(tlon),1));
for m=1:length(pfile)
    tt=tdate{m};
    if any(tt)
        pyear=str2num(tt(1:4));
        pmonth=str2num(tt(5:6));
        pday=str2num(tt(7:8));
        pjday(m)=date2jd(pyear,pmonth,pday)+.5;
    end
    tt=tlat{m};
    if any(tt)
        plat(m)=str2num(tt);
    end
    tt=tlon{m};
    if any(tt)   
        plon(m)=str2num(tt);
    end
end    
ii=find(plon<0);
plon(ii)=180+(180+plon(ii));
today=date2jd;
plon(plon>360)=nan;
plat(abs(plat)>80)=nan;
pjday(pjday>today)=nan;
tt=mean([plon plat pjday],2);
ii=find(isnan(tt));
plon(ii)=[];
plat(ii)=[];
pjday(ii)=[];
pfile(ii)=[];
save argo_profile_index plat plon pjday pfile
