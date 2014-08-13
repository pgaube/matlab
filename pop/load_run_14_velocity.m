
%%%%%%%
%%%%%file name
HEAD='/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.';

%%%%%%%%%%
% select time period
vv=[1740:2139]; %this is the whole encilada
[i,tm]=size(vv); % tm = number of time levels

% read data
n=0;
load ~/data/gsm/cor_chl_ssh_out.mat lon lat
glon=lon;
glat=lat;
load ~/matlab/pop/mat/pop_model_domain.mat
[rg,cg]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
glat=glat(rg,cg);
glon=glon(rg,cg);

for nn=vv; % time
    n=n+1;
    flid=num2str(nn);
    if exist([HEAD flid '.ssh'])
        n
        %%crl
        [z_u,z_v]=deal(nan(length(r),length(c),20));

        for k=1:20; 
            z_u(:,:,k)=read_pop(HEAD,flid,'uvel_1to20',k);
            z_v(:,:,k)=read_pop(HEAD,flid,'vvel_1to20',k);
        end
        
        
        eval(['save -append mat/run14_',num2str(nn),' z_u z_v'])
        
    end
end
