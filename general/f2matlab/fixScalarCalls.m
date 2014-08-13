%%%%%%%%%%%%%%%%% One last sweep to fix: %%%%%%%%%%%%%%%%%%%%%%%%%%%
allLocalVar{1}=localVar;
% fix the problem of passing a scalar in Fortran and then the dummy arg is assumed size
rets=findstr(r,filestr);
rets=[0 rets];
funstr=strread(filestr,'%s','delimiter',r);  
[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr); 

temp7={fun_name{:},funwords{:}};

%'rrrrrrrrrrr',kb

rets=0;
for ii=1:length(allLocalVar)
 % only need to check if this function has a * on any of its inputs
 temp10=0;
 for jj=1:size(allLocalVar{ii},1)
  if ~isempty(allLocalVar{ii}{jj,13}) %is an input var
   if ~isempty(allLocalVar{ii}{jj,5}) && any(strcmp(strtrim(allLocalVar{ii}{jj,5}),'*'))
    temp10=1; break
   end % if any(strcmp(strtrim(allLocalVar{ii}{jj,
  end % if ~isempty(allLocalVar{ii}{jj,
 end % for jj=1:size(allLocalVar{ii},
 if temp10
  rets=rets+1;
  temp5=find(~cellfun('isempty',regexp(funstr,['\<',fun_name{ii},'\>']))).';
  if ~isempty(temp5)
   for i=temp5
    % which function are we in? it may be a local variable
    for jj=i:-1:1
     if ~isempty(funstrwords{jj}) && ...
          ~inastring_f(funstr{jj},funstrwords_b{jj}(1))&&...
          ~incomment(funstr{jj},funstrwords_b{jj}(1))
      if strcmp(funstrwords{jj}{1},'function')
       temp6=find(funstr{jj}=='=');
       if ~isempty(temp6)
        temp8=funstrwords{jj}{find(funstrwords_b{jj}>temp6(1),1,'first')};
        temp9=find(strcmp(temp8,fun_name));
        if ~isempty(temp9)
         break
        end % if ~isempty(temp9)
       else
        %no output arguments on this function
        temp8=funstrwords{jj}{2};
        temp9=find(strcmp(temp8,fun_name));
        if ~isempty(temp9)
         break
        end % if ~isempty(temp9)
       end % if ~isempty(temp6)
      end % if strcmp(funstrwords{i}{1},
     end
    end % for jj=i:-1:1

%%%   'ddddddddd',funstr{i},
%%%   disp(['   fun_name{temp9} = ',num2str(   fun_name{temp9})]);
%%%   disp(['   fun_name{ii} = ',num2str(   fun_name{ii})]);
%%%   kb
    if isempty(find(strcmp(fun_name{ii},{allLocalVar{temp9}{:,1}})))
     while true
      temp=find(strcmp(funstrwords{i},fun_name{ii}));
      goonimag=1;

      for j=length(temp):-1:1
       [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
       if howmany>0
        %go through input args, seeing if the they are scalar refs to a matrix, 
        % then if args in that subroutine are assumed shape
        centercomma=[parens(1),centercomma,parens(2)];
        for fid=1:howmany
         temp3=find(funstrwords_b{i}>centercomma(fid) & funstrwords_b{i}<centercomma(fid+1));
         if ~isempty(temp3)
          %'ssssssssss',funstrwords{i}{temp3(1)},funstr{i},kb
          % See what function we are in and make sure this is a variable
          %hmmmm or just disallow funwords and fun_names?
          if ~any(strcmp(temp7,funstrwords{i}{temp3(1)}))
           [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,temp3(1),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
           if howmany2>0
            %this has to be the only thing passed, no other words or nums outside this var
            if isempty(find(funstrwords_b{i}>centercomma(fid)&...
                            funstrwords_b{i}<funstrwords_b{i}(temp3(1))))...
                 && ...
                 isempty(find(funstrnumbers_b{i}>centercomma(fid)&...
                              funstrnumbers_b{i}<funstrwords_b{i}(temp3(1))))...
                 &&...
                 isempty(find(funstrwords_b{i}<centercomma(fid+1)&...
                              funstrwords_b{i}>parens2(2)))...
                 && ...
                 isempty(find(funstrnumbers_b{i}<centercomma(fid+1)&...
                              funstrnumbers_b{i}>parens2(2)))
             if isempty(find(funstr{i}(parens2(1)+1:parens2(2)-1)==':'))
              % is this an assumed shape on the way in?
              for goon=1:size(allLocalVar{ii},1)
               if ~isempty(allLocalVar{ii}{goon,13})
                if allLocalVar{ii}{goon,13}==fid
                 if ~isempty(allLocalVar{ii}{goon,5})
                  if any(strcmp(strtrim(allLocalVar{ii}{goon,5}),'*'))
                   %'xxxxxxxxxxxxxx1',funstr{i},kb
                   %let's go for it
                   if length(subscripts)==1
                    tempstr=[funstrwords{i}{temp3(1)},'(sub2ind(size(',funstrwords{i}{temp3(1)},...
                             '),max(',funstr{i}(parens2(1)+1:parens2(2)-1),',1)):end)'];
                   else
                    tempstr=[funstrwords{i}{temp3(1)},'(sub2ind(size(',funstrwords{i}{temp3(1)},...
                             '),',funstr{i}(parens2(1)+1:parens2(2)-1),'):end)'];

                   end
                  else
                   %we have a single index coming into a vector or matrx, adjust
                   % the call to be :end on all dims
                   tempstr=[funstrwords{i}{temp3(1)},'('];
                   for jj=1:length(subscripts2)
                    tempstr=[tempstr,subscripts2{jj},':end,'];
                   end % for jj=1:length(subscripts2)
                   tempstr=[tempstr(1:end-1),')'];
                  end 
                  %there might be an output var that is the same, so do a strrep
                  % if that's true, then this is the only function call on that line (probably)
                  funstr{i}=strrep(funstr{i},funstr{i}(funstrwords_b{i}(temp3(1)):parens2(2)),...
                                   tempstr);            
                  [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
                  goonimag=0;
                  break
                 end % if ~isempty(allLocalVar{ii}{goon,
                end % if allLocalVar{ii}{goon,w
               end % if ~isempty(allLocalVar{ii}{goon,
              end % for goon=1:size(allLocalVar{temp2(j)},
             end % if isempty(find(funstr{i}(parens2(1)+1:parens2(2)-1)==':'))
            end % if isempty(find(funstrwords_b{i}>centercomma(fid)&.
           end % if howmany2>0
          end % if ~any(strcmp(temp7,
         end % if ~isempty(temp3)
         if ~goonimag, break; end
        end % for fid=1:howmany
       end % if howmany>0
      end % for j=length(temp):-1:1
      if goonimag, break; end
     end % while true
    end % if isempty(find(strcmp(fun_name{ii},
   end % for i=temp5
  end % if ~isempty(temp5)
 end % if temp10
end % for ii=1:length(allLocalVar)

disp(['only had to check for * inputs in ',num2str(rets),' out of ',...
      num2str(length(allLocalVar))])
%%%disp([' ii = ',num2str( ii)]);
%%%'================',kb

%now assign funstr to filestr
temp4=cell(s*2,1);
temp4(1:2:s*2-1)=funstr;
temp4(2:2:end)={r};
temp6=10000;
temp5=[[0:temp6:2*s],2*s];
filestr='';
for ii=1:length(temp5)-1
 filestr=[filestr,temp4{temp5(ii)+1:temp5(ii+1)}];
end 
%'dfdfdfdfdf',kb












%%%for ii=1:length(allLocalVar)
%%% goon=0;
%%% for jj=1:size(allLocalVar{ii},1)
%%%  if ~isempty(allLocalVar{ii}{jj,13}) && ...
%%%       ~isempty(allLocalVar{ii}{jj,5}) && ...
%%%       any(strcmp(strtrim(allLocalVar{ii}{jj,5}),'*'))
%%%%%%          any(~cellfun('isempty',strcmp(allLocalVar{ii}{jj,5},'*')))
%%%   goon=1;
%%%   break
%%%  end % if ~isempty(allLocalVar{ii}{jj,
%%% end % for jj=1:size(allLocalVar{ii},
%%% if goon
%%%  temp5=find(~cellfun('isempty',regexp(funstr,fun_name{ii}))).';
%%%  if ~isempty(temp5)
%%%   for i=temp5
%%%    while true
%%%     temp=find(strcmp(funstrwords{i},fun_name{ii}));
%%%     goonimag=1;
%%%%%%   [temp,temp1,temp2]=intersect(funstrwords{i},fun_name);
%%%     for j=length(temp):-1:1
%%%      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
%%%      if howmany>0
%%%       %go through input args, seeing if the they are scalar refs to a matrix, 
%%%       % then if args in that subroutine are assumed shape
%%%       centercomma=[parens(1),centercomma,parens(2)];
%%%       for fid=1:howmany
%%%        temp3=find(funstrwords_b{i}>centercomma(fid) & funstrwords_b{i}<centercomma(fid+1));
%%%        if ~isempty(temp3)
%%%         [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,temp3(1),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
%%%         if howmany2>0
%%%          %this has to be the only thing passed, no other words or nums outside this var
%%%          if isempty(find(funstrwords_b{i}>centercomma(fid)&...
%%%                          funstrwords_b{i}<funstrwords_b{i}(temp3(1))))...
%%%               && ...
%%%               isempty(find(funstrnumbers_b{i}>centercomma(fid)&...
%%%                            funstrnumbers_b{i}<funstrwords_b{i}(temp3(1))))...
%%%               &&...
%%%               isempty(find(funstrwords_b{i}<centercomma(fid+1)&...
%%%                            funstrwords_b{i}>parens2(2)))...
%%%               && ...
%%%               isempty(find(funstrnumbers_b{i}<centercomma(fid+1)&...
%%%                            funstrnumbers_b{i}>parens2(2)))
%%%           if isempty(find(funstr{i}(parens2(1)+1:parens2(2)-1)==':'))
%%%            % is this an assumed shape on the way in?
%%%            for goon=1:size(allLocalVar{ii},1)
%%%             if ~isempty(allLocalVar{ii}{goon,13}) && ...
%%%                  allLocalVar{ii}{goon,13}==fid && ...
%%%                  ~isempty(allLocalVar{ii}{goon,5}) && ...
%%%                  any(~cellfun('isempty',strfind(allLocalVar{ii}{goon,5},'*')))
%%%              %let's go for it
%%%              tempstr=[funstrwords{i}{temp3(1)},'(sub2ind(size(',funstrwords{i}{temp3(1)},...
%%%                       '),',funstr{i}(parens2(1)+1:parens2(2)-1),'):end)'];
%%%              %there might be an output var that is the same, so do a strrep
%%%              % if that's true, then this is the only function call on that line (probably)
%%%              funstr{i}=strrep(funstr{i},funstr{i}(funstrwords_b{i}(temp3(1)):parens2(2)),tempstr);
%%%              %'xxxxxxxxxxxxxx1',funstr{i},kb
%%%              [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
%%%              goonimag=0;
%%%              break
%%%             end % if ~isempty(allLocalVar{temp2(j)}{goon,
%%%            end % for goon=1:size(allLocalVar{temp2(j)},
%%%           end % if isempty(find(funstr{i}(parens2(1)+1:parens2(2)-1)==':'))
%%%          end % if isempty(find(funstrwords_b{i}>centercomma(fid)&.
%%%         end % if howmany2>0
%%%        end % if ~isempty(temp3)
%%%        if ~goonimag, break; end
%%%       end % for fid=1:howmany
%%%      end % if howmany>0
%%%     end % for j=length(temp):-1:1
%%%     if goonimag, break; end
%%%    end % while true
%%%   end % for i=temp5
%%%  end % if ~isempty(temp5)
%%% end % if goon
%%%end % for ii=1:length(allLocalVar)
