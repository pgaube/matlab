function fplot(idata,mask,minc,maxc,pallet,out_head,pd,time,TYPE)
%out_head has the full dir in it

load noaa.pal
load chelle.pal
load fdcolor_80.pal
fdcolor=fdcolor_80;
pjet=jet(256);quit

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
irgb(irgb==nrgb)=nrgb-1;
%%%
irgb(irgb==1)=nrgb;
%%%
q=ones(nrgb,1);
q(nrgb)=0;     
irgb(isnan(new_mask))=nrgb;

%%
%
%%this section appaends nanas to try to fit FD's fucked-up old map
wlmf=flipud(fliplr(irgb));
wlmf(end-4:end,:)=[];
wlmf(:,end-2:end)=[];
wlmf=cat(1,256*ones(5,length(wlmf(1,:))),wlmf);
irgb=cat(2,256*ones(length(wlmf(:,1)),3),wlmf);
%%
%
%%


switch(TYPE)
case {'sst'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_' num2str(round(minc)) '_'	num2str(round(maxc)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
	eval(['ls ' out_head pd '_' time '_' num2str(round(minc)) '_'	num2str(round(maxc)) '.png']);	

case {'cloud'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_' num2str(round(minc)) '_'	num2str(round(maxc)) '.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
	eval(['ls ' out_head pd '_' time '_' num2str(round(minc)) '_'	num2str(round(maxc)) '.png']);	

case {'chl'}
	eval(['imwrite(irgb,' pallet ',' char(39) out_head ...
	pd '_' time '_0_0.png' char(39) ',' ...
	char(39) 'Transparency' char(39) ',q)' ]);	
	
	eval(['ls ' out_head pd '_' time '_0_0.png']);	
end
