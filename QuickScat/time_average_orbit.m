function time_average_orbit(startjd,endjd)

%
% TIME_AVERAGE_ORBIT(startjd,endjd)
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

set_grid_qscat_params

gridx = GRIDX;
gridy = GRIDY;
[lon,lat]=meshgrid(GRIDX(SX),GRIDY(SY));

% Check to make sure that at least one of the output directories exists

if isempty(DAILY_AVG_OUTPUT_DIR) & ...
   isempty(WEEKLY_AVG_OUTPUT_DIR),

   error('TIME_AVERAGE_ORBIT.M: No daily or weekly averaging was selected. All output directories were empty.')

end

%
% Retrieve the orbit numbers for the specified time interval
%
jdays=[startjd-3:endjd-3];
icheckjd=1;

[minyear,minmonth,mintmp]=jd2jdate(startjd-3);
[maxyear,maxmonth,maxtmp]=jd2jdate(endjd+3);

minday=julian(minmonth,mintmp,minyear,minyear);
maxday=julian(maxmonth,maxtmp,maxyear,maxyear);


[sel_orbit_num, sel_orbit_year, sel_orbit_day] = ...
                sel_qscat_orbit(minyear, maxyear, minday, maxday);

%
% Find the month number corresponding to the serial day
% number -- used for the monthly averages
%

sel_orbit_datevec = datenum(sel_orbit_year,1,sel_orbit_day);
date_vector = datevec(sel_orbit_datevec);
sel_orbit_mon = date_vector(:,2);

[yy,mm,dd,h,h,h] = datevec(sel_orbit_day(1) + ...
                          datenum(sel_orbit_year(1),1,1)-1);


fprintf('\rStart date: %02u/%02u/%4u \n',mm,dd,yy)

%sel_orbit_serial_day = datenum(sel_orbit_year,0,sel_orbit_day);

%
% Compute the number of orbits and the number of points
% in the x and y directions
%

norbits = length(sel_orbit_num);
nx = length(SX);
ny = length(SY);

fprintf('\rNumber of orbits: %u \n',norbits)
%
% Compute a field of NaN's to use in resetting the sum and
% average matrices used in the weekly and monthly averages
%

nan_field = single(NAN_MATRIX(SY,SX));

%
% Initialize the daily, weekly and monthly sums and counters
%

[cwspd,   cdwspddx, cdwspddy, ...
 cstrm,   cdstrmdx, cdstrmdy, ...
 cu,      cdudx,    cdudy, ...
 cv,      cdvdx,    cdvdy, ...
 custr,   cdustrdx, cdustrdy, ...
 cvstr,   cdvstrdx, cdvstrdy, ...
 cdiv,    ccrl,     cdwspdds, cdwspddn, ...
 cdivstr, ccrlstr,  cdstrmds, cdstrmdn] = deal(zeros(ny,nx,'uint8'));
[swspd,   sdwspddx, sdwspddy, ...
 sstrm,   sdstrmdx, sdstrmdy, ...
 su,      sdudx,    sdudy, ...
 sv,      sdvdx,    sdvdy, ...
 sustr,   sdustrdx, sdustrdy, ...
 svstr,   sdvstrdx, sdvstrdy, ...
 sdiv,    scrl,     sdwspdds, sdwspddn, ...
 sdivstr, scrlstr,  sdstrmds, sdstrmdn] = deal(zeros(ny,nx,'single'));

if ~isempty(WEEKLY_AVG_OUTPUT_DIR),

    [Wcwspd,     Wcdwspddx,  Wcdwspddy, ...
     Wcstrm,     Wcdstrmdx,  Wcdstrmdy, ...
     Wcu,        Wcdudx,     Wcdudy, ...
     Wcv,        Wcdvdx,     Wcdvdy, ...
     Wcustr,     Wcdustrdx,  Wcdustrdy, ...
     Wcvstr,     Wcdvstrdx,  Wcdvstrdy, ...
     Wcdiv,      Wccrl,      Wcdwspdds,  Wcdwspddn, ...
     Wcdivstr,   Wccrlstr,   Wcdstrmds,  Wcdstrmdn] = deal(zeros(ny,nx,'uint8'));
    [Wswspd,     Wsdwspddx,  Wsdwspddy, ...
     Wsstrm,     Wsdstrmdx,  Wsdstrmdy, ...
     Wsu,        Wsdudx,     Wsdudy, ...
     Wsv,        Wsdvdx,     Wsdvdy, ...
     Wsustr,     Wsdustrdx,  Wsdustrdy, ...
     Wsvstr,     Wsdvstrdx,  Wsdvstrdy, ...
     Wsdiv,      Wscrl,      Wsdwspdds,  Wsdwspddn, ...
     Wsdivstr,   Wscrlstr,   Wsdstrmds,  Wsdstrmdn] = deal(zeros(ny,nx,'single'));

end



%
% Variable to count the number of days -- needed to count
% to 7 for the weekly averages
%

Nw = 0;

for k=1:norbits

   tmpndir = int(sel_orbit_num(k)/1000)*1000;

   checkjd=date2jd(yy,mm,dd)+.5;

   fname = [GRID_SWATH_DATA_OUTPUT_DIR,BEG_HEAD, ...
               num2str(sel_orbit_num(k),'%05u')];
   
   [yy,mm,dd,h,h,h] = datevec(sel_orbit_day(k) + ...
                          datenum(sel_orbit_year(k),1,1)-1);

   fprintf('%s       %2u/%2u/%4u \n',fname,mm,dd,yy)

%   disp(fname)
   
  
       [wspd, dwspddx, dwspddy, ...
    strm, dstrmdx, dstrmdy, ...
    u,    dudx,    dudy, ...
    v,    dvdx,    dvdy, ...
    ustr, dustrdx, dustrdy, ...
    vstr, dvstrdx, dvstrdy] = ...
                  read_grid_qscat_region(fname,gridx,gridy,1:18);
 

   wspd    = (wspd(SY,SX));
   dwspddx = (dwspddx(SY,SX));
   dwspddy = (dwspddy(SY,SX));
   strm    = (strm(SY,SX));
   dstrmdx = (dstrmdx(SY,SX));
   dstrmdy = (dstrmdy(SY,SX));
   u       = (u(SY,SX));
   dudx    = (dudx(SY,SX));
   dudy    = (dudy(SY,SX));
   v       = (v(SY,SX));
   dvdx    = (dvdx(SY,SX));
   dvdy    = (dvdy(SY,SX));
   ustr    = (ustr(SY,SX));
   dustrdx = (dustrdx(SY,SX));
   dustrdy = (dustrdy(SY,SX));
   vstr    = (vstr(SY,SX));
   dvstrdx = (dvstrdx(SY,SX));
   dvstrdy = (dvstrdy(SY,SX));
   
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
      
   wdir    = atan2(v,u);
   div     = dfdx(lat,u,.25)+dfdy(v,.25);
   crl     = dfdx(lat,v,.25)-dfdy(u,.25);
   %div     = dudx + dvdy;
   %crl     = dvdx - dudy;
   dwspdds =  cos(wdir).*dwspddx + sin(wdir).*dwspddy;
   dwspddn = -sin(wdir).*dwspddx + cos(wdir).*dwspddy;
%   udwspddx=  cos(wdir).*dwspddx;
%   vdwspddx=  sin(wdir).*dwspddx;
%   udwspddy=  cos(wdir).*dwspddy;
%   vdwspddy=  sin(wdir).*dwspddy;
      
   divstr  = dfdx(lat,ustr,.25)+dfdy(vstr,.25);
   crlstr  = dfdx(lat,vstr,.25)-dfdy(ustr,.25);
   %divstr  = dustrdx + dvstrdy;
   %crlstr  = dvstrdx - dustrdy;
   dstrmds =  cos(wdir).*dstrmdx + sin(wdir).*dstrmdy;
   dstrmdn = -sin(wdir).*dstrmdx + cos(wdir).*dstrmdy;
%   udstrmdx=  cos(wdir).*dstrmdx;
%   vdstrmdx=  sin(wdir).*dstrmdx;
%   udstrmdy=  cos(wdir).*dstrmdy;
%   vdstrmdy=  sin(wdir).*dstrmdy;

   wspd    = single(wspd);
   dwspddx = single(dwspddx);
   dwspddy = single(dwspddy);
   strm    = single(strm);
   dstrmdx = single(dstrmdx);
   dstrmdy = single(dstrmdy);
   u       = single(u);
   dudx    = single(dudx);
   dudy    = single(dudy);
   v       = single(v);
   dvdx    = single(dvdx);
   dvdy    = single(dvdy);
   ustr    = single(ustr);
   dustrdx = single(dustrdx);
   dustrdy = single(dustrdy);
   vstr    = single(vstr);
   dvstrdx = single(dvstrdx);
   dvstrdy = single(dvstrdy);
   div     = single(div);
   crl     = single(crl);
   dwspdds = single(dwspdds);
   dwspddn = single(dwspddn);
   divstr  = single(divstr);
   crlstr  = single(crlstr);
   dstrmds = single(dstrmds);
   dstrmdn = single(dstrmdn);
   
   [swspd,    cwspd]    = sumcnt_work_function(wspd,    swspd,    cwspd);
   [sdwspddx, cdwspddx] = sumcnt_work_function(dwspddx, sdwspddx, cdwspddx);
   [sdwspddy, cdwspddy] = sumcnt_work_function(dwspddy, sdwspddy, cdwspddy);

   [sstrm,    cstrm]    = sumcnt_work_function(strm,    sstrm,    cstrm);
   [sdstrmdx, cdstrmdx] = sumcnt_work_function(dstrmdx, sdstrmdx, cdstrmdx);
   [sdstrmdy, cdstrmdy] = sumcnt_work_function(dstrmdy, sdstrmdy, cdstrmdy);

   [su,       cu]       = sumcnt_work_function(u,       su,       cu);
   [sdudx,    cdudx]    = sumcnt_work_function(dudx,    sdudx,    cdudx);
   [sdudy,    cdudy]    = sumcnt_work_function(dudy,    sdudy,    cdudy);

   [sv,       cv]       = sumcnt_work_function(v,       sv,       cv);
   [sdvdx,    cdvdx]    = sumcnt_work_function(dvdx,    sdvdx,    cdvdx);
   [sdvdy,    cdvdy]    = sumcnt_work_function(dvdy,    sdvdy,    cdvdy);

   [sustr,    custr]    = sumcnt_work_function(ustr,    sustr,    custr);
   [sdustrdx, cdustrdx] = sumcnt_work_function(dustrdx, sdustrdx, cdustrdx);
   [sdustrdy, cdustrdy] = sumcnt_work_function(dustrdy, sdustrdy, cdustrdy);

   [svstr,    cvstr]    = sumcnt_work_function(vstr,    svstr,    cvstr);
   [sdvstrdx, cdvstrdx] = sumcnt_work_function(dvstrdx, sdvstrdx, cdvstrdx);
   [sdvstrdy, cdvstrdy] = sumcnt_work_function(dvstrdy, sdvstrdy, cdvstrdy);

   [sdiv,     cdiv]     = sumcnt_work_function(div,     sdiv,     cdiv);
   [scrl,     ccrl]     = sumcnt_work_function(crl,     scrl,     ccrl);
   [sdwspdds, cdwspdds] = sumcnt_work_function(dwspdds, sdwspdds, cdwspdds);
   [sdwspddn, cdwspddn] = sumcnt_work_function(dwspddn, sdwspddn, cdwspddn);

   [sdivstr,  cdivstr]  = sumcnt_work_function(divstr,  sdivstr,  cdivstr);
   [scrlstr,  ccrlstr]  = sumcnt_work_function(crlstr,  scrlstr,  ccrlstr);
   [sdstrmds, cdstrmds] = sumcnt_work_function(dstrmds, sdstrmds, cdstrmds);
   [sdstrmdn, cdstrmdn] = sumcnt_work_function(dstrmdn, sdstrmdn, cdstrmdn);
      
%   [sudwspddx,cudwspddx]= sumcnt_work_function(udwspddx,sudwspddx,cudwspddx);
%   [svdwspddx,cvdwspddx]= sumcnt_work_function(vdwspddx,svdwspddx,cvdwspddx);
%   [sudwspddy,cudwspddy]= sumcnt_work_function(udwspddy,sudwspddy,cudwspddy);
%   [svdwspddy,cvdwspddy]= sumcnt_work_function(vdwspddy,svdwspddy,cvdwspddy);

%   [sudstrmdx,cudstrmdx]= sumcnt_work_function(udstrmdx,sudstrmdx,cudstrmdx);
%   [svdstrmdx,cvdstrmdx]= sumcnt_work_function(vdstrmdx,svdstrmdx,cvdstrmdx);
%   [sudstrmdy,cudstrmdy]= sumcnt_work_function(udstrmdy,sudstrmdy,cudstrmdy);
%   [svdstrmdy,cvdstrmdy]= sumcnt_work_function(vdstrmdy,svdstrmdy,cvdstrmdy);

   %----------------------------------------------------------
   % Perform check for averages
   %----------------------------------------------------------

   if ~isempty(DAILY_AVG_OUTPUT_DIR) & ...
       (k==norbits || sel_orbit_day(k) ~= sel_orbit_day(k+1)),
       
       % Perform the daily average of select fields
       
       Dwspd     = avg_work_function(nan_field,    swspd,    cwspd);
       Dstrm     = avg_work_function(nan_field,    sstrm,    cstrm);
       Du        = avg_work_function(nan_field,       su,       cu);
       Dv        = avg_work_function(nan_field,       sv,       cv);
       Dustr     = avg_work_function(nan_field,    sustr,    custr);
       Dvstr     = avg_work_function(nan_field,    svstr,    cvstr);
       Ddiv      = avg_work_function(nan_field,     sdiv,     cdiv);
       Dcrl      = avg_work_function(nan_field,     scrl,     ccrl);
       Ddivstr   = avg_work_function(nan_field,  sdivstr,  cdivstr);
       Dcrlstr   = avg_work_function(nan_field,  scrlstr,  ccrlstr);
       
       % Generate the day, month, and year numbers corresponding to this
       % orbit to be used in generating the filenames

       [yy,mm,dd,h,h,h] = datevec(sel_orbit_day(k) + ...
                          datenum(sel_orbit_year(k),1,1)-1);
   		
   	jd=date2jd(yy,mm,dd)+.5;
   		
       % Generate complete daily output filename

       Doutname = [DAILY_AVG_OUTPUT_DIR,BEG_HEAD, ...
                   num2str(jd),'.mat'];
       
       % Save the daily-averaged file
       
       fprintf('Doutname=%s\n',Doutname)

       if MATLAB_VERSION > 6,
          save(Doutname,'Dwspd','Dstrm','Du','Dv','Dustr','Dvstr', ...
                        'Ddiv','Dcrl','Ddivstr','Dcrlstr', ...
                        'cwspd','cstrm','cu','cv','custr','cvstr', ...
                        'cdiv','ccrl','cdivstr','ccrlstr','-V6')
       else,
          save(Doutname,'Dwspd','Dstrm','Du','Dv','Dustr','Dvstr', ...
                        'Ddiv','Dcrl','Ddivstr','Dcrlstr', ...
                        'cwspd','cstrm','cu','cv','custr','cvstr', ...
                        'cdiv','ccrl','cdivstr','ccrlstr')
       end
       
       %----------------------------------------------------------
       % Perform updates of the weekly fields
       %----------------------------------------------------------
       
       if ~isempty(WEEKLY_AVG_OUTPUT_DIR),

           [Wswspd,    Wcwspd]    = sumcnt2_work_function(Wswspd,    Wcwspd,    swspd, cwspd);
           [Wsdwspddx, Wcdwspddx] = sumcnt2_work_function(Wsdwspddx, Wcdwspddx, sdwspddx, cdwspddx);
           [Wsdwspddy, Wcdwspddy] = sumcnt2_work_function(Wsdwspddy, Wcdwspddy, sdwspddy, cdwspddy);

           [Wsstrm,    Wcstrm]    = sumcnt2_work_function(Wsstrm,    Wcstrm,    sstrm,    cstrm);
           [Wsdstrmdx, Wcdstrmdx] = sumcnt2_work_function(Wsdstrmdx, Wcdstrmdx, sdstrmdx, cdstrmdx);
           [Wsdstrmdy, Wcdstrmdy] = sumcnt2_work_function(Wsdstrmdy, Wcdstrmdy, sdstrmdy, cdstrmdy);

           [Wsu,       Wcu]       = sumcnt2_work_function(Wsu,       Wcu,    su,       cu);
           [Wsdudx,    Wcdudx]    = sumcnt2_work_function(Wsdudx,    Wcdudx, sdudx,    cdudx);
           [Wsdudy,    Wcdudy]    = sumcnt2_work_function(Wsdudy,    Wcdudy, sdudy,    cdudy);

           [Wsv,       Wcv]       = sumcnt2_work_function(Wsv,       Wcv,    sv,       cv);
           [Wsdvdx,    Wcdvdx]    = sumcnt2_work_function(Wsdvdx,    Wcdvdx, sdvdx,    cdvdx);
           [Wsdvdy,    Wcdvdy]    = sumcnt2_work_function(Wsdvdy,    Wcdvdy, sdvdy,    cdvdy);

           [Wsustr,    Wcustr]    = sumcnt2_work_function(Wsustr,    Wcustr,    sustr,    custr);
           [Wsdustrdx, Wcdustrdx] = sumcnt2_work_function(Wsdustrdx, Wcdustrdx, sdustrdx, cdustrdx);
           [Wsdustrdy, Wcdustrdy] = sumcnt2_work_function(Wsdustrdy, Wcdustrdy, sdustrdy, cdustrdy);

           [Wsvstr,    Wcvstr]    = sumcnt2_work_function(Wsvstr,    Wcvstr,    svstr,    cvstr);
           [Wsdvstrdx, Wcdvstrdx] = sumcnt2_work_function(Wsdvstrdx, Wcdvstrdx, sdvstrdx, cdvstrdx);
           [Wsdvstrdy, Wcdvstrdy] = sumcnt2_work_function(Wsdvstrdy, Wcdvstrdy, sdvstrdy, cdvstrdy);

           [Wsdiv,     Wcdiv]     = sumcnt2_work_function(Wsdiv,     Wcdiv, sdiv,     cdiv);
           [Wscrl,     Wccrl]     = sumcnt2_work_function(Wscrl,     Wccrl, scrl,     ccrl);
           [Wsdwspdds, Wcdwspdds] = sumcnt2_work_function(Wsdwspdds, Wcdwspdds, sdwspdds, cdwspdds);
           [Wsdwspddn, Wcdwspddn] = sumcnt2_work_function(Wsdwspddn, Wcdwspddn, sdwspddn, cdwspddn);

           [Wsdivstr,  Wcdivstr]  = sumcnt2_work_function(Wsdivstr,  Wcdivstr,  sdivstr,  cdivstr);
           [Wscrlstr,  Wccrlstr]  = sumcnt2_work_function(Wscrlstr,  Wccrlstr,  scrlstr,  ccrlstr);
           [Wsdstrmds, Wcdstrmds] = sumcnt2_work_function(Wsdstrmds, Wcdstrmds, sdstrmds, cdstrmds);
           [Wsdstrmdn, Wcdstrmdn] = sumcnt2_work_function(Wsdstrmdn, Wcdstrmdn, sdstrmdn, cdstrmdn);
       
           % Update the counter for the number of days through the week

           Nw = Nw + 1;

           if Nw == 7 | (mm==7 & yy==1999 & dd==24),

               Wwspd     = avg_work_function(nan_field, Wswspd,    Wcwspd);
               Wdwspddx  = avg_work_function(nan_field, Wsdwspddx, Wcdwspddx);
               Wdwspddy  = avg_work_function(nan_field, Wsdwspddy, Wcdwspddy);

               Wstrm     = avg_work_function(nan_field, Wsstrm,    Wcstrm);
               Wdstrmdx  = avg_work_function(nan_field, Wsdstrmdx, Wcdstrmdx);
               Wdstrmdy  = avg_work_function(nan_field, Wsdstrmdy, Wcdstrmdy);

               Wu        = avg_work_function(nan_field, Wsu,       Wcu);
               Wdudx     = avg_work_function(nan_field, Wsdudx,    Wcdudx);
               Wdudy     = avg_work_function(nan_field, Wsdudy,    Wcdudy);

               Wv        = avg_work_function(nan_field, Wsv,       Wcv);
               Wdvdx     = avg_work_function(nan_field, Wsdvdx,    Wcdvdx);
               Wdvdy     = avg_work_function(nan_field, Wsdvdy,    Wcdvdy);

               Wustr     = avg_work_function(nan_field, Wsustr,    Wcustr);
               Wdustrdx  = avg_work_function(nan_field, Wsdustrdx, Wcdustrdx);
               Wdustrdy  = avg_work_function(nan_field, Wsdustrdy, Wcdustrdy);

               Wvstr     = avg_work_function(nan_field, Wsvstr,    Wcvstr);
               Wdvstrdx  = avg_work_function(nan_field, Wsdvstrdx, Wcdvstrdx);
               Wdvstrdy  = avg_work_function(nan_field, Wsdvstrdy, Wcdvstrdy);

               Wdiv      = avg_work_function(nan_field, Wsdiv,     Wcdiv);
               Wcrl      = avg_work_function(nan_field, Wscrl,     Wccrl);
               Wdwspdds  = avg_work_function(nan_field, Wsdwspdds, Wcdwspdds);
               Wdwspddn  = avg_work_function(nan_field, Wsdwspddn, Wcdwspddn);

               Wdivstr   = avg_work_function(nan_field, Wsdivstr,  Wcdivstr);
               Wcrlstr   = avg_work_function(nan_field, Wscrlstr,  Wccrlstr);
               Wdstrmds  = avg_work_function(nan_field, Wsdstrmds, Wcdstrmds);
               Wdstrmdn  = avg_work_function(nan_field, Wsdstrmdn, Wcdstrmdn);

               % Generate complete weekly output filename

               Woutname = [WEEKLY_AVG_OUTPUT_DIR,BEG_HEAD, ...
                           num2str(jd-3),'.mat'];

               % Save the weekly-averaged file

               fprintf('Woutname=%s\n',Woutname)

               if MATLAB_VERSION > 6,
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
                                'Wcdivstr','Wccrlstr','Wcdstrmds','Wcdstrmdn','-V6')	      

     %                           'Wudwspddx','Wvdwspddx','Wudwspddy','Wvdwspddy', ...
     %                           'Wudstrmdx','Wvdstrmdx','Wudstrmdy','Wvdstrmdy',
               else,
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
               end

               Nw = 0;

               %---------------------------------------------------------------
               % Reset the counter and sum registers for weekly-averaged fields
               %---------------------------------------------------------------

               [Wcwspd,     Wcdwspddx,  Wcdwspddy, ...
                Wcstrm,     Wcdstrmdx,  Wcdstrmdy, ...
                Wcu,        Wcdudx,     Wcdudy, ...
                Wcv,        Wcdvdx,     Wcdvdy, ...
                Wcustr,     Wcdustrdx,  Wcdustrdy, ...
                Wcvstr,     Wcdvstrdx,  Wcdvstrdy, ...
                Wcdiv,      Wccrl,      Wcdwspdds,  Wcdwspddn, ...
                Wcdivstr,   Wccrlstr,   Wcdstrmds,  Wcdstrmdn] = deal(zeros(ny,nx,'uint8'));
               [Wswspd,     Wsdwspddx,  Wsdwspddy, ...
                Wsstrm,     Wsdstrmdx,  Wsdstrmdy, ...
                Wsu,        Wsdudx,     Wsdudy, ...
                Wsv,        Wsdvdx,     Wsdvdy, ...
                Wsustr,     Wsdustrdx,  Wsdustrdy, ...
                Wsvstr,     Wsdvstrdx,  Wsdvstrdy, ...
                Wsdiv,      Wscrl,      Wsdwspdds,  Wsdwspddn, ...
                Wsdivstr,   Wscrlstr,   Wsdstrmds,  Wsdstrmdn] = deal(zeros(ny,nx,'single'));

    %            Wcudwspddx, Wcvdwspddx, Wcudwspddy, Wcvdwspddy, ...
    %            Wcudstrmdx, Wcvdstrmdx, Wcudstrmdy, Wcvdstrmdy, ...
    %Wsudwspddx, Wsvdwspddx, Wsudwspddy, Wsvdwspddy, ...
    %            Wsudstrmdx, Wsvdstrmdx, Wsudstrmdy, Wsvdstrmdy
           end
       end      

    

       [cwspd,   cdwspddx, cdwspddy, ...
        cstrm,   cdstrmdx, cdstrmdy, ...
        cu,      cdudx,    cdudy, ...
        cv,      cdvdx,    cdvdy, ...
        custr,   cdustrdx, cdustrdy, ...
        cvstr,   cdvstrdx, cdvstrdy, ...
        cdiv,    ccrl,     cdwspdds, cdwspddn, ...
        cdivstr, ccrlstr,  cdstrmds, cdstrmdn] = deal(zeros(ny,nx,'uint8'));
       [swspd,   sdwspddx, sdwspddy, ...
        sstrm,   sdstrmdx, sdstrmdy, ...
        su,      sdudx,    sdudy, ...
        sv,      sdvdx,    sdvdy, ...
        sustr,   sdustrdx, sdustrdy, ...
        svstr,   sdvstrdx, sdvstrdy, ...
        sdiv,    scrl,     sdwspdds, sdwspddn, ...
        sdivstr, scrlstr,  sdstrmds, sdstrmdn] = deal(zeros(ny,nx,'single'));

   end
   
end

return

