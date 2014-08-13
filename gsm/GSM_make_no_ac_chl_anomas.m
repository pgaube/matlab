%loads SeaWiFS CHL data from the gsm algorithum
clear all
%close all
% jdays=[2450828:7:2454489];

jdays=[2451913:7:2455137];

%Set path and region
save_path = '~/data/gsm/larry_no_eddy_mat/GSM_9_21_';
load_path = '~/data/gsm/mat/GSM_9_21_';
a_path = '~/data/eddy/V5/mat/AVISO_25_W_';

load ~/data/gsm/mat/GSM_9_21_2454181 glat glon
load ~/data/eddy/V5/mat/AVISO_25_W_2454181
[r,c]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
load ~/data/eddy/V5/global_tracks_v5 id track_jday eid cyc

for m=1:length(jdays)
	if exist([load_path num2str(jdays(m)),'.mat'])
		load([load_path num2str(jdays(m))],'gchl_week','glon','glat')
		load([a_path num2str(jdays(m))],'ls_mask_ac','ls_mask_cc')
		if exist('gchl_week')
			m
			clear nocc_chl noac_chl tmp_c bm tmpmask dd nn ii 
			%
			tmpmask=ls_mask_ac;
			bm=ones(size(ls_mask_ac));
			tmp_c=flipud(10.^gchl_week(r,c));
			ii=find(track_jday==jdays(m) & cyc==1);
			for nn=1:length(ii)
				dd=find(abs(tmpmask)==eid(ii(nn)));
				bm(dd)=nan;
			end
			tmp_c=flipud(tmp_c.*bm);
			noac_chl=nan*gchl_week;
			noac_chl(r,c)=tmp_c;
			clear tmp_c bm tmpmask dd nn ii 
			%
			tmpmask=ls_mask_cc;
			bm=ones(size(ls_mask_cc));
			tmp_c=flipud(10.^gchl_week(r,c));
			ii=find(track_jday==jdays(m) & cyc==-1);
			for nn=1:length(ii)
                
				dd=find(abs(tmpmask)==eid(ii(nn)));
				bm(dd)=nan;
			end
			tmp_c=flipud(tmp_c.*bm);
			nocc_chl=nan*gchl_week;
			nocc_chl(r,c)=tmp_c;
			
			%{
			figure(1)
			clf
			pmap(glon,glat,gchl_week,'schl')
			figure(2)
			clf
			pmap(glon,glat,noac_chl,'schl')
			%
			figure(3)
			clf
			pmap(glon,glat,nocc_chl)
			drawnow
			%}
			
% 			  lp=smooth2d_f(noac_chl,6,6);
%             lp=smooth2d_loess(noac_chl,glon(1,:),glat(:,1),6,6,glon(1,:),glat(:,1));
            lp=smooth_larry(noac_chl,glon,glat,6);
            hp66_noac_chl=noac_chl-lp;
			clear lp
			%
% 			  lp=smooth2d_f(nocc_chl,6,6);
%             lp=smooth2d_loess(nocc_chl,glon(1,:),glat(:,1),6,6,glon(1,:),glat(:,1));
			lp=smooth_larry(nocc_chl,glon,glat,6);
            hp66_nocc_chl=nocc_chl-lp;
			
			save([save_path num2str(jdays(m))],'*no*','glon','glat')
			clear gchl_week ls_mask lp
		end	
	end	
end

