load GS_rings_tracks_run14_sla aviso_eddies

prctile(aviso_eddies.k,90)
ii=find(aviso_eddies.k>=15);
uid=unique(aviso_eddies.id(ii));
length(uid)

% for m=1:length(uid)
%     clf
%     ii=find(aviso_eddies.id==uid(m));
%     if aviso_eddies.x(ii(2))>aviso_eddies.x(ii(1))
%         
%         if aviso_eddies.cyc(ii(1))==1
%             plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r')
%         else
%             plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b')
%         end
%         hold on
%         plot(aviso_eddies.x(ii(1)),aviso_eddies.y(ii(1)),'k*')
%         title(num2str(uid(m)))
%         pause(2)
%     end
% end


%%only cyclones
for m=1:length(uid)
    clf
    ii=find(aviso_eddies.id==uid(m));
    if aviso_eddies.x(ii(2))>aviso_eddies.x(ii(1)) & aviso_eddies.cyc(ii)==-1
        
        if aviso_eddies.cyc(ii(1))==1
            plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r')
        else
            plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b')
        end
        hold on
        plot(aviso_eddies.x(ii(1)),aviso_eddies.y(ii(1)),'k*')
        title(num2str(uid(m)))
        pause(2)
    end
end


uid=[1507 144 1475];

for m=1:length(uid)
    clf
    ii=find(aviso_eddies.id==uid(m));
    if aviso_eddies.x(ii(2))>aviso_eddies.x(ii(1))
        
        if aviso_eddies.cyc(ii(1))==1
            plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r')
        else
            plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b')
        end
        hold on
        plot(aviso_eddies.x(ii(1)),aviso_eddies.y(ii(1)),'k*')
        title(num2str(uid(m)))
        pause(2)
    end
end