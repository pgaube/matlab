fname = '/Volumes/data2/data/argo/ar_index_global_prof_pg.txt'

fid=fopen(fname,'r');
A=textscan(fid,'%s %n %n %n %s %n %s %n','Delimiter',',','headerlines',1);
fclose(fid);

pfile=A{1};
pdate=A{2};
plat=A{3};
plon=A{4};


%subset to oly work with Delayed products
pp=1;
for m=1:length(pfile)
	test=num2str(pfile{m});
	t=find(test=='D');
	if any(t)
		igood(pp)=m;
		pp=pp+1;
	end	
end	

pfile=pfile(igood);
pdate=pdate(igood);
plat=plat(igood);
plon=plon(igood);
pjday=nan*plat;

for m=1:length(pfile)
	tmp=num2str(pdate(m));
	if length(tmp) ==14
	pjday(m)=date2jd(str2num(tmp(1:4)),str2num(tmp(5:6)),str2num(tmp(7:8)), ... 
					  str2num(tmp(9:10)),str2num(tmp(11:12)),str2num(tmp(13:14)));
	else
	pjday(m)=nan;
	end
end

%quality check
jj=find(plat>91 | plon>181 | plat<-91 | plon<-181);

pdate(jj)=nan;
plat(jj)=nan;
plon(jj)=nan;
pjday(jj)=nan;



ii=find(plon<0);
plon(ii) = 180+(180+plon(ii));

clear A fid tmp m 
					  
					  

