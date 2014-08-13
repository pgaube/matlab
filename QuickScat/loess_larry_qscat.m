clear all
mon_str={'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'};
data_in='qscat.u'
data_out='u_week'


startjd=date2jd(1999,7,19)+.5;
endjd=date2jd(2009,11,19)+.5;
path_in='/home/wallaby/data/pgaube/data/qscat/daily/oct12_exp22_qscat_'
path_out='~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_'
dt=30

load /home/wallaby/data/pgaube/data/qscat/daily/oct12_exp22_qscat_aug2000-output.mat
lat=qscat.lat;
lon=qscat.lon;
[lon,lat]=meshgrid(lon,lat);
global M
global N

N=2;
M=2;

interp_jdays=[2451381+7:7:2455154-7];
jdays=[startjd:endjd];

load_path = path_in;
split_domain
rs=1:length(r1);
cs=1:length(c1);

eval([data_in ' = nan(560,1440);'])

beta=single(nan(length(lat(:,1)),length(lon(1,:)),length(interp_jdays)));
beta_hp=beta;
subset_lt_chl=single(nan(length(rs),length(cs),length(jdays)));
cname='t';
for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(jdays)
    	[year,month,day]=jd2jdate(jdays(m));
        fname = [load_path mon_str{month} num2str(year) '-output.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(jdays))
        tesst=strcmp(fname,cname);
        if tesst~=1
        	if exist(fname)
        		load(fname)
        		[dud,dud,ddd]=datevec(qscat.datenum);
        	else
        		fprintf('\r missing file \n')
        		fname
        		eval([data_in '= nan(560,1440);'])
        	end
        end	
        zp=find(ddd==day);
        if any(zp)
        	eval(['subset_lt_chl(rs,cs,m)=single(' data_in '(r,c,zp));'])
        	cname=fname;
        else
        	clear ddd
        end	
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
