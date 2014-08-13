function bilin(x,y,nx,ny,xg,yg,var,maxx,maxy)

c given the grid of values in var(i,j), i=1,...,nx; j=1,...ny
c with locations xg(i), i=1,...,nx and yg(j), j=1,...ny (both assumed to be in increasing order)
c returns the linear interpolant at (x,y).

	  integer nx,ny,maxx,maxy
	  real bilin,x,y,xg(maxx),yg(maxy),var(maxx,maxy)
	  parameter(amiss=1.e+35)

c find which cell (x,y) is in
	  
	  call lllocate(xg,nx,x,i)
	  call lllocate(yg,ny,y,j)
c if out of range, set to missing, and return
	  
	  if(i.eq.0 .or. j.eq.0 .or. i.eq.nx .or. j.eq.ny)then
	     bilin=amiss
		 return
      endif
	  
	  if(var(i,j).ge.amiss .or. var(i,j+1).ge.amiss .or. var(i+1,j).ge.amiss .or. var(i+1,j+1).ge.amiss)then
	     bilin=amiss
		 return
      endif
	  
c get the y-interpolants


      rat=(y-yg(j))/(yg(j+1)-yg(j))
	  ylo=var(i  ,j)+rat*(var(i  ,j+1)-var(i  ,j))
	  yhi=var(i+1,j)+rat*(var(i+1,j+1)-var(i+1,j))

c get the x-interpolants

      rat=(x-xg(i))/(xg(i+1)-xg(i))
	  bilin=ylo+rat*(yhi-ylo)
	  
	  return
	  end
		    
			
	  
      SUBROUTINE lllocate(xx,n,x,j)
      INTEGER j,n
      REAL x,xx(n)
      INTEGER jl,jm,ju
      jl=0
      ju=n+1
10    if(ju-jl.gt.1)then
        jm=(ju+jl)/2
        if((xx(n).gt.xx(1)).eqv.(x.gt.xx(jm)))then
          jl=jm
        else
          ju=jm
        endif
      goto 10
      endif
      j=jl
      return
      END