%calculates the CO2-flux based off of the W92 squared dependance of flux on
%windspeed using QuicSCAT squared climatology winds


Area = nan(length(lat),length(lon),length(time));
my=111.11e3*4; %converts degree of latitdue into meters
mx=(111.11e3*cos(lat*pi/180))*5;  %converts degree of logitude into meters


for m = 1:length(lat)
    for n = 1:length(lon)
        for p = 1:length(time)
        
                       
        Area(m,n,p) = mx(m)*my;
        

        
        end
    end
end



clear m n p my mx


