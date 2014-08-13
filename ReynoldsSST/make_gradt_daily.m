clear all

%construct date vector
startjd=2452459;
endjd=2455197;
jdays=[startjd:endjd];


%Set path and region
save_path = '/matlab/data/ReynoldsSST/mat/'


for m=172:length(jdays)
    m
    if exist([save_path 'OI_25_D_' num2str(jdays(m)),'.mat'])
    load([save_path 'OI_25_D_' num2str(jdays(m))],'sst_oi','lat','lon');
    dtdx=dfdx(lat,sst_oi,.25);
	dtdy=dfdy(sst_oi,.25);
	gradt=sqrt(dtdx.^2+dtdy.^2);
    
    if exist([save_path 'OI_25_D_' num2str(jdays(m)) '.mat'])
    	eval(['save -append ' save_path 'OI_25_D_' num2str(jdays(m)) ...
	      ' dtdx dtdy gradt']);
	else
	    eval(['save ' save_path 'OI_25_D_' num2str(jdays(m)) ...
	      ' dtdx dtdy gradt']);
	end 
	end
end
