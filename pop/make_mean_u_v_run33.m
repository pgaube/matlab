clear all
% select time period
vv=[1740:2139]; %this is the whole encilada
[i,tm]=size(vv); % tm = number of time levels
load mat/run33_1740 lat lon
% read data
tic
n=0;
[u_c,v_c]=deal(zeros(length(lat(:,1)),length(lon(1,:))));
[u_n,v_n]=deal(ones(length(lat(:,1)),length(lon(1,:))));
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    if exist(['mat/run33_',num2str(nn),'.mat'])
        load(['mat/run33_',num2str(nn)],'z_u','z_v')
        u_c=((u_c.*u_n)+z_u(:,:,1))./(u_n+1);
        v_c=((v_c.*v_n)+z_v(:,:,1))./(v_n+1);

        clear z_u z_v
        u_n=u_n+1;
        v_n=v_n+1;
       
    end
end

mean_v=v_c;
mean_u=u_c;

save means_u_v_run33 mean_u mean_v lat lon
spd=sqrt(mean_u.^2+mean_v.^2);


figure(1)
clf
pmap(lon,lat,spd);
[xx,yy]=m_ll2xy(lon,lat);
[verts averts] = streamslice(xx,yy,mean_u,mean_v,3); 
hold on
h=streamline([verts averts]);
set(h,'color','k','linewidth',.5)
