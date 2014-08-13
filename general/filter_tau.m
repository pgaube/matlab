load_path = '/Volumes/matlab/data/QuickScat/gridded_mstr_week/'
load([load_path,'QSCAT_W_25km_2454454'],'lat','lon')
mid_week_jdays=2452459:7:2454489;
[lon,lat]=meshgrid(lon,lat);



beta=single(nan(length(lat(:,1)),length(lat(1,:)),5));
subset_lt_tau=single(nan(length(lat(:,1)),length(lat(1,:)),1:4:length(mid_week_jdays)));
S=single(nan(length(lat(:,1)),length(lat(1,:))));
NumCov=S;


ppp=1;
    for m=1:4:length(mid_week_jdays)
        fname = [load_path 'QSCAT_M_25km_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname, 'Mstrm')
        subset_lt_tau(:,:,ppp)=single(Mstrm);
        ppp=ppp+1;
    end
    plac=1;
    nump=length(lat(:,1)).*length(lat(1,:));
    for rr=1:length(lat(:,1))
        for cc=1:length(lon(1,:))
            fprintf('\r     Regressing Point %07u of %07u \r',plac,nump)
            plac=plac+1;
            [ny,beta(rr,cc,:),S(rr,cc),theta] = ...
                    harm_reg(mid_week_jdays(1:4:length(mid_week_jdays)),...
                             squeeze(subset_lt_tau(rr,cc,:)),...
                             2,...
                             2*pi/365.25);
            NumCov(rr,cc) = single(length(find(~isnan(squeeze(subset_lt_tau(rr,cc,:))))));
        end
    end  
    
    %{
    rands = cat(1,abs(round(randn(10,1)*100)),abs(round(randn(10,1)*1000)))
    for n = 1:length(rands)
    	plot(mid_week_jdays,squeeze(subset_lt_tau(rands(n),rands(n),:))));
    	hold on
    	plot(mid_week_jdays,squeeze((rands(n),rands(n),:))));
    %}
    
    fprintf('\n')
    save([load_path,'filtered_harm_tau_stuff'],'beta','S','NumCov','lat','lon',...
         'r*','c*','load_path','mid_week_jdays','subset_lt_tau')





%
% now that we have all the betas lets load each data file,
% again,
% and remove the seasonal cycle and append the anomoly and
% day of seasonal cycle to each file
%

f=2*pi/365.25;



for m=1:4:length(mid_week_jdays)
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname2 = [load_path 'QSCAT_M_25km_' num2str(mid_week_jdays(m)) '.mat']
    load(fname2,'Mstrm')
    SS = (beta(:,:,1)...
          +beta(:,:,2)*cos(f*mid_week_jdays(m))...
          +beta(:,:,4)*sin(f*mid_week_jdays(m))...
          +beta(:,:,3)*cos(2*f*mid_week_jdays(m))...
          +beta(:,:,5)*sin(2*f*mid_week_jdays(m)));
    Mstrm_anom = Mstrm-SS;
    eval(['save ', fname2, ' -append SS Mstrm_anom']);
end

