
clear all
fname='~/data/argo/ar_index_global_prof.txt';
fid=fopen(fname);

index=textscan(fid,'%s %n %n %n %s %n %s %n','Delimiter',',','Headerlines',9);

pfile=index{:,1};
pdate=index{:,2};
plat=index{:,3};
plon=index{:,4};
ii=find(plon<0);
plon(ii)=180+(180+plon(ii));
tmp=num2str(pdate);
pjday=nan*plat;
h = waitbar(0,'computing jdays');
steps = length(plat);

for m=1:length(plat)
    waitbar(m / steps)
    if ~isnan(tmp(m))
        pjday(m)=date2jd(str2double(tmp(m,1:4)),str2double(tmp(m,5:6)),str2double(tmp(m,7:8)),str2double(tmp(m,9:10)),str2double(tmp(m,11:12)),str2double(tmp(m,13:14)));
    else
        pjday(m)=nan;
        display('missing date')
    end
end
close(h) 
save ~/matlab/argo/V4/argo_prof_index p* fname

save ~/data/argo/argo_prof_index p* fname