%Copyright Peter Gaube 5.15.2007
%must use equal size and dim arrays
%function [cor,Xbar,Ybar,sdX,sdY]=cor2d(data1,data2)

%function [cor,Xbar,Ybar,sdX,sdY,XX,YY]=cor2d(data1,data2)
function [cor,Xbar,Ybar,sdX,sdY,XX,YY]=cor2d(data1,data2)


            %assign x variables to data1
            Xbar = nanmean(data1(:));
            sdX = nanstd(data1(:));
            XX=data1(:)-Xbar;

            %assign y variables to data2
            Ybar = nanmean(data2(:));
            sdY = nanstd(data2(:));
            YY=data2(:)-Ybar;
    
            %Calculate covarance of X and Y
            covar = nanmean(XX.*YY);
            
            %calculate correlation of X and Y
            cor = covar./(sdX*sdY);

    

                                            
                                            