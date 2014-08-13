%function [lambda,EOF,amp,percent] = eof(obs)

%eof calculates the EOF of data that does not contain NaN.  
%Peter Gaube November 2nd 2006
%based on Sean Kennans eofsvd.m

function  [l,E,A,per] = eof(obs)

[m,n,p] = size(obs);

%Prepair the data
    

%reshapes the data into a m*n x p matrix
obs = reshape(obs,m*n,p);
size_reshape=size(obs)

%Finds landmask
i_good = find(~isnan(obs(:,1)));
i_bad = find(isnan(obs(:,1)));

%removes landmask form data
obs(i_bad,:)=[];  

%Centers the data
Z = (obs-mean(obs,2)*ones(1,p))./(ones(length(i_good),1)*std(obs));

%creates scater matrix.  in this case the the scater matrix will have the
%diminsions of m*n
S = Z*Z';
size_scat=size(S)



%preform the calculations

%Calculate the eigenvectors and values

[E,L] = eig(S);
size_eof=size(E)

% sort eigenvalues and eigenvectors

[l,index]=sort(diag(L),1,'descend');
E = E(:,index);
L = diag(l);

% calculate amplitudes

A = Z'*E;

% calculate percent variances

per = 100.*l./sum(l);

%places the landmask back onto the eofs
dim = m*n;
eof=nan(dim,length(i_good));
for i = 1:length(i_good)
	e_interm = E(:,i);
	eof(i_good,i) = e_interm;
end
clear E
E=reshape(eof,m,n,length(i_good));


