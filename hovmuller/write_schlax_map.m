load /matlab/data/gsm/mat/GSM_9_21_2451976 bp26_chl glon glat
tt=flipud(bp26_chl)';
tt(isnan(tt))=1e35; 
s=1440;
save -ascii for_mike/filtered_chl_2451976.dat s
s=720;
save -append -ascii for_mike/filtered_chl_2451976.dat s
save -append -ascii for_mike/filtered_chl_2451976.dat tt
!gzip -f for_mike/filtered_chl_2451976.dat