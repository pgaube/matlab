
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


load_path = '/Volumes/matlab/data/SeaWiFS/mat/'
load([load_path,'SCHL_9_21_2450821'],'glon','glat')

data=single(nan(length(glat(:,1)),length(glat(1,:)),length(interp_jdays)));
data2=data;
%grad_data=data;
%mgrad_data=data;


for m=1:length(interp_jdays)
    fname = [load_path 'SCHL_9_21_' num2str(interp_jdays(m)) '.mat'];
    fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
	eval(['load ' fname ' gchl_week'])
	%data(:,:,m)=gchl_week;
	%grad_data(:,:,m)=sqrt(dfdx(glon,data(:,:,m),.25).^2+dfdy(data(:,:,m),.25).^2).*1e5;
	data(:,:,m)=-dfdy(gchl_week,.25).*1e5;
	data2(:,:,m)=dfdx(glon,gchl_week,.25).*1e5;
end

median_dfdy_schl=nanmedian(data,3);
median_dfdx_schl=nanmedian(data2,3);
%{
beta=single(nan(length(glat(:,1)),length(glat(1,:)),3));
for m=1:length(data(:,1,1))
	for n=1:length(data(1,:,1))
		[ny,beta(m,n,:),S(m,n)] = harm_reg(interp_jdays,squeeze(data(m,n,:)),1,2*pi/365.25);
	end
end

grad_beta=single(nan(length(glat(:,1)),length(glat(1,:)),3));
for m=1:length(data(:,1,1))
	for n=1:length(data(1,:,1))
		[ny,grad_beta(m,n,:),grad_S(m,n)] = harm_reg(interp_jdays,squeeze(grad_data(m,n,:)),1,2*pi/365.25);
	end
end

mgrad_beta=single(nan(length(glat(:,1)),length(glat(1,:)),3));
for m=1:length(data(:,1,1))
	for n=1:length(data(1,:,1))
		[ny,mgrad_beta(m,n,:),mgrad_S(m,n)] = harm_reg(interp_jdays,squeeze(mgrad_data(m,n,:)),1,2*pi/365.25);
	end
end

amp_beta=sqrt((beta(:,:,2).^2)+(beta(:,:,3).^2));
amp_grad_beta=sqrt((grad_beta(:,:,2).^2)+(grad_beta(:,:,3).^2));
amp_mgrad_beta=sqrt((mgrad_beta(:,:,2).^2)+(mgrad_beta(:,:,3).^2));


median_schl=nanmedian(data,3);
median_grad_schl=nanmedian(grad_data,3);
median_mgrad_schl=nanmedian(mgrad_data,3);

std_mgrad=nan(size(gchl_week));
for m=1:length(data(:,1,1))
	for n=1:length(data(1,:,1))
		std_mgrad(m,n) = pstd(data(m,n,:));
	end
end
%}
save -append new_mean_schl median*
