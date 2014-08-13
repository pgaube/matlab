clear all
close all

set_satfish

cd(MAT_DIR)
!rm -r *.mat

cd(CA1_AUTO_IMAGE_DIR)
!rm -r *.png

cd(CA1_IMAGE_DIR)
!rm -r *.png

cd([IMAGE_DIR,'/ca2_out/'])
!rm -r *.png

cd([IMAGE_DIR,'/ca3_out/'])
!rm -r *.png

cd([IMAGE_DIR,'/ca4_out/'])
!rm -r *.png

cd([IMAGE_DIR,'/ca5_out/'])
!rm -r *.png

cd([IMAGE_DIR,'/ca6_out/'])
!rm -r *.png

cd(HOME_DIR)