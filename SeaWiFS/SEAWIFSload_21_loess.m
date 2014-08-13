global M
global N

N=3
M=3


%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 12;
endday = 31;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
interp_jdays=[startjd:7:endjd];


load_path = '/home/wallaby/data/pgaube/data/seawifs/mat/'
load([load_path,'SCHL_9_D_2450821'],'jdays')
load(['/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_2450821'],'glon','glat')
lat=single(glat);
lon=single(glon);

split_domain
rs=1:length(r1);
cs=1:length(c1);



beta=single(nan(length(lat(:,1)),length(lat(1,:)),length(interp_jdays)));
beta_hp=beta;
subset_lt_chl=single(nan(length(rs),length(cs),length(jdays)));

for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(jdays)
        fname = [load_path 'SCHL_9_D_' num2str(jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(jdays))
        if exist(fname)
        	load(fname, 'gchl_day')
        else
        	gchl_day=nan*gchl_day;
        end
        subset_lt_chl(rs,cs,m)=single(gchl_day(r,c));
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
            [interm,flag]=smooth1d_loess(squeeze(log10(subset_lt_chl(rrs,ccs,:))),jdays',35,interp_jdays');
        	fbad=nan*flag;
        	fbad(flag==1)=1;
        	tmp=interm.*fbad;
        	%remove longterm mean
        	lp=smooth1d_loess(tmp,interp_jdays',500,interp_jdays');
        	beta(rr,cc,:)=tmp;
        	beta_hp(rr,cc,:)=tmp-lp;
        end
    end  
    fprintf('\n')
    subset_lt_chl=nan*subset_lt_chl;
    save seawifs_filter_temp beta*
end

    
    for m=1:length(interp_jdays)
        fname = ['/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_' num2str(interp_jdays(m)) '.mat'];
        fprintf('\r     writing to file %03u of %03u \r',m,length(interp_jdays))
        gchl_week=beta(:,:,m);
        hp_gchl_week=beta_hp(:,:,m);
        eval(['save -append ' fname ' *gchl_week'])
    end
