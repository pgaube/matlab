clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels


fname1='/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.'; %without eddy wind
load mat/pop_model_domain
tem=read_pop(fname1,num2str(vv(1)),'ssh',1);
% read data
tic
n=0;
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist([fname1 flid '.ssh'])
        

        %%crl
        [z_crl]=deal(nan(length(r),length(c),20));

        for k=1:20; 
            t(:,:,k)=read_pop(fname1,flid,'temp_1to20',k);
            s(:,:,k)=read_pop(fname1,flid,'salt_1to20',k);
        end
        
        eval(['save mat/run33_',num2str(nn),' -append t'])
    end
   
end;