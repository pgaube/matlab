%compare the eddies from AVISO and Pop
clear all
load rings_cor_orgin_tracks_AVISO x y k id cyc amp track_jday
ax=x;
ay=y;
ak=k;
aid=id;
acyc=cyc;
aamp=amp;
atrack_jday=track_jday;

% load rings_cor_orgin_tracks x y k id cyc amp track_jday
load rings_cor_orgin_TS_tracks x y k id cyc amp track_jday

ii=find(k>3);
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
amp=amp(ii);
track_jday=track_jday(ii);

%stats
[yea,mon,day]=jd2jdate(atrack_jday);
anyear=length(unique(yea));
nyear=length(unique(track_jday))./73;

stat(1,1)=length(unique(aid(acyc==1)))./anyear;
stat(1,2)=length(unique(aid(acyc==-1)))./anyear;
stat(2,1)=length(unique(id(cyc==1)))./nyear;
stat(2,2)=length(unique(id(cyc==-1)))./nyear;
stat


 

