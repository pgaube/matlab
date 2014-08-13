%function [l,E,AMP_a,AMP_b,COR_a,COR_b,per,A,Z,amp,test,sd_data_a,sd_data_b] = eof_comp_time(tSST,sCHL)

%eof calculates the EOF of data.  
%Peter Gaube November 2nd 2006
%based on Sean Kennans eofsvd.m

%function [l,E,AMP_a,AMP_b,COR_a,COR_b,per,A,Z,amp,test] = eof_comp_time(tSST,sCHL)



%Center the data
[z_a,sst_z,Xbar_a,sdX_a,sd_data_a] = center(tSST);    
[z_b,chl_z,Xbar_b,sdX_b,sd_data_b] = center(sCHL);    

%stack data
obs = cat(1,z_a,z_b);
[m,n,p] = size(obs);

%reshapes the data into a m*n x p matrix
obs = reshape(obs,m*n,p);
size_reshape=size(obs)

%Finds landmask
i_good = find(~isnan(obs(:,1)));
i_bad = find(isnan(obs(:,1)));

%removes landmask from data
obs(i_bad,:)=[];  
Z = obs;
size_Z=size(Z)

%creates scater matrix.  in this case the the scater matrix will have the
%diminsions of p*p
S = Z'*Z;
size_S = size(S)



%preform the calculations

%Calculate the eigenvectors and values

[E,L] = eig(S);
size_E=size(E)

% sort eigenvalues and eigenvectors

[l,index]=sort(diag(L),1,'descend');
E = E(:,index);
size_E_sorted=size(E)
L = diag(l);

% calculate EOF Maps

A = Z*E;
std_E = std(E(:));


%calculate the correaltion between the data recreated from the EOFs and the observations

ZZ = sum(Z.^2,2);  %This is the Variance over time
EE = sum(E.^2,2);  %This is the Variance over the EOFs, and not time
rs = (Z*E).^2./(ZZ*EE');  	%Z*E is the Covariance between the EOFS and the obs
							%Bottom is m*n,p and normilize the numerator
test = sum(rs,2);


% calculate percent variances

per = 100.*l./sum(l);

%places the landmask back onto the eofs
dim = m*n;
amp=nan(dim,p);
Rs = nan(dim,p);

for i = 1:p
	a_interm = A(:,i);
	r_interm = rs(:,i);
	Rs(i_good,i) = r_interm;
	amp(i_good,i) = a_interm;
end



%Reshapes the EOF and corealtions on the map projection
AMP=reshape(amp,m,n,p); 
COR=reshape(Rs,m,n,p);

%decompose the composite matrix into the two original observation matrices
[m,n,p] = size(tSST);

EOF_sst = AMP(1:m,:,:)*sd_data_a*std_E;
EOF_chl = AMP(m+1:2*m,:,:)*sd_data_b*std_E;

AMP = E/std_E;



COR_sst = COR(1:m,:,:);
COR_chl = COR(m+1:2*m,:,:);



