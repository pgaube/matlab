%function [lambda,modes,amp,percent] = eof_space(obs)

%alculates the EOF of data that does not contain NaN. 
%Peter Gaube November 2nd 2006
%based on scatter matrix "brute force" meathode described
%by Emery and Thompson, 2004 and found in 
%Preisedorfer, 1988 and others.
%MATLAB code based off of Sean Kennan's eofsvd.m
%Input
%	obs = MxNxK matrix of observations.  Must not contain NaN's!
%		  Adapted to obs matrix of form Latitude x Longitude x Time
%Output
%	lambda = eigen values
%	modes = Spatial maps of the orthodinal modes of statistical varability
%	amp = Time series of the amplitude of each EOF
%	percent = Percent of variance in the original observations accounted for 
%			  by each EOF


function  [l,E,A,per] = eof_space(obs)

[m,n,p] = size(obs);

%Prepair the data
    

%reshapes the data into a m*n x p matrix
%In the case of SST observations, this will create a M x N matrix were the rows
%(M) are SST observations for a given time period.  The columns (N) are then time series of
%of the spatil maps of STT observations 

obs = reshape(obs,m*n,p);
size_reshape=size(obs)

%Finds landmask, even if mask is not the same in each lyer of obs
i_bad = find(isnan(mean(obs,2)));
i_good = find(~isnan(mean(obs,2)));

%removes landmask form data
obs(i_bad,:)=[];  

%Centers the data by removing the mean and nomalizes by the standard deviation
Z = (obs-mean(obs,2)*ones(1,p));
Z = Z./(ones(length(i_good),1)*std(Z));

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

%places the landmask back onto the spatial maps of the statistical modes of variability
dim = m*n;
eof=nan(dim,length(i_good));
for i = 1:length(i_good)
	e_interm = E(:,i);
	eof(i_good,i) = e_interm;
end
clear E
E=reshape(eof,m,n,length(i_good));


