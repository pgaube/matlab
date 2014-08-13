function zi=bilin_pnt(x,y,nx,ny,xg,yg,var,maxx,maxy);



i=lllocate(xg,nx,x);
j=lllocate(yg,ny,y);

if(i==0 || j==0 || i==nx || j==ny);
    zi=nan;
elseif isnan(var(i,j)) || isnan(var(i,j+1)) || isnan(var(i+1,j)) || isnan(var(i+1,j+1));
    zi=nan;
else
    
    rat=(y-yg(j))./(yg(j+1)-yg(j));
    ylo=var(i  ,j)+rat.*(var(i  ,j+1)-var(i  ,j));
    yhi=var(i+1,j)+rat.*(var(i+1,j+1)-var(i+1,j));
    rat=(x-xg(i))./(xg(i+1)-xg(i));
    zi=ylo+rat.*(yhi-ylo);
    
end
end





function j=lllocate(xx,n,x)

if x<xx(1)
    j=0;
elseif x>xx(n)
    j=n;
else
    for k=1:n-1
        if x>=xx(k) && x<xx(k+1)
            j=k;
        end
    end
end

end


