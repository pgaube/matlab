function fx = dfdx(lat,f,space)
% function fx = dfdx(lat,f,space)
%Uses centered differance
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

for m=1:length(lat(:,1))
    if length(space)>1
        dx=111.11e3*cosd(lat(m,1)).*space(m,1);
    else
        dx=111.11e3*cosd(lat(m,1)).*space;
    end
    
    fx(m,:) = finitediff(f(m,:),dx);
end




