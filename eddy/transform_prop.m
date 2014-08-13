function [compa,compc] = comps_4km(EDDY_FILE,var);
%function [compa,compc] = comps(EDDY_FILE,var);
%
%chl_anom_sample       145x145x1026            86286600  single              
%chl_sample            145x145x1026            86286600  single              
%eid_index            1026x1                       8208  double              
%id_index             1026x1                       8208  double              
%k_index              1026x1                       8208  double  
%

OUT_HEAD   = 'TRANS_W_4km_';
OUT_PATH   = '/Volumes/matlab/matlab/global/trans_samp_4km/';

% First load the tracks you want to composite
load(EDDY_FILE);
startjd=2452459;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd);

id=id(f1);
eid=eid(f1);
x=x(f1);
y=y(f1);
amp=amp(f1);
axial_speed=axial_speed(f1);
efold=efold(f1);
radius=radius(f1);
track_jday=track_jday(f1);
prop_speed=prop_speed(f1);
k=k(f1);
b=1;
jdays=[min(track_jday):7:max(track_jday)];


% Create indicies
uid=unique(id);
icuid = find(uid<nneg);
iauid = find(uid>=nneg);
% next we need to loop through each uâid to find max(k)


% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(jdays(1))],var);
eval(['data = ' var ';']);
[M]=length(data(:,1));
Na=single(ones(M,M));
Nc=Na;
compa=single(ones(M,M));
compc=single(ones(M,M));

for m=1:length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(1,m))],var,'*_index');
    eval(['data = ' var ';'])
    
    ii=sames(uid,id_index);
    if any(ii)
        for pp=1:length(ii)
            obs=data(:,:,ii(pp));
            obs(find(isnan(obs)))=0;
            n=~isnan(data(:,:,ii(pp)));
            if id_index(ii(pp))>=nneg;
				compa=(1./(Na+n)).*((compa.*Na)+(obs.*n));                
                Na=Na+n;
                figure(1)
                pcolor(double(compa));shading flat;caxis([-.05 .05]);drawnow
            else
            	compc=(1./(Nc+n)).*((compc.*Nc)+(obs.*n));
                Nc=Nc+n;
                figure(2)
                pcolor(double(compc));shading flat;caxis([-.05 .05]);drawnow
            end    
        end
    end
end
compa(compa==1)=nan;
compc(compc==1)=nan;
compa=double(compa);
compc=double(compc);
fprintf('\n')


