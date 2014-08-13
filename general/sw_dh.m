function [dh]=sw_dh(S,T,P);
%input 
% S = salinity (PSU)
% T = temp (C)
% P in dbars
%
%output
% dh = dynamic height in (m)

%first get svan
svan=sw_svan(S,T,P);

g=9.81; %ms^2
db2Pascal  = 1e4; %converts dp to pascal
dz=pmean(diff(P)); %the average difference between each pressure level
nz=length(P);


%{
dh(nz)=0;
for k=nz-1:-1:1
    dp=(P(k+1)-P(k))*db2Pascal/g;
    dh(k)=dh(k+1)+0.5*(svan(k+1)+svan(k))*dp;
end


%}
mean_svan=0.5*(svan(2:end)+svan(1:end-1));
top_svan=svan(1).*P(1)*db2Pascal;
delta_svan=mean_svan*dz*db2Pascal;
dh=(-1/g)*cumsum([top_svan; delta_svan]);
dh=dh-(ones(length(P),1)*dh(end)); %makes relative to bottom
%}