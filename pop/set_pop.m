%set_pop

curs = {'adv',...
		'pump',...
		'intense',...
        'larry',...
        'rings',...
        'rings2',...
        'rings3'};
    
adv_domain=[30 35 295 340];
pump_domain=[19 25 297 325];
intense_domain=[35 43 289 320];
larry_domain=[25 30 272 302];
rings_domain=[33 45 289 313];
rings2_domain=[33 45 289 330];
rings3_domain=[35 45 289 330];

lt=[4 4 16 16 16];


      %SSH    SSHi   CHL    C   DIAZC  DIATC  SMALLC  DIAZchl DIATchl SMALL
cranges = ...
    [   8      1    .01    .5     .005     .5     .5   .0001    .002   .06
        7      1   .002    .3     .001     .1      .5    .0001    .00001  .003
        20     4    .01    15     .02     2      1   .0001    .002    .01
        10      2    .002   3     .002     .3       .5   .00005   .0001  .002
        50     8    .05    15     .02     2      .1   .0005    .01    .02];
    
    
      %DIAZC      DIATC       SMALLC    mask_crl    mask_bio
cranges3d = ...
    [   .0005     .01       .01         250             200  
        .0005     .008      .01         150             200    
        .0008     .1        .1          200             200
        .0008     .1        .1          200             200];
    
    
    
%     %OLD
%           %SSH    SSHi   CHL    C   DIAZC  DIATC  SMALLC  DIAZchl DIATchl SMALL
% cranges = ...
%     [   8      1    .01    5     .05     2       3   .0001    .002   .06
%         3      .3   .002   1     .03     .3      1   .0002    .0001  .003
%         25     4    .05    15     .1     15      4   .0003    .07    .02
%         6      1    .005   3     .03     1      3    .00007   .0008  .005];
%     
%     

biomdiat=[13 49];
biomsmall=[71 80];
biomdiaz=[1.2 1.5];


vdiat=[1e-7 5e-8 1e-7 6e-8 5e-6];
vsmall=[1e-7 5e-8 1e-7 1e-7 7e-7];
vdiaz=[4e-8 2e-8 3e-8 4e-8 7e-8];

hdiat=[2e-6 2e-7 2e-6 6e-7 2e-6];
hsmall=[2e-6 1e-6 4e-6 2e-6 4e-6];
hdiaz=[4e-8 3e-8 7e-8 4e-8 7e-8];

bdiat=[2e-6 5e-8 2e-6 5e-7 1e-5];
bsmall=[2e-6 1e-6 7e-6 2e-6 3e-5];
bdiaz=[4e-8 6e-9 6e-8 1e-8 1e-7];