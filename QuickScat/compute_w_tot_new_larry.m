clear all
mon_str={'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'};
data_in='Dstrcrl'
data_out='crlstr_week'


% startjd=date2jd(1999,7,19)+.5;
% endjd=date2jd(2009,11,19)+.5;

startjd=2452466-15;
endjd=2455126+15;
path_in='~/data/QuickScat/new_larry/jan14_exp20_'
path_out='~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_'
dt=30

load ~/data/QuickScat/new_larry/jan14_exp20_1999-output lat lon
[lon,lat]=meshgrid(lon,lat);
global M
global N

N=2;
M=2;


interp_jdays=[2452466:7:2455126];
jdays=[startjd:endjd];

load_path = path_in;
split_domain
rs=1:length(r1);
cs=1:length(c1);

eval([data_in ' = nan(560,1440);'])

beta=single(nan(length(lat(:,1)),length(lon(1,:)),length(interp_jdays)));
subset_lt_chl=single(nan(length(rs),length(cs),length(jdays)));

[years,months,days]=jd2jdate(jdays);
uy=unique(years);

for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    
    for m=1:length(uy)
        isamejd=find(years==uy(m));  %these are the jdays indices for this year
        fname = [load_path num2str(uy(m)) '-output.mat'];
        load(fname,'Dstrcrl','time_datenum')
        [matyear,matmonth,matday]=datevec(time_datenum);
        matjd=date2jd(matyear,matmonth,matday)+.5;
        idatenum=sames(jdays(isamejd),matjd);
        if any(idatenum)
%             num2str(uy(m))
            eval(['subset_lt_chl(rs,cs,isamejd)=single(' data_in '(r,c,idatenum));']);
        else
            display(['nomatching date ',num2str(uy(m))])
        end
        clear idatenum matjd matyear matmonth matday Dstrcrl time_datenum
    end
    nump=length(rs)*length(cs);
    plac=1;
    for mm=1:length(rs)
        for nn=1:length(cs)
            rr=r(mm);
            rrs=rs(mm);
            cc=c(nn);
            ccs=cs(nn);
            %                 display(['Regressing Point %07u of %07u ',plac,nump])
            plac=plac+1;

            [tmp]=smooth1d_loess(squeeze(subset_lt_chl(rrs,ccs,:)),jdays',dt,interp_jdays');
            
            beta(rr,cc,:)=tmp;
            
        end
    end
    fprintf('\n')
    subset_lt_chl=nan*subset_lt_chl;
end






%now write output
for m=1:length(interp_jdays)
    fname = [path_out num2str(interp_jdays(m)) '.mat'];
    fprintf('\r     writing to file %03u of %03u \r',m,length(interp_jdays))
    eval([data_out '=beta(:,:,m);'])
    if exist(fname)
        eval(['save -append ' fname ' *' data_out])
    else
        eval(['save ' fname ' *' data_out ' lat lon'])
    end
end

