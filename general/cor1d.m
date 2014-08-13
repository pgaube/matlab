%Copyright Peter Gaube 5.15.2007
%must use equal size and dim arrays
%function [cor,Xbar,Ybar,sdX,sdY]=cor1d(data1,data2)


function [cor,Xbar,Ybar,sdX,sdY]=cor1d(data1,data2)

i = find(~isnan(data1) & ~isnan(data2));
data1 = data1(i);
data2 = data2(i);

%assign x variables to data1
Xbar = mean(data1);
sdX = std(data1);
XX=data1-Xbar;

%assign y variables to data2
Ybar = mean(data2);
sdY = std(data2);
YY=data2-Ybar;
    
%Calculate covarance of X and Y
covar = mean(XX.*YY);

%calculate correlation of X and Y
cor = covar./(sdX*sdY);

    

                                            
                                            