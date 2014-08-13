in_dir = '/Volumes/data/pgaube/data/QuickScat/swath/grid_swath/gridded_day/'
out_dir='/Volumes/matlab/data/QuickScat/new_mat/'
in_head='global_'
out_head='QSCAT_21_25km_'

%Set range of dates



jdays=[2451395:7:2454811];

%make lat lon
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);

[year,month,day]=jd2jdate(jdays);
bad_m=[];
tu=1;
%make matircies

for m=1:length(jdays)
	m
	[t_crl, t_wspd, t_strm, t_crlstr] = deal(nan(560,1440,21));
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   make comp centered on %08u \r',calday(m))
	
	for n=-10:10
		load_file = [in_dir in_head num2str(jdays(m)+n)];
		fprintf([load_file '\r'])
		if exist([load_file '.mat'])
			load(load_file,'Dcrl','Dcrlstr','Dwspd','Dstrm','Du','Dv','Dustr','Dvstr')
			t_ustr(:,:,n+12)=Dustr;
			t_vstr(:,:,n+12)=Dvstr;
			t_u(:,:,n+12)=Du;
			t_v(:,:,n+12)=Dv;
			t_crlstr(:,:,n+12)=Dcrlstr;
			t_crl(:,:,n+12)=Dcrl;
			t_wspd(:,:,n+12)=Dwspd;
			t_strm(:,:,n+12)=Dstrm;
		else
			error('mising file, aborted')
			return
			%{
			t_crlstr(:,:,n+12)=nan*Dcrlstr;
			t_crl(:,:,n+12)=nan*Dcrl;
			t_wspd(:,:,n+12)=nan*Dwspd;
			t_strm(:,:,n+12)=nan*Dstrm;
			fprintf('missing file for jdate %09u \n',num2str(jdays(m)+n))
			bad_m(tu)=jdays(m)+n;
			tu=tu+1;
			%}
		end
			
		if n==10
			crl_21=nanmean(t_crl,3);
			crlstr_21=nanmean(t_crlstr,3);
			wspd_21=nanmean(t_wspd,3);
			strm_21=nanmean(t_strm,3);
			u_21=nanmean(t_u,3);
			v_21=nanmean(t_v,3);
			ustr_21=nanmean(t_ustr,3);
			vstr_21=nanmean(t_vstr,3);
			if exist([out_dir out_head num2str(jdays(m)) '.mat'])
    			eval(['save -append ' out_dir out_head num2str(jdays(m))  ' *21 lat lon'])
    		else
    			eval(['save ' out_dir out_head num2str(jdays(m))  ' *21 lat lon'])
    		end
    
			%figure(21)
			%clf
			%pmap(lon(200:300,200:300),lat(200:300,200:300),1e5*crl_21(200:300,200:300))
			%caxis([-2 2])
		end
	end	
end

