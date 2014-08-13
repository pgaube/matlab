clear all

fname='tracks.ASCII.extrema.20130125'
fid=fopen(fname);



% raw=importdata(fname);
% lf=length(raw(:,1));
% clear raw

lf=215185+1;

clear x y a l u id cyc k age track_jdays
pp=1;
qq=1;

progressbar('loading tracks')
rr=1;

while rr>0
    progressbar(pp/lf)
    bb=fgets(fid);
    if bb ~= -1
        tt=str2num(bb);
        rr=tt(2);
        
        pp=pp+1;
        id(qq:qq+rr-1)=tt(1);
        age(qq:qq+rr-1)=tt(2);
        track_jdays(qq:qq+rr-1)=[tt(3):7:tt(3)+(7*(tt(2)-1))];
        cyc(qq:qq+rr-1)=tt(4);
        k(qq:qq+rr-1)=1:rr;
        
        x(qq:qq+rr-1)=str2num(fgets(fid));
        y(qq:qq+rr-1)=str2num(fgets(fid));
        a(qq:qq+rr-1)=str2num(fgets(fid));
        l(qq:qq+rr-1)=str2num(fgets(fid));
        u(qq:qq+rr-1)=str2num(fgets(fid));
        
        qq=qq+rr;
    else
        rr=-1
    end
end

close all
clear ans fname ii pp qq rr tt lf fid bb 
save tmp
load tmp
ii=find(x>360);
x(ii)=x(ii)-360;
clear ii
ext_x=x;
ext_y=y;
clear x y
save global_tracks_ext_V6