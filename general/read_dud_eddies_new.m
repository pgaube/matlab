
path='/Volumes/Data/eddies/dudley_data_march_13/';

trk_file='tracks_8pix_00amp_6wks.090206';
sts_file='amprad_8pix_00amp_max.090206';

file_name='combin_6wks.080523_noclose';

fid_trk=fopen([path,trk_file]);
fid_sts=fopen([path,sts_file]);


imiss=32767;
n_32bit_rec=1250./2;
nvar=3;
convert_julydays_datenum=1721059;
README='lon (1, deg); lat (2, deg); e (3,id number); amp (4,cm); reff (5,km); refol (6,km); time (7, days)'



% this reads the header
a_junk=fread(fid_sts,n_32bit_rec,'int32');
b_junk=fread(fid_sts,n_32bit_rec,'float32');

a=fread(fid_trk,n_32bit_rec,'int32');
b=fread(fid_trk,n_32bit_rec,'float32');
ncyclo=a(2);
nanti=a(1)-a(2);

%subsect the data for the region of interest

max_lat=60;
min_lat=45;

max_lon=-125;
min_lon=-160;

min_year=2003;

%now skipp to the record that you are not readding

% if irec > 1 
%     junk=fread(fid,(n_32bit_rec*(irec-1)),'int32');
% end

%clear junk

data_cyclo=cell(1);
data_anti=cell(1);
data_anti2=[];
data_cyclo2=[];

%now read the cyclonic records
ipos=1;

for irec=1:ncyclo
start_rec=fread(fid_trk,2,'int32');    
points=fread(fid_trk,(n_32bit_rec-2)*2,'int16');

points_sts=fread(fid_sts,(n_32bit_rec)*2,'int16');

ngood=floor(length(points)./nvar);
npoints=start_rec(1);
start_date=start_rec(2)-convert_julydays_datenum;
time=start_date+[0:npoints-1]*7;
[y,m,d]=datevec(double(time));

%put data in form of an matrix and add missing
rr=reshape(points(1:ngood*nvar),nvar,ngood);
rr=rr(:,1:npoints);
rr(find(rr == imiss))=NaN;


rr_sts=reshape(points_sts(1:ngood*nvar),nvar,ngood);
rr_sts=rr_sts(:,1:npoints);
rr_sts(find(rr_sts == imiss))=NaN;

rr=[rr;rr_sts];

%recalobate data in to real untis

data=ones(npoints,nvar*2+1)*NaN;
data2=ones(npoints,nvar*2+2)*NaN;
data(:,1:nvar*2)=rr';
data(:,end)=time;
data(:,1:2)=data(:,1:2)./100;
data(:,4)=data(:,4)./10;
data(:,1)=data(:,1)-360;

% convert lon to -180 to 180
large_lon=find(data(:,1) >180);
data(large_lon,1)=data(large_lon,1)-360;

data2(:,1:nvar*2+1)=data;
data=single(data);

%now put in to a big array

if length(find(data(:,1)<max_lon &data(:,1) >min_lon & data(:,2) <max_lat & data(:,2)>min_lat &y'>=min_year)) >=1
    data_cyclo{ipos}=data;
    data2(:,nvar*2+2)=ipos;
    data_cyclo2=[data_cyclo2;data2];
    ipos=ipos+1;
end
clear data data2
end


%read anticycolic eddies
ipos=1;
for irec=1:nanti
start_rec=fread(fid_trk,2,'int32');    
points=fread(fid_trk,(n_32bit_rec-2)*2,'int16');

points_sts=fread(fid_sts,(n_32bit_rec)*2,'int16');


ngood=floor(length(points)./nvar);
npoints=start_rec(1);
start_date=start_rec(2)-convert_julydays_datenum;
time=start_date+[0:npoints-1]*7;
[y,m,d]=datevec(double(time));

%put data in form of an matrix and add missing
rr=reshape(points(1:ngood*nvar),nvar,ngood);
rr=rr(:,1:npoints);
rr(find(rr == imiss))=NaN;


rr_sts=reshape(points_sts(1:ngood*nvar),nvar,ngood);
rr_sts=rr_sts(:,1:npoints);
rr_sts(find(rr_sts == imiss))=NaN;

rr=[rr;rr_sts];

%recalobate data in to real untis

data=ones(npoints,nvar*2+1)*NaN;
data2=ones(npoints,nvar*2+2)*NaN;
data(:,1:nvar*2)=rr';
data(:,end)=time;
data(:,1:2)=data(:,1:2)./100;
data(:,1)=data(:,1)-360;
data(:,4)=data(:,4)./10;

% convert lon to -180 to 180
large_lon=find(data(:,1) >180);
data(large_lon,1)=data(large_lon,1)-360;

data2(:,1:nvar*2+1)=data;
data=single(data);

%now put in to a big array

if length(find(data(:,1)<max_lon &data(:,1) >min_lon & data(:,2) <max_lat & data(:,2)>min_lat &y'>=min_year)) >=1
    data_anti{ipos}=data;
    data2(:,nvar*2+2)=ipos;
    data_anti2=[data_anti2;data2];
    ipos=ipos+1;
end
clear data data2
end

fclose(fid_trk)
fclose(fid_sts)


eval(['save ',path,trk_file,'_john.mat data_anti data_cyclo data_anti2 data_cyclo2 README']);
