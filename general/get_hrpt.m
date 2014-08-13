
minlon = -130;
maxlon = -120;
minlat = 40;
maxlat = 48;

xvec = [minlon maxlon];
yvec = [minlat maxlat];
tvec = [datenum(2009,12,1) datenum(2009,12,3)];

[sstnight ntlon ntlat nttime] = xtracto_3D_bdap(xvec,yvec,tvec,'TATsstnhday');

[sstday dylon dylat dytime] = xtracto_3D_bdap(xvec,yvec,tvec,'TATsstdhday');
