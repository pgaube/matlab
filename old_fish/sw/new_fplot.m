function fplot(idata,mask,minc,maxc,pallet,out_head,pd,time,TYPE)
%out_head has the full dir in it

load noaa.pal
load chelle.pal
load fdcolor.pal
load topo topomap1
pjet=jet(256);
pgray=gray(256);

%idata=flipud(idata);
%mask=flipud(mask);

new_mask=nan*idata;
new_mask(~isnan(idata))=1;
switch(pallet)
	case {'fdcolor'}
		nrgb=length(fdcolor(:,1));
	case {'topomap1'}
		nrgb=length(topomap1(:,1));	
	case {'pjet'}
		nrgb=length(pjet(:,1));
	case {'chelle'}
		nrgb=length(chelle(:,1));
	case {'pgray'}
		nrgb=length(pgray(:,1));	
end		
cstep = (nrgb-1)/(maxc-minc);
irgb = max(min(round((idata-minc)*cstep+1),nrgb),1).*mask;
irgb(irgb==256)=255;
%%%
irgb(irgb==1)=256;
%%%
q=ones(256,1);
q(256)=0;     
irgb(isnan(new_mask))=256;



switch(TYPE)
case {'sst'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_' num2str(round(minc*10)) '_'	num2str(round(maxc*10)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
	eval(['ls ' out_head pd '_' time '_' num2str(round(minc*10)) '_'	num2str(round(maxc*10)) '.png']);	

case {'cloud'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_' num2str(round(minc*10)) '_'	num2str(round(maxc*10)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
	eval(['ls ' out_head pd '_' time '_' num2str(round(minc*10)) '_'	num2str(round(maxc*10)) '.png']);	

case {'chl'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_000_100.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
	eval(['ls ' out_head pd '_' time '_000_100.png']);	
end
