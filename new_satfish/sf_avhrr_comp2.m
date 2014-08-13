
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
jdays=jd:jd;
[y,m,d]=jd2jdate(jdays);
yeardays=julian(m,d,y,y);
mean_sst=single(nan(length(mlat(:,1)),length(mlon(1,:)),length(jdays)));
for oo=1:length(jdays)
    tmp=dir(['*' num2str(y(oo)) num2str(yeardays(oo)) '*']);
    SST=single(nan(length(mlat(:,1)),length(mlon(1,:)),length(tmp)));
    for rr=1:length(tmp)
        rr
        sci_sst=nan*SST(:,:,1);
        load([MAT_DIR,num2str(getfield(tmp,{rr},'name'))],'sci_sst')
%         whos mlat sci_sst
        SST(:,:,rr)=single(sci_sst);
    end
%     mean_sst(:,:,oo)=max(SST,[],3);
    mean_sst(:,:,oo)=nanmean(SST,3);
end
save test mean_sst mlat mlon
sst=smoothn(nanmean(mean_sst,3),200).*mask;
% sst=smoothn(max(mean_sst,[],3),20);
sfplot(sst,mask,ran(1),ran(2),'fdcolor','test','','','sst')
cd(HOME_DIR)
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
