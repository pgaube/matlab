%calculates the CO2-flux based off of the H06 squared dependance of flux on
%windspeed


S = nan(length(lat),length(lon),length(time));
K = nan(length(lat),length(lon),length(time));
A = nan(length(lat),length(lon),length(time));
D = nan(length(lat),length(lon),length(time));
F = nan(length(lat),length(lon),length(time));
Fbar = nan(length(lat),length(lon));
mDIM = nan(length(lat),length(lon));

my=111.11e3*4; %converts degree of latitdue into meters
mx=(111.11e3*cos(lat*pi/180))*5;  %converts degree of logitude into meters

%a = -60.2409;  %use for (mol/kg*atm)
%b = 93.4517;
%c = 23.3585;
%d = 0.023517;
%e = -0.023656;
%f = 0.0047036;

a = -58.0931;  %use for (mol/l*atm)
b = 90.5069;
c = 22.2940;
d = 0.027766;
e = -0.025888;
f = 0.0050578;

for m = 1:length(lat)
    for n = 1:length(lon)
        for p = 1:length(time)
        
        S(m,n,p) = 2073.1 - 125.62*(sst(m,n,p)-273.15) + ...
                    3.6276*(((sst(m,n,p)-273.15))^2) - ...
                    0.043219*(((sst(m,n,p)-273.15)^3));  %Schmidt number based on a least squares fit to 
                                                         %temp (C) from Jahne et al 1987b
            
        K(m,n,p) = (1.09*(QuickWind(m,n,p)) - (0.333*((QuickWind_squared(m,n,p)))) + ...
                    (0.078*((QuickWind_cubed(m,n,p)))))*...
                    ((S(m,n,p)/660)^-.5);  %Dependance of flux on windspeed based off of Magillis and Edson et al 2001 (cm/h)
         
        K(m,n,p) = K(m,n,p)*(24*365);  %give velocity in (cm/y)
        
        
        A(m,n,p) = a + (b * (100/sst(m,n,p))) + ...
                    (c * (log(sst(m,n,p)/100))) + ...
                    (sal(m,n,p)*(d + (e * (sst(m,n,p)/100)) + ...
                    ((f * (sst(m,n,p)/100)^2))));   
       
        A(m,n,p) = exp(A(m,n,p));  %%Solubility of CO2 in Sea water based off of Weiss 1974 (mol/l*atm)
                
        D(m,n,p) = (pco2_sw(m,n,p) - pco2_air(m,n,p))*(10^-6); %Delta pCO2 sea-air (atm)
        
        F(m,n,p) = K(m,n,p) * A(m,n,p) * D(m,n,p);  %Flux of CO2 across air-sea interface (mol/y*m2)  
      
        Fbar(m,n) = sum(F(m,n,:),3); 
        
        Area(m,n) = mx(m)*my;
        
        Flux(m,n,p) = F(m,n,p)*44*Area(m,n);
        end
    end
end



i = find(~isnan(Flux(:)));
x=Flux(i);
Flux_total = sum(x(:))