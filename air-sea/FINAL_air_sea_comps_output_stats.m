clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA'};


nn=1;
for m=[5 4 3 1 6 2]
yab(nn)=curs(m)
load(['V6_',curs{m},'_comps'])
lab(1)={'cc wek'};
lab(2)={'ac wek'};
lab(3)={'current cc wek'};
lab(4)={'current ac wek'};
lab(5)={'sst cc wek'};
lab(6)={'sst ac wek'};


%raw wek
eval(['tmp = ',curs{m},'_wek_total_qscat_c;'])
tab(nn,1)=min(tmp.mean(:));
eval(['tmp = ',curs{m},'_wek_total_qscat_a;'])
tab(nn,2)=max(tmp.mean(:));


%current wek
eval(['tmp = ',curs{m},'_wek_total_c;'])
tab(nn,3)=min(tmp.mean(:));
eval(['tmp = ',curs{m},'_wek_total_a;'])
tab(nn,4)=max(tmp.mean(:));

%sst wek
eval(['tmp = ',curs{m},'_wek_sst_c;'])
tab(nn,5)=min(tmp.mean(:));
eval(['tmp = ',curs{m},'_wek_sst_a;'])
tab(nn,6)=max(tmp.mean(:));

nn=nn+1;
end
clearallbut lab tab yab
lab 
yab
tab



	