step= 0.5;    %spacing between data 
                    %point used to create 
                    %latitude and 
                    %longitude vectors
                    %in order to subset
                    %data                   
loN=[step:step:360-step];
laT=[90-step/2:-step:-90+step/2];
c=find(laT>=-10 & laT<=10); 
r=find(loN>=0 & loN<=110);
lon=loN(r); 
lat=laT(c); %subset lat and lon to selected 