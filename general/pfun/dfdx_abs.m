function fx = dfdx_abs(f,space)
% function fx = dfdx(f,space)
%Uses centered differance
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

for m=1:length(f(:,1))
    dx=111.11e3*space;
    fx(m,:) = finitediff(f(m,:),dx);
end


