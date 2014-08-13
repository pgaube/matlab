
function sf_avhrr_comp(region,rname)

set(0,'DefaultFigureVisible','off')
close all


set_satfish
load(region)
load([HOME_DIR '/' rname '_fishran'])

maxlat=max(mlat(:));
minlat=min(mlat(:));
maxlon=max(mlon(:));
minlon=min(mlon(:));

cd(MAT_DIR)

%which days?
jdays=jd-1:jd;
[y,m,d]=jd2jdate(jdays);
yeardays=julian(m,d,y,y);
tmp=dir(['*' num2str(y(1)) num2str(yeardays(1)) '*']);
for oo=2:length(m)
    tmp=cat(1,tmp,dir(['*' num2str(y(oo)) num2str(yeardays(oo)) '*']));
end

SST=nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp));
for m=1:3%:length(tmp)
    psst=nan*SST(:,:,1);
    load([MAT_DIR,num2str(getfield(tmp,{m},'name'))],'psst')
    SST(:,:,m)=psst;
end
SST=nanmean(SST,3);
% SST=nan(size(mlat));
% n=0;
% for m=1:3%:length(tmp)
%     psst=nan*SST;
%     load([MAT_DIR,num2str(getfield(tmp,{m},'name'))],'psst')
%     tmp_sst=cat(3,n*SST,psst);
%     tmp_sst(tmp_sst==0)=nan;
%     rr=nansum(tmp_sst,3);
%     rr(rr==0)=nan;
%     SST=rr./(n+1);
%     n=n+1
% end

new_sfplot(SST,mask,ran(1),ran(2),'fdcolor','test','','','sst')
save test SST mlat mlon
return
psst=SST;
tic;
pgood_mask=nan*psst;
pgood_mask(~isnan(psst))=1;
pgood_mask(isnan(sst))=nan;
sm_sst=smoothn(sst,15).*pgood_mask;
dx=mlat(2,1)-mlat(1,1)
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;
toto=toc;
display(['smoothong took ',num2str(toto)])

new_sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bz_'],pd,tmp_time,'bz')

%         if region=='~/satfish/mask/ca1_mask'
%             for nsub=2:6
%                 load([HOME_DIR,'/mask/ca',num2str(nsub),'_mask'])
%                 load([HOME_DIR '/' rname '_fishran'],'ran')
%                 rname=['ca',num2str(nsub)]
%                 outdir=[IMAGE_DIR,'ca',num2str(nsub),'_out/'];
%                 dsst=griddata(raw_lon,raw_lat,raw_psst,mlon,mlat,'CUBIC').*mask;;
%
%                 %test to see if any covarage
%                 st=find(~isnan(dsst));
%                 per=length(st)./length(find(~isnan(mask(:))));
%                 if per>=.1
%                     dgradt=griddata(raw_lon,raw_lat,raw_gradt,mlon,mlat,'CUBIC').*mask;;
%                     dgradt(dgradt<fran(1))=nan;
%
%                     load([HOME_DIR '/' rname '_fishran'],'ran')
%
%                     sfplot(dsst,mask,ran(1)-2,ran(2)+2,'fdcolor',[outdir rname '_bdsc_'],pd,tmp_time,'sst')
%                     new_sfplot(dgradt,mask,fran(1),fran(2),'fdcolor',[outdir rname '_bz_'],pd,tmp_time,'bz')
%                     clear dsst dgradt
%                 end
%                 %                 end
%             end
%         end
cd(HOME_DIR)
end
