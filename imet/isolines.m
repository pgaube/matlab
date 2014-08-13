%creates a series of lines that represent isotherms in the IMET temperature
%chain data

%numisotherms = round(min(temp_7d(:))):round(max(temp_7d(:)));
numisotherms = 8:18;
tmp = nan(1,length(imet_jday));
isotherms = nan(length(numisotherms),length(imet_jday));
endjd = max(imet_jday);

for j = 1:length(numisotherms)
    i = numisotherms(j)
    [cs,h]=contour(imet_jday,-g_depth,g_temp_1d,[i i],'k');
    q = find(cs(1,2:length(cs(1,:)))==endjd);
    if q>0
        x = cs(1,2:q(1));
        y = cs(2,2:q(1));
    else
        x = cs(1,2:length(cs(1,:)));
        y = cs(2,2:length(cs(2,:)));
    end
    for p = 1:length(imet_jday)
        m = imet_jday(p);
        n = find(x==m);
        if length(n)>1
            %if y(n(1)) > y(n(2))
            tmp(1,p) = mean(y(n));
            %else
            %tmp(1,p) = y(n(1));
            %end
        elseif n>0
            tmp(1,p) = y(n);
        end
    end
    isotherms(j,:) = tmp;
end

clear x y p m n tmp j h i cs q endjd