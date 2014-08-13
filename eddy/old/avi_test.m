aviobj=avifile('test.avi'); %creates AVI file, test.avi 
hf= figure('visible','off'); %turns visibility of figure off 
hax=axes; 
 
for k=1:10
  image(k.*peaks,'parent',hax); %puts image in invisible axes 
  set(gca,'Zlim',[-20 20]);  
  aviobj=addframe(aviobj,hf); %adds frames to the AVI file 
end  
 
aviobj=close(aviobj); %closes the AVI file  
close(hf); %closes the handle to invisible figure 