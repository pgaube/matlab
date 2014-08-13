function dd(varargin)
clear global; clear functions;
global GlobInArgs nargs
GlobInArgs={mfilename,varargin{:}}; nargs=nargin+1;

end %program dd
function [Lun,Kprint,Ipass]=BSPCK(Lun,Kprint,Ipass,varargin);
persistent a aa adif alf as atol b bc BELL bet bquad bv c cc Ccv cv den dn DPI DPIOV2 er fatal fbcl fbcr ff FLAG ftl ftl1 ftl2 i ibcl ibcr id idim_v ierr iknt ileft ilo inbv inc INCMAX inev inppv iwork j jhigh jj k kb kk knt kntopt kontrl ldc ldcc lf LONGNAME ltest lxi mflag n NALF NBET ndata nerr NIDIM NINC NKB NMAX nmk nn Nout NSUBS pi PIOV2 pquad q qq qsave quad snames spv STARS summlv sv t TAB tol trans w x x1 x2 xi xl xs xx y ys yt yy z 

if isempty(atol), atol=0; end;
if isempty(bquad), bquad=0; end;
if isempty(bv), bv=0; end;
if isempty(den), den=0; end;
if isempty(dn), dn=0; end;
if isempty(er), er=0; end;
if isempty(fbcl), fbcl=0; end;
if isempty(fbcr), fbcr=0; end;
if isempty(pquad), pquad=0; end;
if isempty(quad), quad=0; end;
if isempty(spv), spv=0; end;
if isempty(tol), tol=0; end;
if isempty(x1), x1=0; end;
if isempty(x2), x2=0; end;
if isempty(xl), xl=0; end;
if isempty(xx), xx=0; end;
if isempty(i), i=0; end;
if isempty(ibcl), ibcl=0; end;
if isempty(ibcr), ibcr=0; end;
if isempty(id), id=0; end;
if isempty(ierr), ierr=0; end;
if isempty(iknt), iknt=0; end;
if isempty(ileft), ileft=0; end;
if isempty(ilo), ilo=0; end;
if isempty(inbv), inbv=0; end;
if isempty(inev), inev=0; end;
if isempty(inppv), inppv=0; end;
if isempty(iwork), iwork=0; end;
if isempty(j), j=0; end;
if isempty(jhigh), jhigh=0; end;
if isempty(jj), jj=0; end;
if isempty(k), k=0; end;
if isempty(kk), kk=0; end;
if isempty(knt), knt=0; end;
if isempty(kntopt), kntopt=0; end;
if isempty(kontrl), kontrl=0; end;
if isempty(ldc), ldc=0; end;
if isempty(ldcc), ldcc=0; end;
if isempty(lxi), lxi=0; end;
if isempty(mflag), mflag=0; end;
if isempty(n), n=0; end;
if isempty(ndata), ndata=0; end;
if isempty(nerr), nerr=0; end;
if isempty(nmk), nmk=0; end;
if isempty(nn), nn=0; end;
if isempty(fatal), fatal=false; end;
if isempty(summlv), summlv=0; end;
if isempty(NMAX), NMAX=65; end;
if isempty(INCMAX), INCMAX=2 ; end;
if isempty(adif), adif=zeros(+4,+1); end;
if isempty(bc), bc=zeros(1,+1); end;
if isempty(c), c=zeros(4,10); end;
if isempty(cc), cc=zeros(4,4); end;
if isempty(q), q=zeros(1,3); end;
if isempty(qq), qq=zeros(1,77); end;
if isempty(qsave), qsave=zeros(1,2); end;
if isempty(sv), sv=zeros(1,4); end;
if isempty(t), t=zeros(1,17); end;
if isempty(w), w=zeros(1,65); end;
if isempty(x), x=zeros(1,11); end;
if isempty(xi), xi=zeros(1,11); end;
if isempty(cv), cv = 2.9979251; end;
if isempty(y), y =(4.1 ./ 3.0); end;
if isempty(Ccv), Ccv =complex(2.9979251,1.2); end;
if isempty(DPIOV2), DPIOV2=0; end;
if isempty(pi), pi=3.1415927; end;
if isempty(DPI), DPI=3.141592653589793238d0 ; end;
if isempty(PIOV2), PIOV2=pi./2, DPIOV2=DPI./2 ; end;
if isempty(FLAG), FLAG=true; end;
if isempty(LONGNAME), LONGNAME='a STRING OF 25 CHARACTERS' ; end;
if isempty(Nout), Nout=0; end;
if isempty(NIDIM), NIDIM=6; end;
if isempty(NKB), NKB=4; end;
if isempty(NINC), NINC=4; end;
if isempty(NALF), NALF=3; end;
if isempty(NBET), NBET=3 ; end;
global bcom_2; 
global bcom_1; 
if isempty(ftl), ftl=false; end;
if isempty(ftl1), ftl1=false; end;
if isempty(ftl2), ftl2=false; end;
%% common tsterr,same;
%% common bcom_1,bcom_2;
if isempty(trans), trans=repmat(' ',1,1); end;
if isempty(aa), aa=zeros(1,NMAX.*NMAX); end;
if isempty(as), as=zeros(1,NMAX.*NMAX); end;
if isempty(bet), bet=zeros(1,NBET); end;
if isempty(xs), xs=zeros(1,NMAX.*INCMAX); end;
if isempty(ys), ys=zeros(1,NMAX.*INCMAX); end;
if isempty(yt), yt=zeros(1,NMAX); end;
if isempty(yy), yy=zeros(1,NMAX.*INCMAX); end;
if isempty(z), z=zeros(1,2.*NMAX); end;
if isempty(NSUBS), NSUBS=17 ; end;
if isempty(ltest), ltest=zeros(1,NSUBS); end;
if isempty(snames),   snames={'CGEMV ','CGBMV ','CHEMV ','CHBMV ','CHPMV ','CTRMV ','CTBMV ','CTPMV ','CTRSV ','CTBSV ','CTPSV ','CGERC ','CGERU ','CHER  ','CHPR  ','CHER2 ','CHPR2 '};  end;
if isempty(idim_v),   idim_v=[0,1,2,3,5,9];  end;
if isempty(kb),   kb=[0,1,2,4];  end;
if isempty(b), b=zeros(1,10); end;
if isempty(BELL),   BELL=[7];  end;
if isempty(TAB), TAB=[9];  end;
if isempty(lf), lf=[10];  end;
if isempty(ff), ff =[12];  end;
if isempty(a),   a=[0];  end;
if isempty(STARS), STARS =[0,0,0,0,0,0,0,0,0,'****'];  end;
if isempty(inc),   inc=[1,2,-1,-2];  end;
if isempty(alf),  alf=[complex(0.0,0.0),complex(1.0,0.0),complex(0.7,-0.9)];  end;
if( Kprint>=2 )
writef(Lun,['1 QUICK CHECK FOR SPLINE ROUTINES', '\n ' , '\n '  ' \n']); 
end;
%format ('1 QUICK CHECK FOR SPLINE ROUTINES',[,]./];
Ipass = 1;
tol = 1000.0e0.*R1MACH(4);
end %subroutine BSPCK
function [r1machResult,i]=R1MACH(i,varargin);
r1machResult=[];
persistent DIVER LARGE log10mlv RIGHT RMACH SMALL 

if isempty(RMACH), RMACH=zeros(1,5); end;
% equivalence(RMACH(1),SMALL(1)) ::;
% equivalence(RMACH(2),LARGE(1)) ::;
% equivalence(RMACH(3),RIGHT(1)) ::;
% equivalence(RMACH(4),DIVER(1)) ::;
% equivalence(RMACH(5),log10(1)) ::;
try;SMALL(1);catch;   SMALL(1) =[1.18e-38];  end;
try;LARGE(1);catch;   LARGE(1) =[3.40e+38];  end;
try;RIGHT(1);catch;   RIGHT(1) =[0.595e-07];  end;
try;DIVER(1);catch;   DIVER(1) =[1.19e-07];  end;
try;log10mlv(1);catch;   log10mlv(1) =[0.30102999566];  end;
if( i < 1 || i > 5 ) ;
% call XERMSG ('SLATEC', 'R1MACH', 'i OUT OF BOUNDS', 1, 2)
end;
RMACH(1)=SMALL(1);
RMACH(2)=LARGE(1);
RMACH(3)=RIGHT(1);
RMACH(4)=DIVER(1);
RMACH(5)=log10mlv(1);
r1machResult = RMACH(i);
return;
end %function R1MACH




function out=writef(fid,varargin)
% function out=writef(fid,varargin)
%  Catches fortran stdout (6) and reroutes in to Matlab's stdout (1)
%  Catches fortran stderr (0) and reroutes in to Matlab's stderr (2)
if isnumeric(fid)
 if fid==6,      out=fprintf(1,varargin{:});
 elseif fid==0,  out=fprintf(2,varargin{:});
 else,           out=fprintf(fid,varargin{:});
 end
elseif ischar(fid)
 out=sprintf(varargin{:});
 if nargin>2 %set the calling var to out
  if ~isempty(inputname(1)), assignin('caller',inputname(1),out); end
 end
else,            out=fprintf(fid,varargin{:});
end
end


function [argStr,status]=getarg(n,argStr,status)
%replicates getarg in fortran
global GlobInArgs nargs
if n<0 || n>nargs
 argStr=''; status=-1;
else
 argStr=GlobInArgs{n+1};
 status=length(argStr);
end
end