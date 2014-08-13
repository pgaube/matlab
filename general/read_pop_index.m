function out=read_pop_index(head,jday,var,level)
load ~/matlab/pop/mat/pop_model_domain r c
fname=[head num2str(jday) '.' var];
fid=fopen(fname,'r','ieee-be');
xyi=[index(1) index(2)];
if fid~=-1
    for k=index;
        temp=fread(fid,[992,1280],'float32');
    end
else
    temp=nan(992,1280);
    display(['cant read ',fname])
end
fclose(fid);
out=temp(c,r)';

