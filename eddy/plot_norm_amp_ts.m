
ai=find(id>=nneg);
ci=find(id<nneg);
unique_aid=unique(id(ai));
unique_cid=unique(id(ci));

aid=id(ai);
cid=id(ci);
aamp=amp(ai);
camp=amp(ci);

for m=1:length(unique_cid)
	ied=find(cid==unique_cid(m));
	nac(ied) = camp(ied)./camp(ied(1));
end

for m=1:length(unique_aid)
	ied=find(aid==unique_aid(m));
	naa(ied) = aamp(ied)./aamp(ied(1));
end


tbins=1:max(k)+1;
tdt=10;

[bar_nampa,num_nampa,max_nampa,min_nampa,std_nampa]=pbin(k(ai),naa,tbins);
[bar_nampc,num_nampc,max_nampc,min_nampc,std_nampc]=pbin(k(ci),nac,tbins);

figure(1)
clf
plot(bar_nampc,'linewidth',2);
hold on
line([0 max(k)+1],[1 1],'color','k')
%plot(bar_nampc+std_nampc,'--')
%plot(bar_nampc-std_nampc,'--')
plot(bar_nampa,'r','linewidth',2);
%plot(bar_nampa+std_nampa,'r--')
%plot(bar_nampa-std_nampa,'r--')
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
axis([1 length(tbins) min(cat(2,[bar_nampa-std_nampa],[bar_nampc-std_nampc])) ...
	max(cat(2,[bar_nampa+std_nampa],[bar_nampc+std_nampc]))])
title({'Mean Normalized Amplitude as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('Duration (Weeks)')
ylabel('Amp Normalized to Amp at t=0')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_nampa+std_nampa],[bar_nampc+std_nampc])) ...
		-(.08*max(cat(2,[bar_nampa+std_nampa],[bar_nampc+std_nampc]))),...
		[num2str(length(unique(id(ai)))),' Anticyclones'],'color','r')
		
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_nampa+std_nampa],[bar_nampc+std_nampc])) ...
		-(.12*max(cat(2,[bar_nampa+std_nampa],[bar_nampc+std_nampc]))),...
		[num2str(length(unique(id(ci)))),' Cyclones'],'color','b')		