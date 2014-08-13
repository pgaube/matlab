global M
global N

N=3
M=2


%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 12;
endday = 31;

%construct date vector
startjd=2451381
endjd=2454831
jdays=startjd:endjd;
interp_jdays=[2451395:7:2454811];

load_path = '/home/wallaby/data/pgaube/data/qscat/mat/';
out_path = '/Volumes/matlab/data/QuickScat/new_mat/';
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);


split_domain
rs=1:length(r1);
cs=1:length(c1);



beta=single(nan(length(lat(:,1)),length(lat(1,:)),length(interp_jdays)));
subset_lt_chl=single(nan(length(rs),length(cs),length(jdays)));

for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(jdays)
        fname = [load_path 'global_' num2str(jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(jdays))
        if exist(fname)
        	load(fname, 'Dcrlstr')
        else
        	%gchl_day=nan*gchl_day;
        	Dwspd=nan*Dcrlstr;
        	fprintf('\r missing file    %s \n',fname)
        end
        subset_lt_chl(rs,cs,m)=single(Dcrlstr(r,c));
    end
    nump=length(rs)*length(cs);
    plac=1;
    for mm=1:length(rs)
        for nn=1:length(cs)
            rr=r(mm);
            rrs=rs(mm);
            cc=c(nn);
            ccs=cs(nn);
            fprintf('\r     Regressing Point %07u of %07u \r',plac,nump)
            plac=plac+1;
            [beta(rr,cc,:),flag]=smooth1d_loess(squeeze(subset_lt_chl(rrs,ccs,:)),jdays',35,interp_jdays');
        	fbad=nan*flag;
        	fbad(flag==1)=1;
        	tmp=squeeze(beta(rr,cc,:)).*fbad;
        	beta(rr,cc,:)=tmp;
        end
    end  
    fprintf('\n')
    subset_lt_chl=single(nan(length(rs),length(cs), ...
                      length(jdays)));
end

    
    for m=1:length(interp_jdays)
        fname = [out_path 'QSCAT_21_25km_' num2str(interp_jdays(m)) '.mat'];
        fprintf('\r     writing to file %03u of %03u \r',m,length(interp_jdays))
        Wcrlstr=beta(:,:,m);
        eval(['save ' fname ' W* lon lat jdays interp_jdays'])
    end
