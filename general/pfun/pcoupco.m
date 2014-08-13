function pcoupco(x,y,slope_guess,tbins,step,min_x,max_x,min_y,max_y,xlab,ylab)
%function pcoupco(x,y,slope_guess,tbins,step,min_x,max_x,min_y,max_y,xlab,ylab)

fprintf('\n     removing NaNs\r')
x=x(:);
y=y(:);
ibad=find(isnan(x));
x(ibad)=[];
y(ibad)=[];
ibad=find(isnan(y));
x(ibad)=[];
y(ibad)=[];


fprintf('\n     bin averaging\r')
for i=1:length(tbins)-1
    bin_est = find(x>=tbins(i) & x<tbins(i+1));
    binned_samps1(i) = double(pmean(x(bin_est)));
    std_samps1(i) = double(pstd(x(bin_est)));
    num_samps1(i) = double(length(bin_est));
    binned_samps2(i) = double(pmean(y(bin_est)));
    std_samps2(i) = double(pstd(y(bin_est)));
    num_samps2(i) = length(bin_est);
end

% linear least squared regession on binned data
fprintf('\n     Linear least squares regression \r')
[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(double(x),double(y));
beta_lin=xor*sdy/sdx;
newy_lin=(beta_lin.*[min_x:step:max_x]);

fprintf('\n     Binned least squares regression \r')
[xor,Covar,N,Sig,Xbar,Ybar,sdx,sdy]=pcor(tbins(1:length(tbins)-1),binned_samps2);
beta_lin_binned=xor*sdy/sdx;
newy_lin_binned=(beta_lin_binned.*[min_x:step:max_x]);

fprintf('\n     Neutral least squares regression on samples \n')
[beta_nut_samps(2),beta_nut_samps(1),dud,dud,chiopt,Cab,Calphap]=ols_line(double(x),double(y),slope_guess);
newy_nut_samps=(beta_nut_samps(2).*[min_x:step:max_x])+beta_nut_samps(1);


ci=std_samps2.*tinv((.05)/2,.01*(num_samps2)-1)./sqrt(.01*(num_samps2)-1);
ci=std_samps2;
figure(23)
clf
hold on
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
errorbar(binned_samps1,binned_samps2,ci,'r.')
plot([min_x:step:max_x],newy_lin,'k')
plot([min_x:step:max_x],newy_lin_binned,'k--')

plot([min_x:step:max_x],newy_nut_samps,'g','linewidth',2)
xlabel({xlab,'',[' \beta_{binned} = ',num2str(beta_lin_binned),' \beta_{lin} = ',num2str(beta_lin),' \beta_{ols} = ',num2str(beta_nut_samps(2))]});
ylabel(ylab)
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
shading flat


figure(24)
clf
hold on
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
errorbar(binned_samps1,binned_samps2,ci,'k.')
plot([min_x:step:max_x],newy_lin_binned,'k')

%cc=colorbar;
xlabel({xlab,'', ...
[' \beta_{binned} = ',num2str(beta_lin_binned)]});
ylabel(ylab)
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
shading flat


