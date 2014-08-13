function fx = dfdx_m(f,space)
% function fx = dfdx(f,space)
%Uses centered differance
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

for m=1:length(f(:,1))
    fx(m,:) = finitediff(f(m,:),space);
end


