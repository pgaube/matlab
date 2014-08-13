%function loess_time(data_in,data_out,lat,lon,startjd,endjd,path_in,path_out,dt,METHOD)
%
%
% Input
% data_in = string with name of data to be loaded
% data_out = string ouf output data
% lat = vector of latitudes
% lon = vector of longitudes
% startjd, endjd = first and last jd to be interplolated to
% pat_in = string of input path with file header
% path_out = string of output path with file header
% dt = time span of loess
% METHOD = options are as follows
%			log_hp_flag
%			log_flag
%			log_hp
%			hp_flag
%			flag
%			none
%			
clear all
close all
data_in='sst_oi'
data_out='sst_200_day'

STEP=.25;
LON=[0.125:STEP:359.875];
LAT=[-89.875:STEP:89.875];
lon=ones(length(LAT),1)*LON;
lat=LAT'*ones(1,length(lon(1,:)));


startjd=2452459;
endjd=2454489;
jdays=startjd:endjd;
path_in='/Volumes/matlab/data/ReynoldsSST/mat/OI_25_D_'
path_out='/Volumes/matlab/data/ReynoldsSST/mat/OI_25_30_'
dt=200
METHOD='none'

global M
global N

N=2;
M=2;

interp_jdays=[startjd:7:endjd];

load_path = path_in;
split_domain
rs=1:length(r1);
cs=1:length(c1);



load_path = path_in;
split_domain
rs=1:length(r1);
cs=1:length(c1);



beta=single(nan(length(lat(:,1)),length(lon(1,:)),length(interp_jdays)));
beta_hp=beta;
subset_lt_chl=single(nan(length(rs),length(cs),length(jdays)));
sst_oi=nan(420,1440);

for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(jdays)
        fname = [load_path num2str(jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(jdays))
       if exist(fname)
        	load(fname, data_in)
        else
        	fprintf('\r missing file \n')
        	fname
        	eval([data_in '= nan*' data_in ';'])
        end
        eval(['subset_lt_chl(rs,cs,m)=single(' data_in '(r,c));'])
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
            switch METHOD
            case {'log_hp_flag'}
            	[interm,flag]=smooth1d_loess(squeeze(log10(subset_lt_chl(rrs,ccs,:))),jdays',dt,interp_jdays');
        		fbad=nan*flag;
        		fbad(flag==1)=1;
        		tmp=interm.*fbad;
        		%remove longterm mean
        		lp=smooth1d_loess(tmp,interp_jdays',500,interp_jdays');
        		beta(rr,cc,:)=tmp;
        		beta_hp(rr,cc,:)=tmp-lp;
        	case {'log_flag'}
            	[interm,flag]=smooth1d_loess(squeeze(log10(subset_lt_chl(rrs,ccs,:))),jdays',dt,interp_jdays');
        		fbad=nan*flag;
        		fbad(flag==1)=1;
        		tmp=interm.*fbad;
        	case {'log_hp'}
            	[tmp]=smooth1d_loess(squeeze(log10(subset_lt_chl(rrs,ccs,:))),jdays',dt,interp_jdays');
        		%remove longterm mean
        		lp=smooth1d_loess(tmp,interp_jdays',500,interp_jdays');
        		beta(rr,cc,:)=tmp;	
        	case {'hp_flag'}
            	[interm,flag]=smooth1d_loess(squeeze(subset_lt_chl(rrs,ccs,:)),jdays',dt,interp_jdays');
        		fbad=nan*flag;
        		fbad(flag==1)=1;
        		tmp=interm.*fbad;
        		%remove longterm mean
        		lp=smooth1d_loess(tmp,interp_jdays',500,interp_jdays');
        		beta(rr,cc,:)=tmp;
        		beta_hp(rr,cc,:)=tmp-lp;
        	case {'flag'}
            	[interm,flag]=smooth1d_loess(squeeze(subset_lt_chl(rrs,ccs,:)),jdays',dt,interp_jdays');
        		fbad=nan*flag;
        		fbad(flag==1)=1;
        		tmp=interm.*fbad;
        		beta(rr,cc,:)=tmp;
       		case {'none'}
            	[tmp]=smooth1d_loess(squeeze(subset_lt_chl(rrs,ccs,:)),jdays',dt,interp_jdays');
        		beta(rr,cc,:)=tmp;
        	end	
        		
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
        switch METHOD
        	case {'log_hp_flag'}
       			eval(['hp_' data_out '=beta_hp(:,:,m);'])
       		case {'log_hp'}
       			eval(['hp_' data_out '=beta_hp(:,:,m);'])
       		case {'hp_flag'}
       			eval(['hp_' data_out '=beta_hp(:,:,m);'])	
       	end		
        eval(['save -append ' fname ' *' data_out ' lon lat'])
    end
