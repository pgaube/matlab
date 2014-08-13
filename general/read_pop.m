function out=read_pop(head,jday,var,level)
load ~/matlab/pop/mat/pop_model_domain r c
fname=[head num2str(jday) '.' var];
fid=fopen(fname,'r','ieee-be');
if fid~=-1
    for k=1:level;
        temp=fread(fid,[992,1280],'float32');
    end
else
    temp=nan(992,1280);
    display(['cant read ',fname])
end
fclose(fid);
out=temp(c,r)';

