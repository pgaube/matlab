function niceplot(ftsize,c)
%NICEPLOT  Create a plot with big, bold lettering - presentation/thesis quality
%
%   NICEPLOT makes the title,x/y labels and user supplied text big 
%   and bold using the default color white, the x/y ticklabels big
%   and bold, thickens the axis border, and turns the ticks out on 
%   the current plot.
%
%   NICEPLOT(C) is the same as above except changes the title, x/y 
%   labels and any user supplied text to the color C.
%
%   NICEPLOT(C,F) same as above, but with user specified fontsize F.
%   F by default is 14 point.
%

%   Mike Cook - NPS Oceanography Dept.,  MAR 94
%   Modified by Mike Cook, APR 94 to make any user supplied text
%   big and bold also.
%   Mike Cook, AUG 95, modified to allow user supplied fontsize.
%   Mike Cook, OCT 95, default font size changed from 18 to 14 point.
%   Mike Cook, OCT 95, bug fix. Complained with nice'ing a pcolor'ed
%   plot.  Changed line if tx == 'text' to if strcmp(tx,'text'). This
%   fixed the problem.


%     if nargin < 3
%         lnw=1.4;
%     end

    if nargin < 2
            c = 'k';
%         lnw=1.4;
    end
    if nargin < 1
            ftsize = 14;
    end

    if ~ischar(c)
        error(' The input color must be a string ')
    end

%		Get all children of the current axis.
	chldren = get(gca,'Children');
	[row,~] = size(chldren);

    set(get(gca,'Title'),'Color',c,'FontName','Helvetica', ...
        'FontSize',ftsize,'FontWeight','bold')
    set(get(gca,'Xlabel'),'Color',c,'FontName','Helvetica', ...
        'FontSize',ftsize,'FontWeight','bold')
    set(get(gca,'Ylabel'),'Color',c,'FontName','Helvetica', ...
        'FontSize',ftsize,'FontWeight','bold')
	set(gca,'FontName','Helvetica','FontSize',ftsize,'FontWeight', ...
	    'bold','LineWidth',1.6,'TickDir','out','TickLength',[.012 .033])
    
%     	set(gca,'FontName','Helvetica','FontSize',ftsize,'FontWeight', ...
% 	    'bold','LineWidth',1,'TickDir','out') %this is original


    
%	Check for any "text" type children
%	and make them all big and bold helvetica text.	    
if row > 0
	    for i = 1:row
	       tx = get(chldren(i),'Type');
	       if strcmp(tx,'text')  
%                if tx == 'text' %This is bad if tx = 'patch', tx is 1x5 and 'text' is 1x4.
		       set(chldren(i),'Color',c,'FontName','Helvetica', ...
		          'FontSize',ftsize)
           end
        end
end
box on
end

