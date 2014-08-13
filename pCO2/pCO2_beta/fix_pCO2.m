
    co2_flux=co2_flux.*mask;
    delta_pCO2=delta_pCO2.*mask;
    sal=sal.*mask;
    sst=sst.*mask;
    
    co2_flux=[co2_flux(:,36:72,:) co2_flux(:,1:35,:)];
    delta_pCO2=[delta_pCO2(:,36:72,:) delta_pCO2(:,1:35,:)];
    sal=[sal(:,36:72,:) sal(:,1:35,:)];
    sst=[sst(:,36:72,:) sst(:,1:35,:)];
    mask=[mask(:,36:72,:) mask(:,1:35,:)];
    
    

