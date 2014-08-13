clear all
Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '~/data/QuickScat/new_mat/';

jdays=2448910:7:2455581;

for m=1:length(jdays)
    q_file   = [Q_PATH Q_HEAD  num2str(jdays(m)) '.mat'];
    if exist(q_file)
        load(q_file,'hp_wek_crlg_week')
        if exist('hp_wek_crlg_week')
            m
            g=hp_wek_crlg_week;
            a=4/3; %in degree  deg=(a/4)*3 so if a=1/3, deg=1
            w= round(sum(-a + (a+a).*rand(3,20000)));
            y=nan*g;
            sd=pstd(g);
            if w(1)>0 & w(2)>0
                y(w(1):end,w(2):end)=g(1:end-w(1)+1,1:end-w(2)+1);
            elseif w(1)>0 & w(2)<0
                y(w(1):end,1:end+w(2))=g(1:end-w(1)+1,-w(2)+1:end);
            elseif w(1)<0 & w(2)<0
                y(1:end+w(1),1:end+w(2))=g(-w(1)+1:end,-w(2)+1:end);
            elseif w(1)<0 & w(2)>0
                y(1:end+w(1),w(2):end)=g(-w(1)+1:end,1:end-w(2)+1);
            elseif w(1)==0 & w(2)>0
                y(1:end,w(2):end)=g(1:end,1:end-w(2)+1);
            elseif w(1)==0 & w(2)<0
                y(1:end,1:end+w(2))=g(1:end,-w(2)+1:end);
            elseif w(1)<0 & w(2)==0
                y(1:end+w(1),1:end)=g(-w(1)+1:end,1:end);
            elseif w(1)>0 & w(2)==0
                y(w(1):end,1:end)=g(1:end-w(1)+1,1:end);
            else
                y=g;
            end
            sim_wek=y;
            
%             figure(1)
%             clf
%             subplot(121)
%             pcolor(lon(r,c),lat(r,c),double(off_crlg(r,c)));shading flat
%             title('offset-crlg')
%             ran=caxis;
%             axis image
%             subplot(122)
%             pcolor(lon(r,c),lat(r,c),double(g(r,c)));shading flat
%             title('crlg')
%             caxis(ran)
%             axis image
%             drawnow

            eval(['save -append ' q_file ' sim_wek'])
            clear hp_wek_crlg_week g sim_wek y
        end
    end
end