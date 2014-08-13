function sfplot(idata,mask,minc,maxc,pallet,out_head,pd,time,TYPE)
%out_head has the full dir in it

load noaa.pal
load chelle.pal
load fdcolor_80.pal
load bwr.pal
fdcolor=fdcolor_80;
pjet=jet(256);
pgray=gray(256);


new_mask=nan*idata;
new_mask(~isnan(idata))=1;
switch(pallet)
	case {'fdcolor'}
		nrgb=length(fdcolor(:,1));
	case {'pjet'}
		nrgb=length(pjet(:,1));
	case {'chelle'}
		nrgb=length(chelle(:,1));
	case {'pgray'}
		nrgb=length(pgray(:,1));	
end		
cstep = (nrgb-1)/(maxc-minc);
irgb = max(min(round((idata-minc)*cstep+1),nrgb),1).*mask;
irgb(irgb==80)=79;
%%%
irgb(irgb==1)=80;
%%%
q=ones(80,1);
q(80)=0;     
irgb(isnan(new_mask))=80;


%irgb(irgb==80)=79;
%%%
%irgb(irgb==1)=80;
%%%
% q=ones(nrgb,1);
% q(nrgb)=0;     
% irgb(isnan(new_mask))=nrgb;
%%
%

irgb=flipud(irgb);


switch(TYPE)
case {'sst'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_' num2str(round(10*minc)) '_'	num2str(round(10*maxc)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
% 	eval(['ls ' out_head pd '_' time '_' num2str(round(10*minc)) '_'	num2str(round(10*maxc)) '.png']);	

case {'bz'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_000_000.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
% 	eval(['ls ' out_head pd '_' time '_000_000.png']);	

case {'cloud'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_' num2str(round(10*minc)) '_'	num2str(round(10*maxc)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
% 	eval(['ls ' out_head pd '_' time '_' num2str(round(10*minc)) '_'	num2str(round(10*maxc)) '.png']);	

case {'chl'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_000_000.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
% 	eval(['ls ' out_head pd '_' time '_000_000.png']);	
end
