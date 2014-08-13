
function sf_avhrr_comp3(region,rname)

set(0,'DefaultFigureVisible','on')
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
jdays=jd-2:jd+1;
[y,m,d]=jd2jdate(jdays);
yeardays=julian(m,d,y,y);
[mean_sst,mean_gradt]=deal(single(nan(size(mlat))));
% [nsst,ngradt]=deal(single(zeros(size(mlat))));

for oo=1:length(jdays)
    tmp=dir(['*' rname '_avhrr_*' num2str(y(oo)) num2str(yeardays(oo)) '*']);
    for rr=1:length(tmp)
        sci_sst=nan*mlat;gradt=nan*mlat;
        fname=getfield(tmp,{rr},'name')
        if fname(19:22)<1400 | fname(19:22)>20
            fname
            load([MAT_DIR,num2str(fname)],'sci_sst','gradt')
%             if per>=.05 & length(nav_off)<300
                %         pnsst=nsst;
                %         pngradt=ngradt;
                
                %         nsst(~isnan(sci_sst))=nsst(~isnan(sci_sst))+1;
                %         ngradt(~isnan(gradt))=gradt(~isnan(gradt))+1;
                %         mean_sst=nansum(cat(3,mean_sst.*pnsst,sci_sst),3)./nsst;
                %         mean_gradt=nansum(cat(3,mean_gradt.*pngradt,single(gradt)),3)./ngradt;
                sci_sst=buffnan_neighbor(sci_sst,ones(size(mask)),4);
                mean_sst=nanmax(mean_sst,sci_sst);
%             end
        end
        
    end
end

display('average computed')
tic;
sst=buffnan_neighbor(mean_sst,ones(size(mask)),10);
% gradt=buffnan_neighbor(mean_gradt,ones(size(mask)),10);
toto=toc;
display(['decimation took ',num2str(toto)])
pgood_mask=nan*sst;
pgood_mask(~isnan(sst))=1;
pgood_mask(isnan(sst))=nan;
pgood_mask(sst<ran(1))=nan;
tic;
sst=smoothn(sst,1500).*mask.*pgood_mask;
% gradt=smoothn(gradt,500).*mask.*pgood_mask;
toto2=toc;
display(['smoothing took ',num2str(toto2)])

raw_sst=double(sst);
raw_lat=double(mlat);
raw_lon=double(mlon);
% raw_gradt=double(gradt);

if s(2)<10 & s(3)<10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
elseif s(2)>=10 & s(3)<10
    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
elseif s(2)<10 & s(3)>=10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
else
    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
end

sfplot(sst,mask,ran(1),ran(2)+.5,'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,num2str(2300),'sst')

% new_sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bz_'],pd,num2str(2300),'bz')
cd(HOME_DIR)
return
dx_org=abs(mlat(1,1)-mlat(2,1));

if region=='~/satfish/mask/ca1_mask'
    for nsub=2:6
        load([HOME_DIR,'/mask/ca',num2str(nsub),'_mask'])
        load([HOME_DIR '/' rname '_fishran'],'ran')
        rname=['ca',num2str(nsub)]
        outdir=[IMAGE_DIR,'ca',num2str(nsub),'_out/'];
        dsst=griddata(raw_lon,raw_lat,raw_sst,mlon,mlat,'CUBIC').*mask;;
        
        %test to see if any covarage
        st=find(~isnan(dsst));
        per=length(st)./length(find(~isnan(mask(:))));
        if per>=.1
            dgradt=griddata(raw_lon,raw_lat,raw_gradt,mlon,mlat,'CUBIC').*mask;;
            dgradt(dgradt<fran(1))=nan;
            
            load([HOME_DIR '/' rname '_fishran'],'ran')
            
            sfplot(dsst,mask,ran(1)-1,ran(2)+.5,'fdcolor',[outdir rname '_bdsc_'],pd,tmp_time,'sst')
            new_sfplot(dgradt,mask,fran(1),fran(2),'fdcolor',[outdir rname '_bz_'],pd,tmp_time,'bz')
            clear dsst dgradt
        end
    end
end


end
