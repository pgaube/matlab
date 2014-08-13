close all
fid=fopen('tracks.20130125.T','r')
j1=fscanf(fid,'%f',1)
j2=fscanf(fid,'%f',1)
jump_t=fscanf(fid,'%f',1)
ntime=fscanf(fid,'%f',1)


for m=1:ntime
    n_cyc(m)=fscanf(fid,'%f',1);
end

for m=1:ntime
    n_ant(m)=fscanf(fid,'%f',1);
end

for m=1:ntime
    n_tot(m)=fscanf(fid,'%f',1);
end

a = fscanf(fid,'%e',[1 ntime])
b = fscanf(fid,'%f',[1 ntime])
% for m=1:n_tot
    

%     
%     
%     
%     write(lu_out,*)j1,j2,jump_t,ntime
%  write(lu_out,*)(n_cyc(j),j=1,ntime)
% 	  write(lu_out,*)(n_ant(j),j=1,ntime)
% 	  write(lu_out,*)(n_tot(j),j=1,ntime)
% 	  write(lu_out,*)((life(i,j),i=1,n_tot(j)),j=1,ntime)
% 	  write(lu_out,*)((xd(i,j),i=1,n_tot(j)),j=1,ntime)
% 	  write(lu_out,*)((yd(i,j),i=1,n_tot(j)),j=1,ntime)
% 	  write(lu_out,*)(( L(i,j),i=1,n_tot(j)),j=1,ntime)
% 	  close(lu_out)
% 
% There are ntime steps in the data set. The julian day of step j is j1+(j-1)*jump_t.
% 
% At time step j, there are n_cyc(j) cyclonic and n_ant(j) anticyclonic, for a total of n_tot(j) tracked eddies.
% 
% For the n_tot(j) eddies at time step j, the lifetime of the ith eddy (in weeks) is life(i,j), the
% longitude of the extreme is xd(i,j) and the latitude of the extreme is yd(i,j) and L(i,j) is the scale (real, km). For i=1,...n_cyc(j), the eddy is cyclonic, for i=n_cyc(j)+1,...n_cyc(j)+n_ant(j), the eddy is anticyclonic.
