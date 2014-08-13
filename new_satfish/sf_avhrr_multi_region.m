
function sf_avhrr_multi_region(regions,rnames)
%Input
%regions = a cell array of paths to mask files
% example: {'~/satfish/mask/ca1_mask','~/satfish/mask/wa1_mask'}
%rnames = header for image files, also a cell array
% example: {'ca1','wa1'}


set(0,'DefaultFigureVisible','off')
close all

for ireg=1:length(regions)
    set_satfish
    
    region=regions{ireg};
    rname=rnames{ireg};
    
    
    load(region)
    load([HOME_DIR '/' rname '_fishran'])
     
    maxlat=max(mlat(:));
    minlat=min(mlat(:));
    maxlon=max(mlon(:));
    minlon=min(mlon(:));
    
    cd(AVHRR_SF_DIR)
    
    %now loop through each hdf file and plot
    if region=='~/satfish/mask/ca1_mask'
        tmp=dir('*fd*hdf');
        fran=1e-6*[1 400];
    elseif region=='~/satfish/mask/wa1_mask'
        tmp=dir('*wa*hdf');
    elseif region=='~/satfish/mask/ne1_mask'
        tmp=dir('*ne*hdf');
    end
    
    if length(tmp)>0
        
        for m=1:length(tmp)
            load(region)
            if region=='~/satfish/mask/ca1_mask'
                rname='ca1'
            end
            fname=num2str(getfield(tmp,{m},'name'))
            eval(['!cp ' fname ' tmp_out.hdf'])
            eval(['!rm ' fname])
            lon=double(hdfread('tmp_out.hdf','/longitude'));
            lat=double(hdfread('tmp_out.hdf','/latitude'));
            sst=0.01*double(hdfread('tmp_out.hdf','/sst'));
            sst=(sst*(9/5))+32;
            cloud=double(hdfread('tmp_out.hdf','/cloud'));
            %zenith=double(hdfread('tmp_out.hdf','/sat_zenith'));
            
            cmask=nan*cloud;
            cmask(cloud==0)=1;
            [r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
            
            sst=sst(r,c);
            full_sst=sst;
            cmask=cmask(r,c);
            cloud=cloud(r,c);
            lon=lon(r,c);
            lat=lat(r,c);
            zt=find(sst<-10);
            sst(sst<0)=nan;
            sst(sst<34)=nan;
            sst(sst>90)=nan;
            
            %sst=fillnans(sst.*cmask);
            sci_sst=sst.*cmask;
            cmask2=cmask;
            cmask(cloud==123)=1;
            cmask(cloud==4)=1;
            cmask(cloud==16)=1;
            cmask(cloud==18)=1;
            cmask(cloud==22)=1;
            cmask(cloud==2)=1;
            cmask(cloud==6)=1;
            cmask(cloud==38)=1;
            cmask(cloud==70)=1;
            cmask(cloud==98)=1;
            cmask(cloud==114)=1;
            cmask(cloud==66)=1;
            cmask(cloud==34)=1;
            cmask(cloud==102)=1;
            cmask(cloud==32)=1;
            cmask(cloud==50)=1;
            cmask(cloud==31)=1;
            cmask(cloud==23)=1;
            cmask(cloud==66)=1;
            
            
            
            
            %         cmask2(cloud==123)=1;
            %         cmask2(cloud==4)=1;
            cmask2(cloud==16)=1;
            cmask2(cloud==18)=1;
            cmask2(cloud==22)=1;
            cmask2(cloud==23)=1;
            %         cmask2(cloud==2)=1;
            %         cmask2(cloud==6)=1;
            %         cmask2(cloud==38)=1;
            
            sst=sst.*cmask;
            sst2=sst.*cmask2;
            display(['file ',fname,' has been masked'])
            
            %remove cloud adjacent point
            pmask=nan*full_sst;
            pmask((full_sst)>ran(1))=1; %%%this will remove all data less than ran(1). Note that this is differen that how i did it before
            %         pmask((full_sst)>min(ran)-2)=1;
            psst=sst.*pmask;
            psst(~isnan(sst))=sst(~isnan(sst));
            tic;
            if region=='~/satfish/mask/ca1_mask'
                psst=buffnan_rad_fast(psst,avhrr_mask(r,c),8);
%                 sci_sst=buffnan_neighbor(sci_sst,avhrr_mask(r,c),2);
            elseif region=='~/satfish/mask/wa1_mask'
                psst=buffnan_rad_fast(psst,avhrr_mask(r,c),5);
%                 sci_sst=buffnan_neighbor(sci_sst,avhrr_mask(r,c),2);
            elseif region=='~/satfish/mask/ne1_mask'
                psst=buffnan_rad_fast(psst,avhrr_mask(r,c),5);
%                 sci_sst=buffnan_neighbor(sci_sst,avhrr_mask(r,c),2);
            end
            
            toto=toc;
            display(['decimation took ',num2str(toto)])
                        
            tic;
            pgood_mask=nan*psst;
            pgood_mask(~isnan(psst))=1;
            pgood_mask(isnan(psst))=nan;
            sm_sst=smoothn(psst,5).*pgood_mask;
            sm_sst(sm_sst<ran(1))=nan;
            gr_mask=nan*sm_sst;
            gr_mask(~isnan(sm_sst))=1;
            gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2).*gr_mask;
            gradt(gradt>(2.5*fran(2)))=nan;
            gradt(sm_sst<ran(1))=nan; %set to 66 in sping and 68 in summer
            gradt=buffnan_neighbor(gradt,avhrr_mask(r,c),4);
            toto=toc;
            display(['smoothong took ',num2str(toto)])
            
            tic;
            raw_psst=psst;
            raw_sst=sst;
            raw_lat=lat;
            raw_lon=lon;
            raw_gradt=gradt;
            
            psst=griddata(lon,lat,psst,mlon,mlat,'linear');
            sst2=griddata(lon,lat,sst2,mlon,mlat,'linear');
            sci_sst=griddata(lon,lat,sst,mlon,mlat,'linear');
            gradt=griddata(lon,lat,gradt,mlon,mlat,'linear');
            
            sst2=sst2.*mask;
            psst=psst.*mask;
            gradt=gradt.*mask;
            sci_sst=sci_sst.*mask;
            
            toto=toc;
            display(['interp took ',num2str(toto)])
            %make file name date string
            [s(2),s(3),s(1)]=jul2date(str2num(fname(6:8)),str2num(fname(1:4)));
            d=julian(s(2),s(3),s(1),s(1));
            
            %figure out time of pass in local time ftzone
            UTC
            hh=str2num(fname(10:13))+(100*UTC);
            
            
            if hh>2400
                test=1
                hh=hh-2400;
                if s(2)<10 & s(3)<10
                    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
                elseif s(2)>=10 & s(3)<10
                    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
                elseif s(2)<10 & s(3)>=10
                    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
                else
                    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
                end
            elseif hh<0
                test=2
                hh=2400+hh;
                [s(2),s(3),s(1)]=jul2date(str2num(fname(6:8))-1,str2num(fname(1:4)));
                if s(2)<10 & s(3)<10
                    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
                elseif s(2)>=10 & s(3)<10
                    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
                elseif s(2)<10 & s(3)>=10
                    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
                else
                    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
                end
            else
                test=3
                if s(2)<10 & s(3)<10
                    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
                elseif s(2)>=10 & s(3)<10
                    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
                elseif s(2)<10 & s(3)>=10
                    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
                else
                    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
                end
            end
            tmp_time=num2str(hh)
            if length(tmp_time)<4
                tmp_time=['0',tmp_time];
            end
            tmp_time
            %test to see if any covarage
            st=find(~isnan(psst) & psst>ran(1));
            per=length(st)./length(find(~isnan(mask(:))));
            
            %test to see if NAV is off
            nav_off=find(psst>=max(ran)+10);
            
            ti=prctile(psst(:),[1 99]);
            tmran=round(10*ti)./10;
            tmran=ran+1.5;
            
            
            %%%%
            %adjust ran for afternoon heating
            %%%%
            if str2num(tmp_time)>1000 & str2num(tmp_time)<2000 & s(2)>6 & s(2)<10
                ran(2)=ran(2)+2;
            end
            sfplot(sst2,mask,ran(1),ran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
            sfplot(psst,mask,ran(1),ran(2)+2,'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
            sfplot(psst,mask,ran(1),ran(2)+1,'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
            %         sfplot(psst,mask,ran(1)-1,ran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
            sfplot(psst,mask,ran(1)-1,ran(2)-1,'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
            sfplot(sci_sst,mask,ran(1),ran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
            new_sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CA1_IMAGE_DIR rname '_bz_'],pd,tmp_time,'bz')
            
            if per>=.05 %& length(nav_off)<300 %& length(zt)<100
                if region=='~/satfish/mask/ca1_mask'
%                     test_hi=length(find(psst(~isnan(psst))>ran(2)))./length(find(~isnan(psst)));
%                     while test_hi>0.1
%                         ran(2)=ran(2)+.5;
%                         test_hi=length(find(psst(~isnan(psst))>ran(2)))./length(find(~isnan(psst)));
%                     end
                    sfplot(psst,mask,ran(1),ran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
                    new_sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_bz_'],pd,tmp_time,'bz')
                elseif region=='~/satfish/mask/wa1_mask'
                    sfplot(psst,mask,ran(1),ran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
                    new_sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_bz_'],pd,tmp_time,'bz')
                elseif region=='~/satfish/mask/ne1_mask'
                    sfplot(psst,mask,ran(1),ran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_bdsc_'],pd,tmp_time,'sst')
                    new_sfplot(gradt,mask,fran(1),fran(2),'fdcolor',[CA1_AUTO_IMAGE_DIR rname '_bz_'],pd,tmp_time,'bz')
                end
            end
            save([MAT_DIR,rname,'_avhrr_',num2str(s(1)) num2str(d) '_' tmp_time],'per','gradt','psst','sci_sst','sst2','sm_sst','nav_off')

            dx_org=abs(mlat(1,1)-mlat(2,1));
            
            if region=='~/satfish/mask/ca1_mask'
                for nsub=2:6
                    load([HOME_DIR,'/mask/ca',num2str(nsub),'_mask'])
                    load([HOME_DIR '/' rname '_fishran'],'ran')
                    rname=['ca',num2str(nsub)]
                    outdir=[IMAGE_DIR,'ca',num2str(nsub),'_out/'];
                    dsst=griddata(raw_lon,raw_lat,raw_psst,mlon,mlat,'CUBIC').*mask;;
                    dsci_sst=griddata(raw_lon,raw_lat,raw_sst,mlon,mlat,'CUBIC').*mask;;
                    
                    %test to see if any covarage
                    st=find(~isnan(dsst));
                    per=length(st)./length(find(~isnan(mask(:))));
                    if per>=.1
                        dgradt=griddata(raw_lon,raw_lat,raw_gradt,mlon,mlat,'CUBIC').*mask;;
                        dgradt(dgradt<fran(1))=nan;
                        
                        load([HOME_DIR '/' rname '_fishran'],'ran')
                        if str2num(tmp_time)>1000 & str2num(tmp_time)<2000 & s(2)>6 & s(2)<10
                            ran(2)=ran(2)+2;
                        end
                        sfplot(dsci_sst,mask,ran(1)-2,ran(2)+1.1,'fdcolor',[outdir rname '_bdsc_'],pd,tmp_time,'sst')
                        %                     sfplot(dsst,mask,ran(1)-2,ran(2)+1,'fdcolor',[outdir rname '_bdsc_'],pd,tmp_time,'sst')
                        new_sfplot(dgradt,mask,fran(1),fran(2),'fdcolor',[outdir rname '_bz_'],pd,tmp_time,'bz')
                        clear dsst dgradt
                    end
                end
            end
        end
    end
    cd(HOME_DIR)
    
end

% !rm *fd*hdf
% !rm *wa*hdf
cd(HOME_DIR)
