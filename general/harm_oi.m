clear all
global M
global N

N=4
M=4


load_path = '/Volumes/matlab/data/ReynoldsSST/mat/'
load([load_path,'OI_25_W_2452459.mat']);

split_domain
rs=1:length(r1);
cs=1:length(c1);



beta=single(nan(length(lat(:,1)),length(lon(1,:)),5));
var_sst=beta(:,:,1);
var_harm_sst=var_sst;
mean_sst=var_sst;
mean_harm_sst=var_sst;

subset_sst=single(nan(length(rs),length(cs),length(mid_week_jdays)));
subset_harm=subset_sst;
S=single(nan(length(lat(:,1)),length(lon(1,:))));
NumCov=S;



for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(mid_week_jdays)
        fname = [load_path 'OI_25_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname,'sst_oi');
        subset_sst(rs,cs,m)=single(sst_oi(r,c));
        %subset_hp(rs,cs,m)=single(filtered_sst_oi(r,c));
    end
    nump=length(rs)*length(cs);
    plac=1;
    %var_sst(r,c)=nanvar(subset_sst,1,3);
    %var_hp_sst(r,c)=nanvar(subset_hp,1,3);
    %mean_sst(r,c)=nanmean(subset_sst,3);
    %mean_hp_sst(r,c)=nanmean(subset_hp,3);
    
    for mm=1:length(rs)
        for nn=1:length(cs)
            rr=r(mm);
            rrs=rs(mm);
            cc=c(nn);
            ccs=cs(nn);
            fprintf('\r     Regressing Point %07u of %07u \r',plac,nump)
            plac=plac+1;
            %var_sst(rr,cc)=pvar(squeeze(subset_sst(rrs,ccs,:)));
            %var_hp_sst(rr,cc)=pvar(squeeze(subset_hp(rrs,ccs,:)));
            %mean_sst(rr,cc)=pmean(squeeze(subset_sst(rrs,ccs,:)));
            %mean_hp_sst(rr,cc)=pmean(squeeze(subset_hp(rrs,ccs,:)));
            [ny,beta(rr,cc,:),S(rr,cc),theta] = ...
                    harm_reg(mid_week_jdays,...
                             squeeze(subset_sst(rrs,ccs,:)),...
                             2,...
                             2*pi/365.25);
            NumCov(rr,cc) = single(length(find(~isnan(squeeze(subset_sst(rrs,ccs,:))))));
        end
    end  
    
    
    %{
    rands = cat(1,abs(round(randn(10,1)*100)),abs(round(randn(10,1)*1000)))
    for n = 1:length(rands)
    	plot(mid_week_jdays,squeeze(subset_lt_chl(rands(n),rands(n),:))));
    	hold on
    	plot(mid_week_jdays,squeeze((rands(n),rands(n),:))));
    %}
    
    fprintf('\n')
    save([load_path,'filtered_oi_stuff'],'beta','S','NumCov','lat','lon',...
         'r*','c*','load_path','mid_week_jdays','subset_sst')
    subset_sst=single(nan(length(rs),length(cs), ...
                      length(mid_week_jdays)));

end




%
% now that we have all the betas lets load each data file,
% again,
% and remove the seasonal cycle and append the anomoly and
% day of seasonal cycle to each file
%

f=2*pi/365.25;



for m=1:length(mid_week_jdays)
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname = [load_path 'OI_25_W_' num2str(mid_week_jdays(m)) '.mat'];
    load(fname,'sst_oi')
    SS = (beta(:,:,1)...
          +beta(:,:,2)*cos(f*mid_week_jdays(m))...
          +beta(:,:,4)*sin(f*mid_week_jdays(m))...
          +beta(:,:,3)*cos(2*f*mid_week_jdays(m))...
          +beta(:,:,5)*sin(2*f*mid_week_jdays(m)));
    sst_oi_anom = sst_oi-SS;
    eval(['save -append ', fname, ' SS sst_oi_anom']);
end

