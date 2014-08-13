clear all
load /matlab/data/eddy/V4/global_tracks_v4_12_weeks id track_jday nneg

OUT_HEAD_nomask   = 'TRANS_W_NMK_';
OUT_PATH_nomask   = '/matlab/matlab/global/no_mask_trans_samp/';
OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/old_trans_samp/';
r_comp=41;
c_comp=25:57;
x=-2:.125:2;

% Create indicies
startjd=2451395;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
track_jday=track_jday(f1);
jdays=[min(track_jday):7:max(track_jday)];
lj=length(jdays);
lid=length(id);

% Create matrices to save jdays
[M]=length(c_comp);
tcompa=double(nan(lid,M));
tcompc=tcompa;
tcompa_nomask=tcompa;
tcompc_nomask=tcompa;
zza=1;
zza_n=1;
r=17;


for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],'nrssh_sample','amp_index','id_index');
	for pp=1:length(nrssh_sample(1,1,:))
		cc=nrssh_sample(r_comp,c_comp,pp);
		ho=max(abs(cc))-amp_index(pp);
		if id_index>=nneg
			tcompa(zza,:)=(cc-ho)./amp_index(pp);
		else
			tcompa(zza,:)=(cc+ho)./-amp_index(pp);
		end	
		
		cc=nrssh_sample(c_comp,r_comp,pp);
		ho=max(abs(cc))-amp_index(pp);
		if id_index>=nneg
			tcompc(zza,:)=(cc-ho)./amp_index(pp);
		else
			tcompc(zza,:)=(cc+ho)./-amp_index(pp);
		end	
		%{
		figure(1)
		plot(x,tcompa(zza,:))
		axis([-2 2 -.1 1.5])
		drawnow
		pause(.2)
		%}
		zza=zza+1;
		
	end
	clear nrssh_sample amp_index
	load([OUT_PATH_nomask OUT_HEAD_nomask num2str(jdays(m))],'nrssh_sample','amp_index');
	for pp=1:length(nrssh_sample(1,1,:))
		cc=abs(nrssh_sample(r_comp,c_comp,pp));
		ho=max(cc)-amp_index(pp);
		tcompa_nomask(zza_n,:)=(cc-ho)./amp_index(pp);
		
		cc=abs(nrssh_sample(c_comp,r_comp,pp));
		ho=max(cc)-amp_index(pp);
		tcompc_nomask(zza_n,:)=(cc-ho)./amp_index(pp);
		%{
		figure(2)
		plot(x,tcompa_nomask(zza_n,:))
		axis([-2 2 -.1 1.5])
		drawnow
		pause(.2)
		%}
		zza_n=zza_n+1;
	end
end	

med_z_ssh=nanmedian(tcompa,1);
med_z_ssh_nomask=nanmedian(tcompa_nomask,1);

med_m_ssh=nanmedian(tcompc,1);
med_m_ssh_nomask=nanmedian(tcompc_nomask,1);

for m=1:length(tcompc(1,:))
	mode_z_ssh(m)=mode(tcompa(:,m));
	mode_m_ssh(m)=mode(tcompc(:,m));
	mode_z_ssh_nomask(m)=mode(tcompa_nomask(:,m));
	mode_m_ssh_nomask(m)=mode(tcompc_nomask(:,m));
end	

save ssh_mask_comps *_ssh*
%save ssh_mask_comps