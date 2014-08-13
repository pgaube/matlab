clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels


fname1='/private/d1/larrya/0pt1_run14/t.14.'; %with eddy wind
fname2='/private/d1/larrya/0pt1_run33/t.33.'; %without eddy wind
load mat/pop_model_domain lat lon
tem=read_pop(fname1,num2str(vv(1)),'spc_1to20',1);
% read data
tic
n=0;
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist([fname2 flid '.ssh_sm'])
        

        %%crl
        [z_crl]=deal(nan(length(r),length(c),20));

        for k=1:20; 
            u=read_pop(fname1,flid,'uvel_1to20',k);
            v=read_pop(fname1,flid,'vvel_1to20',k);
            z_crl(:,:,k)=dfdx(lat,v,.1)-dfdy(u,.1);
        end
        eval(['save mat/run14_',num2str(nn),' -append z_crl'])
    end
   
end;