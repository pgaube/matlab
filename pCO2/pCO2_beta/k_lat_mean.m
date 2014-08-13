function [K_Q1_lat_bar, K_Q2_lat_bar, K_Q3_lat_bar, K_Q4_lat_bar] = k_lat_mean(k,lat);
%function [K_Q1_lat_bar,K_Q2_lat_bar,K_Q3_lat_bar,K_Q4_lat_bar] = k_lat_mean(k);
%Calculates the latitudinal means of k
warning('off')
K_Q1_bar = nan(560,1440);
K_Q2_bar = nan(560,1440);
K_Q3_bar = nan(560,1440);
K_Q4_bar = nan(560,1440);

K_Q1_lat_bar = nan(560,1);
K_Q2_lat_bar = nan(560,1);
K_Q3_lat_bar = nan(560,1);
K_Q4_lat_bar = nan(560,1);


x_Q4=k(:,:,10:12);
x_Q3=k(:,:,7:9);
x_Q2=k(:,:,4:6);
x_Q1=k(:,:,1:3);

for m = 1:length(k(:,1,1))
    for n = 1:length(k(1,:,1))
        i = find(~isnan(x_Q1(m,n,:)));
        K_Q1_bar(m,n)=mean(x_Q1(m,n,i));
        i = find(~isnan(x_Q2(m,n,:)));
        K_Q2_bar(m,n)=mean(x_Q2(m,n,i));
        i = find(~isnan(x_Q3(m,n,:)));
        K_Q3_bar(m,n)=mean(x_Q3(m,n,i));
        i = find(~isnan(x_Q4(m,n,:)));
        K_Q4_bar(m,n)=mean(x_Q4(m,n,i));
    end
end


for m = 1:length(k(:,1,1))
        j=find(~isnan(K_Q1_bar(m,:)));
        K_Q1_lat_bar(m) = mean(K_Q1_bar(m,j),2);
        j=find(~isnan(K_Q2_bar(m,:)));
        K_Q2_lat_bar(m) = mean(K_Q2_bar(m,j),2);
        j=find(~isnan(K_Q3_bar(m,:)));
        K_Q3_lat_bar(m) = mean(K_Q3_bar(m,j),2);
        j=find(~isnan(K_Q4_bar(m,:)));
        K_Q4_lat_bar(m) = mean(K_Q4_bar(m,j),2);
end

        
%clf
%subplot(221)
%plot(K_Q1_lat_bar,lat)
%ylabel('Latitude(\circ N)')
%title('1^{st}')
%subplot(222)
%plot(K_Q2_lat_bar,lat)
%title('2^{nd}')
%subplot(223)
%plot(K_Q3_lat_bar,lat)
%title('3^{rd}')
%ylabel('Latitude(\circ N)')
%xlabel('k (cm hr^{-1})')
%subplot(224)
%plot(K_Q4_lat_bar,lat)
%xlabel('k (cm hr^{-1})')
%title('4^{th}')
%warning('on')
