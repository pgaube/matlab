function fcrop(filename)


T=imread(filename);
imwrite(T(73:797,259:983,:),[filename])
%make image 1495 1470