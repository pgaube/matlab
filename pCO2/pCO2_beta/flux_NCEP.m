%calculates the CO2-flux based off of the H06 squared dependance of flux on
%windspeed


S = nan(length(lat),length(lon),length(time));
H06 = nan(length(lat),length(lon),length(time));
W92 = nan(length(lat),length(lon),length(time));
WM99 = nan(length(lat),length(lon),length(time));
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
        
        S(m,n,p) = 2073.1 - 125.62*(sst(m,n,p)) + ...
                    3.6276*((sst(m,n,p))^2) - ...
                    0.043219*((sst(m,n,p)^3));  %Schmidt number based on a least squares fit to 
                                                         %temp (C) from Jahne et al 1987b
            
        A(m,n,p) = exp(a + (b * (100/(sst(m,n,p)+273.15))) + ...  %Solubility of CO2 in Sea water based off of Weiss 1974 (mol/l*atm)
                    (c * (log((sst(m,n,p)+273.15)/100))) + ...
                    (sal(m,n,p)*(d + (e * ((sst(m,n,p)+273.15)/100)) + ...
                    ((f * ((sst(m,n,p)+273.15)/100)^2)))));   
                
        D(m,n,p) = delta_pco2(m,n,p)*(10^-6); %Delta pCO2 sea-air (atm)
        
        
        K_H06(m,n,p) = (0.266*(ncep_wind_spd(m,n,p)^2)*((S(m,n,p)/660)^-.5))*(24*365.25); %Dependance of flux on windspeed 
                                                                            %based off of Ho et al 2006(cm/y)
         
        %K_WM99(m,n,p) = ((1.09*(QuickWind(m,n,p)) - (0.333*((ncep_wind_spd(m,n,p)^2))) + ...
        %            (0.078*((QuickWind_cubed(m,n,p)))))*...
        %           ((S(m,n,p)/660)^-.5))*(24*365.25);  %Dependance of flux on windspeed based off of Wannikoff and MagGillis 1999 (dm/y)
         
        
        K_W92(m,n,p) = (0.39*ncep_wind_spd(m,n,p)^2*((S(m,n,p)/660)^-.5))*(24*365.25); % Dependance of flux on windspeed 
                                                                            %based off of Wannikoff 1992(cm/y) 
       
        F_W92(m,n,p) = K_W92(m,n,p) * A(m,n,p) * D(m,n,p);
         
        %F_WM99(m,n,p) = K_WM99(m,n,p) * A(m,n,p) * D(m,n,p);
        
        F_H06(m,n,p) = K_H06(m,n,p) * A(m,n,p) * D(m,n,p);  %Flux of CO2 across air-sea interface (mol/y*m2)  
      
        Fbar_W92(m,n) = sum(F_W92(m,n,:),3); 

        %Fbar_WM99(m,n) = sum(F_WM99(m,n,:),3); 
                        
        Fbar_H06(m,n) = sum(F_H06(m,n,:),3); 
        
        Area(m,n) = mx(m)*my;
        
        Flux_H06(m,n,p) = F_H06(m,n,p)*(12.011*Area(m,n));
        
        Flux_W92(m,n,p) = F_W92(m,n,p)*(12.011*Area(m,n));
        
        %Flux_WM99(m,n,p) = F_WM99(m,n,p)*(12.011*Area(m,n));%flux in gC/month
        
        Flux_taka(m,n,p) = co2_flux(m,n,p)*(12.011*Area(m,n)); %flux in gC/month using Takahashi et al results
        
        x(m,n,p) = ((S(m,n,p)/660)^-.5);
        end
    end
end


Fbar_taka=sum(co2_flux,3);
i = find(~isnan(Flux_H06(:)));
xW92=Flux_W92(i);
%xWM99=Flux_WM99(i);
xH06=Flux_H06(i);
xtaka=Flux_taka(i);
Flux_total_H06 = sum(xH06(:))/10^15
Flux_total_W92 = sum(xW92(:))/10^15
%Flux_total_WM99 = sum(xWM99(:))/10^15 %flux in pgC/y
Flux_total_taka = sum(xtaka(:)) /10^15%flux in pgC/y from Takahasi et al resutls



