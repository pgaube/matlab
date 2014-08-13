function loess_time_average_orbit(startjd,endjd)

%
% LOESS_TIME_AVERAGE_ORBIT(startjd,endjd)
%

global GRID_SWATH_DATA_OUTPUT_DIR
global DAILY_AVG_OUTPUT_DIR
global WEEKLY_AVG_OUTPUT_DIR
global MONTHLY_AVG_OUTPUT_DIR
global GRIDX GRIDY
global MATLAB_VERSION
global SL
global BEG_HEAD
global SY SX
global NAN_MATRIX
global MAX_DWDX MAX_DWSTRDX
global MAX_WSPD MAX_STRM
global TIME_SPAN
global LOESS_AVG_OUTPUT_DIR
global M
global N

set_grid_qscat_params

gridx = GRIDX;
gridy = GRIDY;
[lon,lat]=meshgrid(GRIDX(SX),GRIDY(SY));
 
%
% Retrieve the orbit numbers for the specified time interval
%

jdays=[startjd-(TIME_SPAN-1)/2:endjd+(TIME_SPAN-1)/2];
mid_week_jdays=[startjd:7:endjd];

[minyear,minmonth,mintmp]=jd2jdate(jdays(1));
[maxyear,maxmonth,maxtmp]=jd2jdate(max(jdays));

minday=julian(minmonth,mintmp,minyear,minyear);
maxday=julian(maxmonth,maxtmp,maxyear,maxyear);


[sel_orbit_num, sel_orbit_year, sel_orbit_day] = ...
                sel_qscat_orbit(minyear, maxyear, minday, maxday);
                              

[yy,mm,dd,h,h,h] = datevec(sel_orbit_day(1) + ...
                          datenum(sel_orbit_year(1),1,1)-1);
                          

fprintf('\rStart date: %02u/%02u/%4u %6u \n',mm,dd,yy,startjd)


%
% Compute the number of orbits and the number of points
% in the x and y directions
%

norbits = length(sel_orbit_num);
[yy,mm,dd,blank,blank,blank] = datevec(sel_orbit_day + ...
                          datenum(sel_orbit_year,1,1)-1);
                          
orbit_jdays=date2jd(yy,mm,dd)+.5;

fprintf('\rNumber of total orbits: %u \n',norbits)

%
% Compute a field of NaN's to use in resetting the sum and
% average matrices used in the weekly and monthly averages
%

nan_field = single(NAN_MATRIX(SY,SX));
	
% Since were gridding each swath individualy, the z-dim of the matrix to be gridded can vary.


    
for m=1:length(mid_week_jdays) %this is how offtern we have to do the regression
iorbit=find(orbit_jdays>=mid_week_jdays(m)-(TIME_SPAN-1)/2 & orbit_jdays<=mid_week_jdays(m)+(TIME_SPAN-1)/2);
tmp_minjd=min(orbit_jdays(iorbit));
tmp_maxjd=max(orbit_jdays(iorbit));
fprintf('\rNumber of orbits in this composite: %u \n',length(iorbit))

%
% since loess is always going to have same span and time dist, set up
%

clear xin w dt dist	
dt=[-(TIME_SPAN-1)/2:(TIME_SPAN-1)/(length(iorbit)-1):(TIME_SPAN-1)/2]';
dist_t=abs(dt);
w = 1 - dist_t.*dist_t.*dist_t; 
w = w.*w.*w;
 
xin(:,1) = w;
xin(:,2) = w.*dt;
xin(:,3) = xin(:,2).*dt;
	
for pp=1:M*N

%
% Initialize the row vector to store values for loess reg
%

    [tmp_swspd,     tmp_sdwspddx,  tmp_sdwspddy, ...
     tmp_sstrm,     tmp_sdstrmdx,  tmp_sdstrmdy, ...
     tmp_su,        tmp_sdudx,     tmp_sdudy, ...
     tmp_sv,        tmp_sdvdx,     tmp_sdvdy, ...
     tmp_sustr,     tmp_sdustrdx,  tmp_sdustrdy, ...
     tmp_svstr,     tmp_sdvstrdx,  tmp_sdvstrdy, ...
     tmp_sdiv,      tmp_scrl ...
     tmp_sdivstr,   tmp_scrlstr] = deal(single(1440*520/2/2,5)));
     
    [st_wspd,     st_dwspddx,  st_dwspddy, ...
     st_strm,     st_dstrmdx,  st_dstrmdy, ...
     st_u,        st_dudx,     st_dudy, ...
     st_v,        st_dvdx,     st_dvdy, ...
     st_ustr,     st_dustrdx,  st_dustrdy, ...
     st_vstr,     st_dvstrdx,  st_dvstrdy, ...
     st_div,      st_crl ...
     st_divstr,   st_crlstr] = deal(1);
     
     
%
% Initialize the matrix to store values for 21day averages
%

    [Wwspd,     Wwspddx,   Wdwspddy, ...
     Wstrm,     Wdstrmdx,  Wdstrmdy, ...
     Wu,        Wdudx,     Wdudy, ...
     Wv,        Wdvdx,     Wdvdy, ...
     Wustr,     Wdustrdx,  Wdustrdy, ...
     Wvstr,     Wdvstrdx,  Wdvstrdy, ...
     Wdiv,      Wcrl,      Wdwspdds,  Wdwspddn, ...
     Wdivstr,   Wcrlstr,   Wdstrmds,  Wdstrmdn] = deal(single(nan(ny,nx)));     


		for k=1:length(iorbit)
		fprintf('\r|  time level %01u of %02u | \r',k,length(iorbit))
     	%tmpndir = int(sel_orbit_num(iorbit(k))/1000)*1000;
     	fname = [GRID_SWATH_DATA_OUTPUT_DIR,BEG_HEAD, ...
     		 	num2str(sel_orbit_num(iorbit(k)),'%05u')];
        
     	
     	%[yy,mm,dd,h,h,h] = datevec(sel_orbit_day(k) + ...
     	%					  datenum(sel_orbit_year(k),1,1)-1);
     	%fprintf('%s		  %2u/%2u/%4u %6u \n',fname,mm,dd,yy,orbit_jdays(iorbit(k)))
       
     	[wspd, dwspddx, dwspddy, ...
     	strm, dstrmdx, dstrmdy, ...
     	u,	  dudx,	   dudy, ...
     	v,	  dvdx,	   dvdy, ...
     	ustr, dustrdx, dustrdy, ...
     	vstr, dvstrdx, dvstrdy] = ...
     				  read_grid_qscat_region(fname,gridx,gridy,1:18);
      
     	%subset by SX,SY
     	wspd	= (wspd(SY(r),SX(c)));
     	dwspddx = (dwspddx(SY(r),SX(c)));
     	dwspddy = (dwspddy(SY(r),SX(c)));
     	strm	= (strm(SY(r),SX(c)));
     	dstrmdx = (dstrmdx(SY(r),SX(c)));
     	dstrmdy = (dstrmdy(SY(r),SX(c)));
     	u		= (u(SY(r),SX(c)));
     	dudx	= (dudx(SY(r),SX(c)));
     	dudy	= (dudy(SY(r),SX(c)));
     	v		= (v(SY(r),SX(c)));
     	dvdx	= (dvdx(SY(r),SX(c)));
     	dvdy	= (dvdy(SY(r),SX(c)));
     	ustr	= (ustr(SY(r),SX(c)));
     	dustrdx = (dustrdx(SY(r),SX(c)));
     	dustrdy = (dustrdy(SY(r),SX(c)));
     	vstr	= (vstr(SY(r),SX(c)));
     	dvstrdx = (dvstrdx(SY(r),SX(c)));
     	dvstrdy = (dvstrdy(SY(r),SX(c)));
     	
     	
     	%force to row vector
     	wspd	= (wspd(:));
     	dwspddx = (dwspddx(:));
     	dwspddy = (dwspddy(:));
     	strm	= (strm(:));
     	dstrmdx = (dstrmdx(:));
     	dstrmdy = (dstrmdy(:));
     	u		= (u(:));
     	dudx	= (dudx(:));
     	dudy	= (dudy(:));
     	v		= (v(:));
     	dvdx	= (dvdx(:));
     	dvdy	= (dvdy(:));
     	ustr	= (ustr(:));
     	dustrdx = (dustrdx(:));
     	dustrdy = (dustrdy(:));
     	vstr	= (vstr(:));
     	dvstrdx = (dvstrdx(:));
     	dvstrdy = (dvstrdy(:));
     	
     	
     	%get rid of crap
     	wspd	= (wspd(~isnan(wspd));
     	dwspddx = (dwspddx(~isnan(dwspddx));
     	dwspddy = (dwspddy(~isnan(dwspddy));
     	strm	= (strm(~isnan(strm));
     	dstrmdx = (dstrmdx(~isnan(dstrmdx));
     	dstrmdy = (dstrmdy(~isnan(dstrmdy));
     	u		= (u(~isnan(u));
     	dudx	= (dudx(~isnan(dudx));
     	dudy	= (dudy(~isnan(dudy));
     	v		= (v(~isnan(v));
     	dvdx	= (dvdx(~isnan(dvdx));
     	dvdy	= (dvdy(~isnan(dvdy));
     	ustr	= (ustr(~isnan(ustr));
     	dustrdx = (dustrdx(~isnan(dustrdx));
     	dustrdy = (dustrdy(~isnan(dustrdy));
     	vstr	= (vstr(~isnan(vstr));
     	dvstrdx = (dvstrdx(~isnan(dvstrdx));
     	dvstrdy = (dvstrdy(~isnan(dvstrdy));
     	
     	% Perform quality control checks
     
     	wspd(abs(wspd)>MAX_WSPD) = NaN;
	 	u(abs(u)>MAX_WSPD) = NaN;
	 	v(abs(v)>MAX_WSPD) = NaN;
	 	strm(abs(strm)>MAX_STRM) = NaN;
	 	ustr(abs(ustr)>MAX_STRM) = NaN;
	 	vstr(abs(vstr)>MAX_STRM) = NaN;
	 	dudx(abs(dudx)>MAX_DWDX) = NaN;
	 	dudy(abs(dudy)>MAX_DWDX) = NaN;
	 	dvdx(abs(dvdx)>MAX_DWDX) = NaN;
	 	dvdy(abs(dvdy)>MAX_DWDX) = NaN;
	 	dwspddx(abs(dwspddx)>MAX_DWDX) = NaN;
	 	dwspddy(abs(dwspddy)>MAX_DWDX) = NaN;
	 	dustrdx(abs(dustrdx)>MAX_DWSTRDX) = NaN;
	 	dustrdy(abs(dustrdy)>MAX_DWSTRDX) = NaN;
	 	dvstrdx(abs(dvstrdx)>MAX_DWSTRDX) = NaN;
	 	dvstrdy(abs(dvstrdy)>MAX_DWSTRDX) = NaN;
	 	dstrmdx(abs(dstrmdx)>MAX_DWSTRDX) = NaN;
	 	dstrmdy(abs(dstrmdy)>MAX_DWSTRDX) = NaN;
     
     	% Compute derived quantities
     	  
     	wdir	= atan2(v,u);
     	div		= dudx + dvdy;
     	crl		= dvdx - dudy;
     	divstr	= dustrdx + dvstrdy;
     	crlstr	= dvstrdx - dustrdy;
     	
     	% convert to single percision
     	wspd	= single(wspd);
     	dwspddx = single(dwspddx);
     	dwspddy = single(dwspddy);
     	strm	= single(strm);
     	dstrmdx = single(dstrmdx);
     	dstrmdy = single(dstrmdy);
     	u		= single(u);
     	dudx	= single(dudx);
     	dudy	= single(dudy);
     	v		= single(v);
     	dvdx	= single(dvdx);
     	dvdy	= single(dvdy);
     	ustr	= single(ustr);
     	dustrdx = single(dustrdx);
     	dustrdy = single(dustrdy);
     	vstr	= single(vstr);
     	dvstrdx = single(dvstrdx);
     	dvstrdy = single(dvstrdy);
     	div		= single(div);
     	crl		= single(crl);
     	divstr	= single(divstr);
     	crlstr	= single(crlstr);
        
        %place into tmp_* arrays
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
     	tmp_dsdwspddxdx(st_ddwspddxdx:st_st_dwspddx-1+length(dwspddx(:));
        st_dwspddx=st_dwspddx+length(dwspddx(:));
        tmp_sdwspddy(st_dwspddy:st_st_dwspddy-1+length(dwspddy(:));
        st_dwspddy=st_dwspddy+length(dwspddy(:));
        tmp_sstrm(st_strm:st_st_strm-1+length(strm(:));
        st_strm=st_strm+length(strm(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_swspd(st_wspd:st_st_wspd-1+length(wspd(:));
        st_wspd=st_wspd+length(wspd(:));
        tmp_sdwspddx(:,:,k) = dwspddx;
     	tmp_sdwspddy(:,:,k) = dwspddy;
     
     	tmp_sstrm(:,:,k)	= strm;
     	tmp_sdstrmdx(:,:,k) = dstrmdx;
     	tmp_sdstrmdy(:,:,k) = dstrmdy;
     
     	tmp_su(:,:,k)		= u;
     	tmp_sdudx(:,:,k)	= dudx;
     	tmp_sdudy(:,:,k)	= dudy;
     
     	tmp_sv(:,:,k)		= v;
     	tmp_sdvdx(:,:,k)	= dvdx;
     	tmp_sdvdy(:,:,k)	= dvdy;
     
     	tmp_sustr(:,:,k)	= ustr;
     	tmp_sdustrdx(:,:,k) = dustrdx;
     	tmp_sdustrdy(:,:,k) = dustrdy;
     
     	tmp_svstr(:,:,k)	= vstr;
     	tmp_sdvstrdx(:,:,k) = dvstrdx;
     	tmp_sdvstrdy(:,:,k) = dvstrdy;
     
     	tmp_sdiv(:,:,k)		= div;
     	tmp_scrl(:,:,k)		= crl;
     
     	tmp_sdivstr(:,:,k)	= divstr;
     	tmp_scrlstr(:,:,k)	= crlstr;
		end
		
	
    	for m=1:length(r)
    	for n=1:length(c)
    		B = xin \ (w.*tmp_scrl(m,n));
    		Wcrl(r(m),c(n)) = B(1);
    	end
    	end
    end
    
    figure(101)
    clf
    pcolor(lon,lat,Wcrl.*1e5);shading flat
    caxis([-2 2])
    % Generate complete weekly output filename
    
    Woutname = [LOESS_AVG_OUTPUT_DIR,BEG_HEAD, ...
                           num2str(mid_week_jday(m)),'.mat'];

    % Save the weekly-averaged file

    fprintf('Woutname=%s\n',Woutname)
    save(Woutname,'Wcrl')
    
    %{
    save(Woutname,'Wwspd','Wdwspddx','Wdwspddy', ...
                                'Wstrm','Wdstrmdx','Wdstrmdy', ...
                                'Wu','Wdudx','Wdudy', ...
                                'Wv','Wdvdx','Wdvdy', ...
                                'Wustr','Wdustrdx','Wdustrdy', ...
                                'Wvstr','Wdvstrdx','Wdvstrdy', ...
                                'Wdiv','Wcrl','Wdwspdds','Wdwspddn', ...
                                'Wdivstr','Wcrlstr','Wdstrmds','Wdstrmdn', ...
                                'Wcwspd','Wcdwspddx','Wcdwspddy', ...
                                'Wcstrm','Wcdstrmdx','Wcdstrmdy', ...
                                'Wcu','Wcdudx','Wcdudy', ...
                                'Wcv','Wcdvdx','Wcdvdy', ...
                                'Wcustr','Wcdustrdx','Wcdustrdy', ...
                                'Wcvstr','Wcdvstrdx','Wcdvstrdy', ...
                                'Wcdiv','Wccrl','Wcdwspdds','Wcdwspddn', ...
                                'Wcdivstr','Wccrlstr','Wcdstrmds','Wcdstrmdn')
     %}                          
   end
   


