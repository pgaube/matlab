function new_data=buffnan_neighbor(data,land,n_pass)

[ny,nx]=size(data);

for p=1:n_pass
    display(['pass ',num2str(p),' of ',num2str(n_pass)])
    new_data=data;
    for m=2:ny-1
        for n=2:nx-1
            if isnan(data(m,n)) & ~isnan(land(m,n)) 
                new_data(m-1,n+1)=nan;
                new_data(m-1,n)=nan;
                new_data(m-1,n-1)=nan;
                new_data(m,n-1)=nan;
                new_data(m,n+1)=nan;
                new_data(m+1,n+1)=nan;
                new_data(m+1,n)=nan;
                new_data(m+1,n-1)=nan;
            end
        end
    end
    data=new_data;
end

