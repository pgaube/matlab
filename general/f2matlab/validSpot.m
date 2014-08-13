function out=validSpot(str,loc)

for i=1:length(loc)
 out(i)=~inastring_f(str,loc(i)) && ~inaDQstring_f(str,loc(i)) && ~incomment(str,loc(i));
end