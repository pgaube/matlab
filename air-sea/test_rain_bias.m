clear all
load FINAL_EIO_comps EIO_wek_crlg* EIO_wek_*
zgrid_grid
mask=nan*dist;
mask(dist<=.5)=1;

ac=EIO_wek_a.mean.*mask;
cc=EIO_wek_c.mean.*mask;

% figure(1)
% clf
% subplot(121)
% pcolor(ac);shading flat;caxis([-20 20])
% subplot(122)
% pcolor(cc);shading flat;caxis([-20 20])
% return

rat_scat=max(ac(:))./-min(cc(:))

ac=EIO_wek_crlg_a.mean.*mask;
cc=EIO_wek_crlg_c.mean.*mask;
rat_cur=max(ac(:))./-min(cc(:))