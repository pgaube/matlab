%this script breakes larger daily data down and calculates mean and standard deviations for the whos data
%function [bar,sd]=disdaily(data)

function [bar,sd]=disdaily(data)

data1=data(:,:,1:100);
i=find(~isnan(data1));
bar1=mean(data1(i));
sd1=std(data1(i));

clear data1

data1=data(:,:,101:200);
i=find(~isnan(data1));
bar2=mean(data1(i));
sd2=std(data1(i));

clear data1
		
data1=data(:,:,201:length(data(1,1,:)));
i=find(~isnan(data1));
bar3=mean(data1(i));
sd3=std(data1(i));
bar=(bar1+bar2+bar3)/3;
sd=(sd1+sd2+sd3)/3;

clear data1 bar1 bar2 bar3 sd1 sd2 sd3 i
