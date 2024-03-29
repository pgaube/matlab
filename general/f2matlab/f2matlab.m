function [filestr,numErrors,extraFunctions,localVar,varp,typeDefs]=f2matlab(filename,varargin)
%f2matlab(filename)
% Call with the full function name as a string, including extension.
%
% f2matlab assumes all the pertinent program elements are in this one file.
%  So, put all modules, functions, subroutines, etc into one file.

% Some flags
want_kb=0;  % 1 ==> if keyboard mode is desired after some conversion steps
want_ze=1;  % 1 ==> direct f2matlab to zero all array variables.
want_fi=0;  % 1 ==> direct f2matlab to try to put fix()'s around declared integers.
want_smm=1; % 1 ==> try to deal with shape mismatching on in/out vars, 0 ==> don't
want_row=1; % 1 ==> 1-D fortran arrays become row vectors, if 0 then column vectors
want_lc=1;  % 1 ==> try to preserve case on variable names
want_cla=1; % 1 ==> deal with possible command line arguments, 0 ==> don't
want_pst=1; % 1 ==> have local variables be persistent by default (fortran behavior), 0 => not
want_vai=1; % 1 ==> add "varargin" to the input args on all functions (useful in some cases)
want_for=0; % 1 ==> increment for loop vars on exit
want_MP=0;  % 1 ==> change all the local vars in the main program to have an MP suffix 
want_gl=1;  % 1 ==> use global statements instead of module decs in subprograms


%%%%% most reliable translation
%%%want_kb=0;
%%%want_ze=1;
%%%want_fi=1;
%%%want_smm=1;
%%%want_row=1;
%%%want_lc=1;
%%%want_cla=1;
%%%want_pst=1;
%%%want_vai=1;


subfun=0; goon=0; ismod=0;
if ~isempty(varargin)
 if ischar(varargin{1})
  subfun=1;
  goon=1;
 else
  if varargin{1}==inf
   %we have a module declaration file
   ismod=1;   varargin={};   goon=0; want_ze=1;  modLocalVar={};
  end
 end
else
 goon=1;
end
if goon
 global funstr_all s_all fs_good_all inout whichsub modLocalVar modVarp modTypeDefs 
end
global sublist_all modUsedMods numstr wordstr changeCase tempcc tempccMP allTypeDefs suborfun 
tt1=cputime;

%Load keywords and function words.
MLkeywords={'break';'catch';'for';'global';'otherwise';'persistent';'switch';'try';'refresh'};
MLapp='mlv';
shapeVar='_shape'; needRS={};
fortranVarOrRes={'cycle','type'};
type_words={'program';'subroutine';'function'}; %keep this order of words for suborfun later
type_words2={'program';'function';'subroutine';'module';'blockdata';'interface'};
keywordsbegin={'for';'while';'switch';'if';'do';'else';'elseif';'case';'call';'global';'where';'elsewhere'};
var_words={'real';'complex';'integer';'logical';'character';'implicit';'intrinsic';'dimension';'common';'double';'precision';'doubleprecision';'intent';'allocatable';'pointer';'equivalence';'external';'parameter';'save';'automatic';'private';'public';'static';'optional';'volatile';'data';'type';'recursive'};
%var_words={'real';'complex';'integer';'logical';'character';'implicit';'intrinsic';'dimension';'common';'double';'precision';'doubleprecision';'intent';'allocatable';'pointer';'target';'equivalence';'external';'parameter';'save';'automatic';'private';'public';'static';'optional';'volatile';'data';'type';'recursive'};
operators={'=>' '=';'**' '.^';'/' './';'*' '.*'};
logicalops={'/=' '~=';'.and.' '&';'.or.' '|';'.eqv.' '==';'.le.' '<=';'.eq.' '==';'.ge.' '>=';'.gt.' '>';'.lt.' '<';'.ne.' '~=';'.true.' 'true';'.false.' 'false'};
TFops={'.true.','true','ttttttt';'.false.','false','fffffff'};
branchops={'end do' 'end';'end  do' 'end';'end if' 'end';'end  if' 'end';'enddo' 'end';'endif' 'end';'end select' 'end';'do while' 'while';'do  while' 'while';'else if' 'elseif';'case default' 'otherwise';'select case' 'switch'};
funwords=getfunwordsonly;
funwordsML=getfunwordsonlyML;
funwordsNoRemoveEq={'random_seed';'open';'write';'format'};
numstr='(\<(\d+\.\d+|\d+\.|\.\d+|\d+)([eEdDqQ][+-]?\d+)?)';
wordstr='(\<[a-z_A-Z]\w*)';
r=char(10);
fortranfunwords={'dble';'aimag';'do';'enddo';'endif';'int';'iji';'true';'false';'cmplx';'conj'};
fs_good=[]; dumvar='dumvar'; commonvars=cell(0); persistentVars=cell(0);
formats=cell(0,2);
extwords=cell(0);
numErrors=0;
setUpLocalVar
statementFunction=cell(0);   statementFunctionLines=[];
varPrefix='$_#_$_#_'; perRep='`';
DQ{1}='1213141516171819100001';
MPstr={'MP','L'};
extraFunctions=[];
sublist=cell(0,6);
usedMods=[];
varp=cell(0);
typeDefs=cell(0,2);
if ~subfun && ~ismod
 allTypeDefs=cell(0,2);
 changeCase=cell(0,1);
 suborfun=[];
end
globVar={}; % for want_gl

%First read the function into funstr.
if ~subfun
 funstr=cell(1,1);
 funstr_all=cell(1,1);
 if exist(filename,'file')==2
  fid=fopen(filename); filestr=fscanf(fid,'%c'); fclose(fid);
  if length(filestr)==0, return; end
  filestr=regexprep(filestr,'\%end','%eml'); %in case end is a var in a derived type
  if ~ismod
   %filestr=regexprep(filestr,'\%',perRep);
   filestr=strrep(filestr,'%',perRep);
  end
  if ~strcmpi(filestr(length(filestr)),r), filestr=[filestr,r]; end
  % remove blank lines (fortran doesn't care, but the readin routine
  % doens't continue lines correctly with blank lines.
  while ~isempty(strfind(filestr,[r,r]))
   filestr=strrep(filestr,[r,r],r);
  end
  if filestr(1)=='!' || filestr(1)=='%'
   filestr=['%',r,filestr]; 
  end

  
  funstr=strread(filestr,'%s','delimiter',r);  
  funstr=strtrim(funstr);
  temp1=regexp(funstr,['[!;]'],'once');
  for i=find(~cellfun('isempty',temp1))'
   temp2=find(funstr{i}=='!');
   if ~isempty(temp2)
    for j=1:length(temp2)
     if temp2(j)==1
      funstr{i}(1)='%';
     else
%%%      temp3=~inastring_f(funstr{i},temp2(j)) && ~inaDQstring_f(funstr{i},temp2(j)) && ...
%%%            ~incomment(funstr{i},temp2(j));
      %funstr,funstr{i},i,'cccccccccccc22',kb
      if temp2(j)<=length(funstr{i}) && validSpot(funstr{i},temp2(j))
       goon=1;
       %let's put these back before this line if this is a good line
       if temp2(j)>1 && any(~isspace(funstr{i}(1:temp2(j)-1))) && i>1
        for ii=i:-1:1
         temp3=find(~isspace(funstr{i}),1,'first');
         if funstr{ii}(temp3)~='&' && funstr{ii}(temp3)~='!' && funstr{ii}(temp3)~='%'
          funstr{ii-1}=[funstr{ii-1},r,'%',funstr{i}(temp2(j)+1:end)];
          funstr{i}=funstr{i}(1:temp2(j)-1);
          goon=0;
          %funstr,funstr{i},i,ii,'cccccccccccc',kb
          break
         end
        end
       end
       if goon
        funstr{i}=[funstr{i}(1:temp2(j)-1),r,'%',funstr{i}(temp2(j)+1:end)];
       end
      end % if temp3
     end % if j==1
    end % for j=1:length(temp2)
   end % if ~isempty(temp2)
   temp2=find(funstr{i}==';');
   if ~isempty(temp2)
    for j=length(temp2):-1:1
%%%     temp3=~inastring_f(funstr{i},temp2(j)) && ~inaDQstring_f(funstr{i},temp2(j)) &&...
%%%           ~incomment(funstr{i},temp2(j));
     if validSpot(funstr{i},temp2(j))
      funstr{i}=[funstr{i}(1:temp2(j)-1),r,funstr{i}(temp2(j)+1:end)];
     end % if temp3
    end % for j=length(temp2):-1:1
   end % if ~isempty(temp2)
  end % for i=1:length(funstr)
  %put it into a string and then back again to catch the new returns
  for i=1:length(funstr)
   if isempty(funstr{i}) || funstr{i}(end) ~= r
    funstr{i}=[funstr{i},r];
   end
  end
  filestr=[funstr{:}];
  
  

  
%%%  rets=findstr(r,filestr);
%%%  rets=[0 rets];
%%%  temp=findstr('!',filestr);
%%%  temp7=[rets,temp];
%%%  [temp5,temp6]=sort(temp7);
%%%  temp8=length(rets);
%%%  goonimag=[];
%%%  if ~isempty(temp)  
%%%   for i=length(temp7):-1:2
%%%    if temp6(i)>temp8 %have a !
%%%     if temp6(i-1)<=temp8 % we have the last ! before the return
%%%      goon=1;
%%%      temp3=~inastring_f(filestr(temp7(temp6(i-1)):temp7(temp6(i))),...
%%%                       temp7(temp6(i))-temp7(temp6(i-1))+1) && ...
%%%            ~inaDQstring_f(filestr(temp7(temp6(i-1)):temp7(temp6(i))),...
%%%                         temp7(temp6(i))-temp7(temp6(i-1))+1);
%%%      if ( temp7(temp6(i))-temp7(temp6(i-1)) ) >1 & any(~isspace(filestr(temp7(temp6(i-1)):temp7(temp6(i))-1))) %some non-white space before this !
%%%       if temp3
%%%        %not in a quote, so add a ret
%%%        % add a ret in between
%%%        goonimag=[goonimag,temp7(temp6(i))];        
%%%        goon=0;
%%%       end % if ~inastring_f(filestr(temp7(temp6(i-1)):temp7(temp6(i))),
%%%      end % if ( temp7(temp6(i))-temp7(temp6(i-1)) ) >1
%%%          %even if no whitespace before it, let's make it a %
%%%      if goon & temp3
%%%       %filestr(1:temp7(temp6(i))),'ssssssssss11',kb
%%%       filestr(temp7(temp6(i)))='%';
%%%      end
%%%     end % if temp6(i-1)<=temp8
%%%    end % if temp6(i)>temp8
%%%   end % for i=1:length(temp7)
%%%  end % if ~isempty(temp)    
%%%
%%%  if ~isempty(goonimag)
%%%   filestr=filestr(sort([1:length(filestr),goonimag]));
%%%   filestr(fliplr(goonimag)+[1:length(goonimag)]-1)=r;
%%%   filestr(fliplr(goonimag)+[1:length(goonimag)])='%';
%%%  end
%%%  
%%%  %filestr,'ssssssssss',kb
%%%  
%%%  rets=findstr(r,filestr);
%%%  rets=[0 rets];
%%%  temp=findstr(';',filestr);
%%%  temp7=[rets,temp];
%%%  [temp5,temp6]=sort(temp7);
%%%  temp8=length(rets);
%%%  if ~isempty(temp)  
%%%   for i=length(temp7):-1:2
%%%    if temp6(i)>temp8 %have a ;
%%%                      %find the next actual ret down from this '
%%%     for j=i-1:-1:1
%%%      if temp6(j)<=temp8
%%%       break
%%%      end
%%%     end
%%%     if ~inastring_f(filestr(temp7(temp6(j)):temp7(temp6(i))),temp7(temp6(i))-temp7(temp6(j))+1) && ~inaDQstring_f(filestr(temp7(temp6(j)):temp7(temp6(i))),temp7(temp6(i))-temp7(temp6(j))+1) %not in a quote, so add a ret
%%%                                                                                                 %filestr,kb
%%%      if ~any(filestr(temp7(temp6(j)):temp7(temp6(i)))=='%') %might be in comment
%%%                                                             % add a ret in between
%%%       filestr=[filestr(1:temp7(temp6(i))-1),r,filestr(temp7(temp6(i))+1:end)];
%%%      end % if ~any(filestr(temp7(temp6(i-1)):temp7(temp6(i)))=='!') %might be in comment
%%%     end % if ~inastring_f(filestr(temp7(temp6(i-1)):temp7(temp6(i))),    
%%%    end % if temp6(i)>temp8
%%%   end % for i=1:length(temp7)
%%%  end % if ~isempty(temp)      

  temp1=find(filestr=='&');
  temp2=true(size(filestr));
  for j=1:length(temp1)
    temp5=filestr(temp1(j):-1:max(temp1(j)-132,1));
    temp3=nextNonSpace(temp5,1);
    temp6=filestr(temp1(j):min(temp1(j)+132,length(filestr)));
    temp4=nextNonSpace(temp6,1);
    temp7=find(filestr(1:temp1(j))==r,1,'last');
    if ~inastring_f(filestr(temp7:temp1(j)),length(filestr(temp7:temp1(j))))
    %if filestr(filestr(temp1(j)-temp3+1))~='''' && filestr(temp1(j)+temp4-1)~=''''
     temp2(temp1(j)-temp3+2:temp1(j)+temp4-2)=false;
    end

    %filestr(temp1(j)-5:temp1(j)+5)
    %filestr(temp1(j)-temp3+2:temp1(j)+temp4-2)
    %inastring_f(filestr,temp1(j))
    %'deeeeeeeee',kb
  end % for j=1:length(temp1)
  filestr=filestr(temp2);
%%%  filestr=regexprep(filestr,'\s*\&\s*','');
  

  rets=findstr(r,filestr);
  rets=[0 rets];
  funstr=strread(filestr,'%s','delimiter',r);  
 
  %'ffffffffeeeeeeeeeee',funstr{i},kb  
 
 else
  error(['I can''t find the file ',filename,'...']);
 end
 %funstr=regexprep(funstr,{'\s+(';'(\s+';'\s+)';'\s+[';'[\s+';'\s+]'},{'(';'(';')';'[';'[';']'});
 %funstr=regexprep(funstr,'[ ]+(','(');
 %funstr=regexprep(funstr,'\s+(','(');
 % get rid of _kind on the end of numbers
 tempstr='(\<(\d+\.\d+|\d+\.|\.\d+|\d+)([eEdDqQ][+-]?\d+)?)(_\w+)';
 funstr=regexprep(funstr,tempstr,'$1');
 % updatefunstr_f grabs words incorrectly for numbers like 0.d0, so...
 tempstr='\<(\d+\.)([eEdDqQ][+-]?\d+)+';
 funstr=regexprep(funstr,tempstr,'$10$2');
 funstr=deblank(funstr);
 %make sure has only enddo, no white space between
 funstr=regexprep(funstr,'end\s+do','enddo','ignorecase');
 funstr=regexprep(funstr,'end\s+if','endif','ignorecase');
 funstr=regexprep(funstr,'block\s+data','blockdata','ignorecase');
 funstr=regexprep(funstr,['\.\<',TFops{1,2},'\>\.'],[TFops{1,2},TFops{1,3}],'ignorecase');
 funstr=regexprep(funstr,['\.\<',TFops{2,2},'\>\.'],[TFops{2,2},TFops{2,3}],'ignorecase');
 funstr=regexprep(funstr,['\<',TFops{1,2},'\>'],[TFops{1,2},MLapp],'ignorecase');
 funstr=regexprep(funstr,['\<',TFops{2,2},'\>'],[TFops{2,2},MLapp],'ignorecase');
 funstr=regexprep(funstr,['^(\<byte\>)'],'integer','ignorecase');
 
 s=length(funstr);
 %whos,'gggggggg',funstr,keyboard

 if want_kb,disp('Just read the function in'); showall_f(funstr), keyboard, end
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);   
 %get words that need to have their case preserved
 if want_lc && ~ismod
  caseProtectedML=getCaseProtectedML;
  changeCase={};
  %change all to lower case except strings and comments and variables
  for i=fliplr(fs_good)
   if ~isempty(funstrwords{i})
    temp=any(strcmpi(funstrwords{i}{1},{var_words{:},type_words{:}}));
    if temp
%%%     if any(strcmpi(funstrwords{i},'m2v2'))
%%%      funstr{i},kb
%%%     end
     for j=1:length(funstrwords{i})
      if ~(any(strcmpi(funstrwords{i}{j},var_words)) || ...
           any(strcmpi(funstrwords{i}{j},type_words)) ||... 
           any(strcmpi(funstrwords{i}{j},funwords)) ||... 
           incomment(funstr{i},funstrwords_b{i}(j)) || ...
           inastring_f(funstr{i},funstrwords_b{i}(j)) )
       % is the fortran ridiculous enough to have the word "end" as a variable?
       if strcmp(funstrwords{i}{j},'end')
        funstr{i}(funstrwords_b{i}(j):funstrwords_e{i}(j))='eml';
        funstrwords{i}{j}='eml';
        [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
       end
       %we have a variable, save it
       changeCase{length(changeCase)+1}=funstrwords{i}{j};
      end % if temp && ~any(strcmpi(funstrwords{i}{j},
     end % for j=1:length(funstrwords{i})
%%%   if any(strcmp(funstrwords{i},'eml'))
%%%    funstr{i},kb
%%%   end
    end % if temp    
   end % if ~isempty(funstrwords{i})
  end % for i=fliplr(fs_good)
  [sublist,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good]=findendSub_f([],sublist,s,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good,funwords,var_words);
  changeCase={changeCase{:},sublist{:,1}};
  changeCase={changeCase{~cellfun('isempty',{changeCase{:}})}};
  [temp1,temp2,temp3]=unique(lower(changeCase));
  keepSomeCases
  changeCase={changeCase{temp2}};
  temp1=strcmp(changeCase,lower(changeCase));
  changeCase={changeCase{~temp1}};
  temp2=find(ismember(lower(changeCase),caseProtectedML));
  for i=1:length(temp2)
   changeCase{temp2(i)}=lower(changeCase{temp2(i)});
  end
  %'freeeeeeee',changeCase,funstr,kb
  tempcc=changeCase;
  for i=1:length(changeCase)
   tempcc{i}=['\<',changeCase{i},'\>'];
  end
  % don't allow the small words to be capitalized
  temp5=3;
  temp1=find(cellfun('length',changeCase)<temp5);
  changeCase(temp1)=lower(changeCase(temp1));
 
%%%  % Now, if one of these words does appear in a string, then go with the 
%%%  %  capitalization in the string
%%%  temp=regexp(funstr,[''''],'once');
%%%  temp2=find(~cellfun('isempty',temp));
%%%  %'fffffffffff',kb
%%%  for i=temp2(:).'
%%%   for j=1:length(funstrwords{i})
%%%    if length(funstrwords{i}{j})>=ccLim && inastring_f(funstr{i},funstrwords_b{i}(j)) && ...
%%%         ~incomment(funstr{i},funstrwords_b{i}(j)) && ...
%%%         (funstr{i}(funstrwords_b{i}(j)-1)=='''' && ...
%%%          length(funstr{i})>funstrwords_e{i}(j) && ...
%%%          (funstr{i}(funstrwords_e{i}(j)+1)=='''' )) && ...
%%%         inwhichlast_f(i,funstrwords_b{i}(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename)==1
%%%     temp3=find(strcmpi(funstrwords{i}{j},changeCase));
%%%     if ~isempty(temp3)
%%%      changeCase{temp3(1)}=funstrwords{i}{j};
%%%     end
%%%    end
%%%   end
%%%  end
  
 end % if want_lc

 
 %lower case all those lines with no ' or % in them
 %  and $ => _ ($ can be part of var names in fortran)
 temp=regexp(funstr,[''''],'once');
 temp1=regexp(funstr,['[%]'],'once');
 temp2=find(cellfun('isempty',temp) & cellfun('isempty',temp1));
 temp4=find(~(cellfun('isempty',temp) & cellfun('isempty',temp1)));
 funstr(temp2)=lower({funstr{temp2}}).';
 funstr(temp2)=regexprep({funstr{temp2}},'\$','_').';
 %change all to lower case except strings and comments
 for i=find(~cellfun('isempty',temp))'
  for j=1:length(funstrwords{i})
   temp2=incomment(funstr{i},funstrwords_b{i}(j));
   if ~temp2
    temp1=inastring_f(funstr{i},funstrwords_b{i}(j));
    if ~temp1
     funstr{i}(funstrwords_b{i}(j):funstrwords_e{i}(j))=...
         lower(funstr{i}(funstrwords_b{i}(j):funstrwords_e{i}(j)));
    end % if ~temp1(j)
   else
    break %in a comment, so no further test on this line
   end % if ~temp2(j)
  end % for j=1:length(funstrwords{i})
 end % for i=fs_good

 for i=temp4(:).'
  temp3=find(funstr{i}=='$');
  for j=1:length(temp3)
   if ~incomment(funstr{i},temp3(j)) && ~inastring_f(funstr{i},temp3(j))
    funstr{i}(funstr{i}=='$')='_';
    %'pppppppp1',funstr{i},keyboard
   end % if ~incomment(funstr{i},
  end % for j=1:length(temp3)
 end % for i=temp4(:).
  
 if ~ismod
  %change all { back to % (if in a comment) or . (not)
  %tempstr=repmat('|',1,length(perRep));
  %funstr=regexprep(funstr,perRep,tempstr);
  temp=regexp(funstr,perRep);
  for i=find(~cellfun('isempty',temp))'
%%%   if any(strcmpi(funstrwords{i},'IterationAbsoluteAggregateTarget')) && any(strcmpi(funstrwords{i},'target'))
%%%    funstr{i},'\\\\\\\\\\\\',kb
%%%   end
   for j=length(temp{i}):-1:1
    temp2=incomment(funstr{i},temp{i}(j)) || inastring_f(funstr{i},temp{i}(j));
    if temp2
     funstr{i}(temp{i}(j))='%';
     %funstr{i}=[funstr{i}(1:temp{i}(j)-1),'%',funstr{i}(temp{i}(j)+6:end)];
    else
     funstr{i}(temp{i}(j))='.';
     %funstr{i}=[funstr{i}(1:temp{i}(j)-1),'.',funstr{i}(temp{i}(j)+6:end)];
    end % if ~temp2
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
   end % for j=1:length(funstrwords{i})
  end % for i=fs_good
 end
 
 
 % if ' is in a double quote string " ", then change to '', unless it's in a write or a format
 temp2=regexp(funstr,['"'],'once')';
 temp3=find(~cellfun('isempty',temp2));
 for i=temp3
  %for i=1:s
  if ~isempty(funstr{i})
   temp1=strfind(funstr{i},'''');
   if ~isempty(temp1)
    for jj=length(temp1):-1:1
     if inaDQstring_f(funstr{i},temp1(jj))
      goon=1;
      for j=1:length(funstrwords{i})
       if any(strcmp(funstrwords{i}{j},{'write','format'}))
        [howmany,subscripts,centercomma,parens]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
        if howmany>0
         if temp1(jj)>parens(1) && temp1(jj)<parens(2)
          goon=0;break
         end
        end
       end
      end
      if goon
       funstr{i}=[funstr{i}(1:temp1(jj)-1),DQ{1},funstr{i}(temp1(jj)+1:end)];
      end
     end % if inaDBDQstring_o(funstr{ii},
    end % for jj=length(temp1):-1:1
   end % if ~isempty(temp1)
  end % if ~isempty(funstr{ii})
 end

 % if '' is in a single quote string '   ' or a DQ string, then change to DQ{1}
 temp2=regexp(funstr,[''''''],'once')';
 temp3=find(~cellfun('isempty',temp2));
 for i=temp3
  %for i=1:s
  if ~isempty(funstr{i})
   temp1=strfind(funstr{i},'''');
   if ~isempty(temp1)
    for jj=length(temp1):-1:1
     if ~incomment(funstr{i},temp1(jj))
      if length(funstr{i})>temp1(jj) && funstr{i}(temp1(jj)+1)=='''' && ...
           ~inastring_f(funstr{i},temp1(jj))
       funstr{i}=[funstr{i}(1:temp1(jj)-1),DQ{1},funstr{i}(temp1(jj)+2:end)];
       %funstr{i},funstr{i}(1:temp1(jj)),'ccccccccccc',kb
      end % if length(funstr{i})>temp1(jj) && funstr{i}(temp1(jj)+1)=='''' && .
     end % if inaDBDQstring_o(funstr{ii},
    end % for jj=length(temp1):-1:1
   end % if ~isempty(temp1)
  end % if ~isempty(funstr{ii})
 end


 
 %fix the " to be '
 %funstr=strrep(funstr,'"','''');
 temp2=regexp(funstr,['"'],'once')';
 temp3=find(~cellfun('isempty',temp2));
 for i=temp3
  if ~isempty(funstr{i})
   temp1=strfind(funstr{i},'"');
   if ~isempty(temp1)
    for jj=length(temp1):-1:1
     if ~inastring_f(funstr{i},temp1(jj))
      %funstr{i}=[funstr{i}(1:temp1(jj)-1),'''',funstr{i}(temp1(jj):end)];
      funstr{i}(temp1(jj))='''';
     end % if inastring_f(funstr{ii},
    end % for jj=length(temp1):-1:1
   end % if ~isempty(temp1)
  end % if ~isempty(funstr{ii})
 end
 

 %'ffffffffff',funstr,kb
 
 
 tempstr=cell(size(MLkeywords));
 temp3=cell(size(MLkeywords));
 for i=1:length(MLkeywords)
  tempstr{i}=[MLkeywords{i},'ml'];
  temp3{i}=['\<',MLkeywords{i},'\>'];
 end
 
 temp=regexp(funstr,[''''],'once');
 temp1=regexp(funstr,['%'],'once');
 temp2=find(cellfun('isempty',temp)&cellfun('isempty',temp1));
 funstr(temp2)=regexprep({funstr{temp2}},{temp3{:}},{tempstr{:}})';
 funstr(temp2)=regexprep({funstr{temp2}},'[ ]+(','(');
 % we also have to fix vars that are ok in fortran, but not in ML, like 'if' 
 funstr(temp2)=regexprep({funstr{temp2}},'\<if\>(\s*)([^\(]|$)',['if',MLapp,'$1$2'])';
 funstr(temp2)=regexprep({funstr{temp2}},'\<case\>(\s*)([^\(]|$)',['case',MLapp,'$1$2'])';
 funstr(temp2)=regexprep({funstr{temp2}},['\<case',MLapp,'\>(\s*)(default)'],['case$1default'])';
%%% funstr(temp2)=regexprep({funstr{temp2}},'\<conj\>(\s*)([^\(]|$)',['conj',MLapp,'$1$2'])';
%%% funstr(temp2)=regexprep({funstr{temp2}},'^cycle$','ccccyyyycccclllleeee')';
%%% funstr(temp2)=regexprep({funstr{temp2}},'\<cycle\>',['cycle',MLapp])';
%%% funstr(temp2)=regexprep({funstr{temp2}},'^ccccyyyycccclllleeee$','cycle')';
% change over matlab reserved words to varML
 for i=find(~cellfun('isempty',temp))'
  for j=1:length(funstrwords{i})
   temp=find(strcmp(funstrwords{i}{j},MLkeywords));
   if ~isempty(temp)
    if ~inastring_f(funstr{i},funstrwords_e{i}(j)) & ~incomment(funstr{i},funstrwords_b{i}(j))
     funstr{i}=[funstr{i}(1:funstrwords_e{i}(j)),'ml',funstr{i}(funstrwords_e{i}(j)+1:end)];
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    end % if ~inastring_f(funstr{i},
   end % if ~isempty(temp)
  end
  % if
  %temp4=regexp(funstr{i},'\<if\>(\s*)([^\(]|$)');
  temp4=regexp(funstr{i},'\<if\>');
  for j=length(temp4):-1:1
   if ~inastring_f(funstr{i},temp4(j)) & ~incomment(funstr{i},temp4(j))
    funstr{i}=regexprep(funstr{i},'\<if\>(\s+)',['if'],j);
    funstr{i}=regexprep(funstr{i},'\<if\>([^\(]|$)',['if',MLapp,'$1'],j);
   end % if ~inastring_f(funstr{i},
  end
  % case
  %temp4=regexp(funstr{i},'\<case\>(\s*)([^\(]|$)');
  temp4=regexp(funstr{i},'\<case\>');
  for j=length(temp4):-1:1
   if validSpot(funstr{i},temp4(j))
    temp5=nextNonSpace(funstr{i},temp4(j)+3);
    if temp5<=length(funstr{i}) && funstr{i}(temp5)~='(' && funstr{i}(temp5)~='d'
     funstr{i}=[funstr{i}(1:temp4(j)+3),MLapp,funstr{i}(temp4(j)+4:end)];
%%%     funstr{i}=regexprep(funstr{i},'\<case\>(\s*)([^\(]|$)',['case',MLapp,'$1$2'],j);
%%%     funstr{i}=regexprep(funstr{i},['case',MLapp,'(\s*)default'],['case$1default'],j);
    end
   end % if ~inastring_f(funstr{i},
   %'cccccccccc',funstr(i),kb
  end % for j=length(temp4):-1:1
      % conj
%%%  temp4=regexp(funstr{i},'\<conj\>(\s*)([^\(]|$)');
%%%  for j=length(temp4):-1:1
%%%   if ~inastring_f(funstr{i},temp4(j)) & ~incomment(funstr{i},temp4(j))
%%%    funstr{i}=regexprep(funstr{i},'\<conj\>(\s*)([^\(]|$)',['conj',MLapp,'$1$2'],j);
%%%   end % if ~inastring_f(funstr{i},
%%%  end % for j=length(temp4):-1:1
% cycle
%%%  temp4=regexp(funstr{i},'\<cycle\>');
%%%  for j=length(temp4):-1:1
%%%   if ~inastring_f(funstr{i},temp4(j)) & ~incomment(funstr{i},temp4(j))
%%%    funstr{i}=regexprep(funstr{i},'\<cycle\>',['cycle',MLapp],j);
%%%   end
%%%  end
 end % for i=1:s
 
 % save
 temp=regexp(funstr,'\<save\>');
 for i=find(~cellfun('isempty',temp))'
  for j=length(temp{i}):-1:1
   goon=0;
   if ~inastring_f(funstr{i},temp{i}(j))
    while 1
     if (temp{i}(j)+3)==length(funstr{i}) %this ends the line, so change
      goon=1;
      break
     end
     % save :: statement so don't change
     if ~isempty(findstr(funstr{i},'::'))
      break
     end
     if isletter(funstr{i}(nextNonSpace(funstr{i},temp{i}(j)+3)))
      if temp{i}(j)~=1
       goon=1;
       break
      else
       goon=0;
       break
      end
     else
      if funstr{i}(nextNonSpace(funstr{i},temp{i}(j)+3))=='/'
       goon=0;
       break
      else
       goon=1;
       break
      end
     end
     break
    end
   end
   if goon
    %'freeeeeeeee',funstr{i},kb
    funstr{i}=regexprep(funstr{i},'\<save\>',['save',MLapp],j);
   end
  end % for j=length(temp{i}):-1:1
 end

 %fix the semicolon
 temp=regexp(funstr,'[^;]$'); %if funstr{i}(end)~=';', funstr{i}=[funstr{i},';']; end
 temp=(~cellfun('isempty',temp));
 for i=fs_good
  %Deblank front and back
  funstr{i}=deblank(funstr{i});
  %Ensure semilcolon at end
  if temp(i) & ~isempty(funstr{i})
   funstr{i}=[funstr{i},';'];
  end
 end

%%% % character varname*(#) need to be changed to varname(#)
%%% funstr=regexprep(funstr,['(character) (.+\w)\*\((.+)\)'],['$1\*$3 $2']);
 
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr); 
 
 % 'end' when used as a variable
 temp=regexp(funstr,'\<end\>');
 for i=find(~cellfun('isempty',temp))'
  temp1=find(strcmp(funstrwords{i},'end'));
  if ~isempty(temp1)
   for j=length(temp1):-1:1
    if validSpot(funstr{i},funstrwords_b{i}(temp1(j)))
     goon=0;
     if temp1(j)==length(funstrwords{i}) || (temp1(j)<length(funstrwords{i}) && ...
          ~any(strcmp(funstrwords{i}{temp1(j)+1},{type_words2{:},'select'})))
      goon=1;
     end
     if ~(funstrwords_b{i}(temp1(j))>1 && ...
          any(~isspace(funstr{i}(1:funstrwords_b{i}(temp1(j))-1))))
      goon=0;
     end
     if goon
      funstr{i}(funstrwords_b{i}(temp1(j)):funstrwords_e{i}(temp1(j)))='eml';
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
     end
    end % if validSpot(funstr{i},
   end % for j=length(temp1):-1:1
  end % if ~isempty(j)
%%%    if any(strcmp(funstrwords{i},'start'))
%%%     funstr{i},kb
%%%    end
  
 end % for i=find(~cellfun('isempty',
 
 
 % type
 temp=regexp(funstr,'\<type\>');
 for i=find(~cellfun('isempty',temp))'
  temp2=find(strcmp(funstrwords{i},'type'));
  for j=length(temp2):-1:1
   if validSpot(funstr{i},funstrwords_b{i}(temp2(j)))
    if temp2(j)==2 && strcmp(funstrwords{i}{1},'end') % is an end type
     continue
    end
    if any(nextNonSpace(funstr{i},funstrwords_e{i}(temp2(j)))==funstrwords_b{i}) %word after
     continue
    end
    [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp2(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    %'rttttttttttt',funstr,funstr{i},kb
    if howmany>0 
     if any(nextNonSpace(funstr{i},parens(2))==funstrwords_b{i}) || ...
          funstr{i}(nextNonSpace(funstr{i},parens(2)))==':' || ...
          funstr{i}(nextNonSpace(funstr{i},parens(2)))==','
      continue
     end
    end
    if inastring_f(funstr{i},funstrwords_b{i}(temp2(j))) || ...
         incomment(funstr{i},funstrwords_b{i}(temp2(j)))
     continue
    end
    %'ewqqqqqqqqqqqqqqqqq',funstr{i},kb
    funstr{i}=[funstr{i}(1:funstrwords_e{i}(temp2(j))),MLapp,funstr{i}(funstrwords_e{i}(temp2(j))+1:end)];
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    %'how did we do?',funstr{i},kb
   end
  end % for j=length(temp4):-1:1
 end % for i=find(~cellfun('isempty',

 
 funstr_all=funstr;
 s_all=s;
 fs_good_all=fs_good;
else
 funstr=funstr_all;
 s=s_all;
 fs_good=fs_good_all;
end


%'rttttttttttt',funstr.',kb
%%%aa=find(strcmp({sublist{:,4}},'interface'))


%Get the base filename, and the program entry name
if ~subfun
 temp=findstr(filename,'.');
 if ~isempty(temp)
  filename_base=filename(1:temp(end)-1);
 else
  filename_base=filename;
 end
 this_fun_name=filename_base;
else
 this_fun_name=varargin{1};
end

% get rid of interfaces... who needs 'em?
if ~subfun
 [sublist,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good]=findendSub_f([],sublist,s,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good,funwords,var_words);
 if ~ismod, sublist_all=sublist; end %this includes interface routine names
 fid=0;
 temp6=true(1,s);
 for i=size(sublist,1):-1:1
  if strcmp(sublist{i,4},'interface')
   temp6(sublist{i,2}:sublist{i,3})=false;
   fid=1;
  end % if strcmp(sublist{i,
 end
 funstr={funstr{temp6}};
%%% for i=size(sublist,1):-1:1
%%%  if strcmp(sublist{i,4},'interface')
%%%   %'mmmmmmmmm',sublist,kb
%%%   [sublist{i,2},sublist{i,3}]
%%%   aa=find(~cellfun('isempty',strfind(funstr,'error_codes_module')));
%%%   disp(['err at ',n2s(aa(:)')])
%%%   if length(aa)~=2 || sublist{i,3}>max(aa)
%%%    'aaaaaaaaaaa',kb
%%%   end
%%%   funstr={funstr{1:sublist{i,2}-1},funstr{sublist{i,3}+1:end}};
%%%   fid=1;
%%%  end % if strcmp(sublist{i,
%%% end
 if fid==1
  [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
  [sublist,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good]=findendSub_f([],sublist,s,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good,funwords,var_words);
 end % if fid==1
end

%'errrrrrrrrrrrrr',sublist,kb

%adjust things for modules
if ~ismod & ~subfun
 %Put the capitals back in sublist
%%% if want_lc
%%%  for i=1:size(sublist,1)
%%%   sublist{i,1}=regexprep(sublist{i,1},tempcc,changeCase,'ignorecase');
%%%  end % for i=1:size(sublist,
%%% end % if want_lc
 module_adj
 modLocalVar={};
 modVarp={};
 modTypeDefs={};
 %now call f2matlab on that new module script
 fprintf(1,'  Taking care of the modules (if there are any) ***\n')
 temp4=1;
 for i=1:size(sublist,1)
  %for i=size(sublist,1):-1:1
  if strcmp(sublist{i,4},'module')
   %'llllllllllllllll',sublist{i,1},kb
   if want_lc
    eval(['[temp,temp1,temp2,temp3,temp5,temp6]=f2matlab(''',....
          [regexprep(sublist{i,1},tempcc,changeCase,'ignorecase'),'.m'],''',inf);']);
   else
    eval(['[temp,temp1,temp2,temp3,temp5,temp6]=f2matlab(''',....
          [sublist{i,1},'.m'],''',inf);']);
   end
   modLocalVar{temp4,1}=sublist{i,1};
   modLocalVar{temp4,2}=temp3;
   modVarp{temp4,1}=sublist{i,1};
   modVarp{temp4,2}=temp5;
   modTypeDefs{temp4,1}=sublist{i,1};
   modTypeDefs{temp4,2}=temp6;
   temp4=temp4+1;
  end % if strcmp(sublist{i,
 end % for i=size(sublist,
end % if ~ismod

%%%ismod, subfun, modLocalVar, '////////', kb


%We only want to work with this segment of the file,
if subfun
 temp=this_fun_name;
else
 temp=[];
end
if ~subfun
 temp1=[]; %Line numbers of segment declarations
 temp2=1;  %Which segment we are processing this time
 temp5=[]; %Number of current segment 
 fun_name=cell(0);
 fid=regexp(funstr,['\<(',type_words{1},'|',type_words{2},'|',type_words{3},')\>']); 
 temp6=find(~cellfun('isempty',fid))';
 for i=temp6(:).'
  %for i=fs_good
  goon=0; temp7=0;
  for j=1:length(type_words)
   temp4=find(strcmpi(type_words{j},funstrwords{i}));
   if ~isempty(temp4)
    if validSpot(funstr{i},funstrwords_b{i}(temp4(1)))
     goon=1;     temp7=j-1;     break
    end
   end
  end
  if goon
   if ~any(strcmp('end',funstrwords{i}))
    funstr{i}=funstr{i}(fid{i}:end);
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    %Got a segment declaration
    temp1=[temp1,i];
    %Find the segment name
    count=findstr('(',funstr{i});
    if ~isempty(count)
     count=count(1);
     temp3=find(funstrwords_b{i}<count);
     temp3=temp3(end);
     fun_name{end+1}=funstrwords{i}{temp3};
    else
     fun_name{end+1}=funstrwords{i}{end};
    end
    suborfun(length(fun_name))=temp7;
    %funstr{i},suborfun,kb
    if isempty(temp)
     temp=fun_name{end};
     this_fun_name=temp;
    end
    if any(strcmpi(temp,funstrwords{i}))
     %This is the segment we want for this round
     temp5=temp2;
    end
    temp2=temp2+1;
   end
  end
 end
 segmentStarts=temp1;
 whichsub=temp5;
 numSegs=temp1;
else
 whichsub=varargin{2};
 segmentStarts=varargin{3};
 fun_name=varargin{4};
end
%fun_name,this_fun_name,temp5,temp2,segmentStarts,whichsub
% 'werrrrrrrrr',kb 

%varargin,whichsub,segmentStarts,fun_name,funstr,'[[[[[[[[[[ppppppppppp',kb

%Assign funstr and fs_good to scope only this segment
if ~isempty(segmentStarts)
 if whichsub==length(segmentStarts)
  %Last (or only) segment
  funstr={funstr{segmentStarts(whichsub):end}}';
  fs_good=fs_good(fs_good>=segmentStarts(whichsub));
  fs_good=fs_good-(fs_good(1)-1);
 else
  funstr={funstr{segmentStarts(whichsub):segmentStarts(whichsub+1)-1}}';
  fs_good=fs_good((fs_good>=segmentStarts(whichsub))&(fs_good<segmentStarts(whichsub+1)));
  fs_good=fs_good-(fs_good(1)-1);
 end
end


%temp,funstr,'bbbbbbbb',kb

[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
if ~isempty(intersect(type_words,funstrwords{1}))
 showall_f(funstr(1),1);
end
disp(['    Number of lines:   ',num2str(s)])

%find all the format statements and their labels
for i=fs_good
 if any(strcmp(funstrwords{i},'format'))
  temp=find(strcmpi(funstrwords{i},'format'));
  if ~inastring_f(funstr{i},funstrwords_b{i}(temp(1)))
   [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp(1),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
   if howmany>0
    %found a format statement
    % there may be a string/num combo such as e20.13'tepoch='e20.13 that we have to split up
    goon=1;
    while goon
     goon=0;
     for ii=1:length(subscripts)
      temp=breakOffFirstFormat(subscripts{ii});
      temp3=length(temp);
      if temp3>1
       for jj=(length(subscripts):-1:ii+1) +(temp3-1)
        subscripts{jj}=subscripts{jj-(temp3-1)};
       end
       for jj=(1:length(temp))
        subscripts{jj+ii-1}=temp{jj};
       end
       goon=1;
      end
     end
    end
    howmany=length(subscripts);
    formats{size(formats,1)+1,1}=funstrnumbers{i}{1};
    formats{size(formats,1)  ,2}=funstr{i}(funstrwords_b{i}(1):parens(2));
    formats{size(formats,1)  ,3}=howmany;
    formats{size(formats,1)  ,4}=subscripts;
    formats{size(formats,1)  ,5}=centercomma;
    formats{size(formats,1)  ,6}=parens;
   end % if howmany>0
  end
 end
end
%formats,'ffffffffffff',keyboard


%which modules is this subroutine using?
temp=find(strcmp(this_fun_name,{modUsedMods{:,1}}));
if ~isempty(temp)
 [dummy,temp2,usedMods]=intersect({modUsedMods{temp,2}{:}},{modLocalVar{:,1}});
end
%Now use this to add to localVar, varp, and typeDefs when required.

%%%%which modules is this subroutine using?
%%%temp=find(~cellfun('isempty',regexp(funstr,'\<use\>'))).';
%%%if ~isempty(temp)
%%% for i=temp(:).'
%%%  temp4=strcmp(funstrwords{i},'use');temp4=temp4(1);
%%%  if ~inastring_f(funstr{i},funstrwords_b{i}(temp4)) & ~incomment(funstr{i},funstrwords_b{i}(temp4))
%%%   for j=temp4+1%:length(funstrwords{i}) %can only name 1 module per use
%%%    temp2=find(strcmp(funstrwords{i}{j},{modLocalVar{:,1}}));
%%%    usedMods=unique([usedMods,temp2]);
%%%   end % for j=temp4+1:length(funstrwords{i})
%%%  end % if ~inastring_f(funstr{i},
%%% end % for i=1:length(temp)
%%%end % if ~isempty(temp)
%%%%Now use this to add to localVar, varp, and typeDefs when required.


%Remove initial numbers from numbered lines with no continue
for i=fs_good
 if ~isempty(regexp(funstr{i},'^\s*[\d]+\s+','once')) 
  if ~strcmp(funstrwords{i}{1},'continue')
   funstr{i}=regexprep(funstr{i},'^\s*[\d]+(\s+)','$1');
  else
   funstr{i}=['% ',funstr{i}];   
  end % if ~strcmp(funstrwords{i}{1},
  [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
 end % if ~isempty(regexp(funstr,
end % for i=fs_good


% remove anything after the trailing ends 
funstr=regexprep(funstr,['^\s*end\s+'],'end %');
%except ending type defs
funstr=regexprep(funstr,['^\s*end %type'],'end type');

%'[][][][][][][]',funstr,ismod,kb


%Convert other segments and save them
filestr_subfun=[];
if whichsub==1
 inout=cell(length(fun_name),1);
 if length(numSegs)>1
  disp(['********** f2matlab found the following ',num2str(length(fun_name)),' program units:']);
  fun_name(:)
  for i=2:length(numSegs)
   [temp2,temp3,temp4,temp5]=f2matlab(filename,fun_name{i},i,segmentStarts,fun_name);
   numErrors=numErrors+temp3;
   filestr_subfun=[filestr_subfun,temp2];
   extraFunctions=unique([extraFunctions,temp4]);
   %'wait',temp2,keyboard
  end
 end
 whichsub=1;
end



%Misc tasks
%%%%fix the semicolon
%%%temp=regexp(funstr,'[^;]$'); %if funstr{i}(end)~=';', funstr{i}=[funstr{i},';']; end
%%%temp=(~cellfun('isempty',temp));
%%%for i=fs_good
%%% %Deblank front and back
%%% funstr{i}=deblank(funstr{i});
%%% %Ensure semilcolon at end
%%% if temp(i) & ~isempty(funstr{i})
%%%  funstr{i}=[funstr{i},';'];
%%% end
%%%end
%%%

%need to take care of common block variable names
temp=find(~cellfun('isempty',regexp(funstr,'\<common\>'))); temp=temp(:).';
temp3=[];temp4={};
if ~isempty(temp)
 for i=fliplr(temp)
%%% try
  if ~isempty(funstrwords{i})
   temp2=find(strcmp(funstrwords{i},'common'));
   if ~isempty(temp2)
    if ~inastring_f(funstr{i},funstrwords_b{i}(temp2(1))) & ...
         ~incomment(funstr{i},funstrwords_b{i}(temp2(1)))
     temp3=[temp3,i];  temp4{end+1}=funstr{i};
     %'cccccccccc22',funstr{i},funstrwords{i},kb
     tempstr='bcom_';
     fid=1;
     temp1=find(funstr{i}=='/');
     for j=1:length(funstrwords{i})
      if ~any(strcmp(funstrwords{i}{j},var_words))
       if ~inastring_f(funstr{i},funstrwords_b{i}(j))&&~incomment(funstr{i},funstrwords_b{i}(j))
        if inwhichlast_f(i,funstrwords_b{i}(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename)==0
         if mod(length(temp1(temp1<funstrwords_b{i}(j))),2)==1
          tempstr=[funstrwords{i}{j},'_'];
          fid=1;
         else %we have a common variable?
          funstr=regexprep(funstr,['\<',funstrwords{i}{j},'\>'],[tempstr,num2str(fid)]);
          fid=fid+1;
          [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
          temp1=find(funstr{i}=='/');
         end
        end % if inwhichlast_f(i,
       end % if ~inastring_f(funstr{i},
      end
     end % for j=1:length(funstrwords{i})
         %'cccccccccc',funstr{i},kb
    end % if ~inastring_f(funstr{i},
   end % if ~isempty(temp2)
  end % if ~isempty(funstrwords{i})
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with common block variable names in the following line:')
%%%  warning(funstr{i})
%%% end
 end % for i=fliplr(temp)
end % if ~isempty(temp)
for i=temp3
 funstr(i+2:end+2)=funstr(i:end); 
 funstr{i+2}=['%% ',funstr{i}];
 funstr{i+1}=['%% ',temp4{find(i==temp3)}];
end
[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);


%'reeeeeeee7890',funstr,keyboard





%separate out all variable declarations
for i=fliplr(fs_good)
 try
  if ~isempty(funstrwords{i})
   if any(strcmpi(funstrwords{i}{1},var_words))
    %find the last var_word or ::. variables after that...
    temp2=strfind(funstr{i},'::')+1;
    goon=0;
    if isempty(temp2)
     temp5=find(strcmp(funstrwords{i},'data'));
     %or how about stuff like:
     %  integer days_in_month(12) /31,28,31,30,31,30,31,31,30,31,30,31/
     %  integer tso_index, errnoerr /2/
     temp7=find(funstr{i}=='/');
     if ~isempty(temp7) && length(temp7)/2==floor(length(temp7)/2)
      %funstr{i},'jjjjjjjjjjj',kb
      if ~any(funstr{i}(temp7-1)=='(') || ~any(funstr{i}(temp7+1)==')')
       if ~any(strcmp('common',funstrwords{i})) && ~any(strcmp('data',funstrwords{i}))
        if all(validSpot(funstr{i},temp7))
         goon=1;
        end % if all(validSpot(funstr{i},
       end % if ~any(strcmp('common',
      end % if ~any(funstr{i}(temp7-1)=='(') || ~any(funstr{i}(temp7+1)==')')
     end % if ~isempty(temp7) && length(temp7)/2==floor(length(temp7)/2)
     if ~isempty(temp5) %split up the data statement
      j=temp5(1);
      goon=1;
      [temp6,temp4]=getTopGroupsAfterLoc(funstr{i},funstrwords_e{i}(j),'/');
      funstr{i}=fixDataGroups(temp6);
      [temp6,temp4]=getTopGroupsAfterLoc(funstr{i},funstrwords_e{i}(j),'/');
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      temp4=[funstrwords_e{i}(j)+1,temp4];
      tempstr='';
      %'/////////////',temp4,funstr{i},kb
     end
     fid='::';
     [temp,temp1]=ismember(var_words,funstrwords{i});
     temp1=max(temp1);
     temp2=funstrwords_e{i}(temp1);
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if howmany==0
      %is there a *8 or sim there?
      if strcmp(funstr{i}(nextNonSpace(funstr{i},funstrwords_e{i}(temp1))),'*')
       % take up until the next whitespace
       temp2=regexp(funstr{i},[funstrwords{i}{temp1},'\*','\d+'],'end');
%%%       temp4=find(strcmp(funstr{i}(nextNonSpace(funstr{i},funstrwords_e{i}(temp1))),'*'));
%%%       temp3=find(isspace(funstr{i}));
%%%       temp3=temp3(temp3>temp4);
%%%       temp2=temp3(1)-1;
       if isempty(temp2)
        temp2=find(isspace(funstr{i})); temp2=temp2(temp2>funstrwords_e{i}(temp1));
       end
       temp2=temp2(1);
      end % if 
     else % deal with character()
      ;% must be a kind declaration or a character length, deal with later
      if ~strcmp(funstrwords{i}{temp1},'data') && ~strcmp(funstrwords{i}{temp1},'parameter')
       temp2=parens(2);
      end
%%%      if strcmp(funstrwords{i}{temp1},'character')
%%%       temp2=parens(2);
%%%      end
      
%%%     else
%%%     elseif ~(~isempty(temp5) && any(~cellfun('isempty',strfind(subscripts,'='))) && howmany>2)% no imp do loops in a data statement to mess this up
%%%      temp2=parens(2);
     end
     temp5=find(strcmp(funstrwords{i},'parameter'));
     if ~isempty(temp5) %parameter, but no ::, so take away () if there
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp5,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if howmany>0
       funstr{i}(parens)=' ';
       [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      end
     end
%%%    if any(strcmp(funstrwords{i},'days_in_month'))
%%%     'tttttttttttttttttttt1',temp2,funstr{i},keyboard
%%%    end
     temp5=find(strcmp(funstrwords{i},'common')|strcmp(funstrwords{i},'save'));
     if ~isempty(temp5) %get rid of labels
      goon=1;
      temp6=find(funstr{i}=='/');
      if ~isempty(temp6)
       for j=1:2:length(temp6)
        funstr{i}(temp6(j):temp6(j+1))=[',',repmat(' ',1,temp6(j+1)-temp6(j))];
       end % for j=1:2:length(temp6)
       [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      end
     end
    else
     fid='';
    end
    %now get the top level commas
    [temp3,temp4,temp5]=getTopLevelStrings(funstr{i},temp2,',',i,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
    [temp6]=getTopLevelStrings(funstr{i},temp2,'/',i,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
    for ii=length(temp3):-1:1
     if temp3(ii)<temp2 || (goon && mod(length(find(temp6<temp3(ii))),2)==1)
      temp3=[temp3(1:ii-1),temp3(ii+1:end)];
     end
    end
    temp3=temp3(temp3>temp2);
    %separate them
    temp3=[temp2,temp3,length(funstr{i})+1];
    tempstr=cell(length(temp3)-1,1);
    for ii=1:length(temp3)-1
     tempstr{ii}=[funstr{i}(1:temp2),' ',fid,funstr{i}(temp3(ii)+1:temp3(ii+1)-1),';'];
    end % for ii=1:length(temp3)-1
%%%    if any(strcmp(funstrwords{i},'days_in_month'))
%%%     'tttttttttttttttttttt',temp2,funstr{i},tempstr,keyboard
%%%    end
    [funstr{i+length(tempstr):end+length(tempstr)-1}]=deal(funstr{i+1:end});
    [funstr{i:i+length(tempstr)-1}]=deal(tempstr{:});
   end
  end % if ~isempty(funstrwords{i})
 catch
  numErrors=numErrors+1;
  disp('problem with separating out all variable declarations in the following line:')
  warning(funstr{i})
 end
end
[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);

almil=~cellfun('isempty',regexp(funstr,'(Alan Miller)|(Date: 200)'));


%'iiiiiiiiiiiii33',funstr,keyboard

%sometimes data statements don't have the "data" part, just slashes
% detect this and add "data" by 0. has slashes, 1. no "common, 2. no "data",
%  3. no ( or ) before slashes
for i=fliplr(fs_good)
 if ~isempty(funstrwords{i})
  temp=any(strcmpi(funstrwords{i}{1},{var_words{:},type_words{:}}));
  if temp
   temp1=find(funstr{i}=='/');
   if ~isempty(temp1) && length(temp1)/2==floor(length(temp1)/2)
    %funstr{i},'jjjjjjjjjjj',kb
    if ~any(funstr{i}(temp1-1)=='(') || ~any(funstr{i}(temp1+1)==')')
     if ~any(strcmp('common',funstrwords{i})) && ~any(strcmp('data',funstrwords{i}))
      if any(~incomment(funstr{i},temp1)) || any(~inastring_f(funstr{i},temp))
       %funstr{i},'jjjjjjjjjjj',kb
       funstr{i}=['data ',funstr{i}];
       [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      end % if any(~incomment(funstr{i},
     end % if ~any(strcmp('common',
    end % if ~any(funstr{i}(temp1-1)=='(') || ~any(funstr{i}(temp1-1)==')')
   end % if ~isempty(temp1)
  end % if temp
 end % if ~isempty(funstrwords{i})
end % for i=fliplr(fs_good)



%So, now we start the macros to changeover.
funargs=[]; fundecline=[];
temp3=fs_good(1);
for i=fs_good
 try
  temp=find(strcmpi(this_fun_name,funstrwords{i}));
  if ~isempty(temp)
   if ~inastring_f(funstr{i},funstrwords_b{i}(temp(1)))
    if any(strcmpi('end',funstrwords{i}))
%%%     funstr{i}='end';
    else
     if (sum(length(find(strcmpi(type_words{1},funstrwords{i}))))+sum(length(find(strcmpi(type_words{2},funstrwords{i}))))+sum(length(find(strcmpi(type_words{3},funstrwords{i})))))>0
      temp3=i;
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp(1),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      temp9='';
      
      % This is preempted by the assignin functionality added
      if howmany>0
       temp9=[',',funstr{i}(parens(1)+1:parens(2)-1)];
      end
      
      if any(strcmpi('function',funstrwords{i}))
       %This is a FUNCTION declaration
       suborfun(whichsub)=2;
       if any(strcmpi('result',funstrwords{i}))
        %Has a result specifier
        temp1=find(strcmpi('result',funstrwords{i}));
        localVar=insertLocalVar(localVar,funstrwords{i}{temp1+1},'result',1);
        funstr{i}=['function [',funstrwords{i}{temp1+1},temp9,']=',funstr{i}(funstrwords_b{i}(2):funstrwords_b{i}(temp1)-1)];      
        %funstr{i}=['function [',funstrwords{i}{temp1+1},']=',funstr{i}(funstrwords_e{i}(temp1)+1:end)];      
       else
        %No result specifier for function
        funstr{i}=['function [',funstrwords{i}{temp},temp9,']=',funstr{i}(funstrwords_b{i}(temp):end)];
       end
      else
       %PROGRAM or SUBROUTINE declaration
       suborfun(whichsub)=1;
       if length(funstrwords{i})>temp(1)
        funstr{i}=['function [',funstr{i}(funstrwords_b{i}(temp(1)+1):funstrwords_e{i}(end)),']=',this_fun_name,funstr{i}(funstrwords_e{i}(temp(1))+1:end)];
       else
        funstr{i}=['function ',funstr{i}(funstrwords_b{i}(temp(1)):funstrwords_e{i}(temp(1)))];
       end
      end
      %'wwwwwwwwwww11',funstr{i},keyboard
      temp6=find(funstr{i}==')');
      temp7=',';
      %if this function has no args, then don't need a comma
      if ~isempty(temp6)
       temp8=find(~isspace(funstr{i}));
       temp8=temp8(temp8<temp6(end));
       if funstr{i}(temp8(end))=='('
        %if strcmp(funstr{i}(temp6(end)-1),'(')
        temp7='';
       end
       temp9=''; if want_vai, temp9='varargin'; end
       funstr{i}=[funstr{i}(1:temp6(end)-1),temp7,temp9,funstr{i}(temp6(end):end)];
      else
       [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
       funstr{i}=[funstr{i}(1:funstrwords_e{i}(end)),'(varargin)',...
                  funstr{i}(funstrwords_e{i}(end)+1:end)];
      end % if ~isempty(temp6)
      %'wrrrrrrrrrrrr',funstr{i},kb
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      temp2=findstr(funstr{i},']');
      if ~isempty(temp2)
       temp=find(funstrwords_b{i}>temp2(end));
       if ~isempty(temp)
        temp=funstrwords_b{i}(temp(1));
        temp1=find(funstrwords_b{i}>temp(1));
       else
        temp1=[];
       end
      else
       temp=[];temp1=[];
      end
      funargs=temp1;
      fundecline=i;
     end
    end
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
   end
  end
 catch
  numErrors=numErrors+1;
  disp('problem with some preliminary analysis')
  warning(funstr{i})
 end
end

%if strcmp(this_fun_name,'mtu12'),'reeeeeeee444444442',funstr,keyboard,end
%'wwwwwwwwwww',funstr,keyboard


temp5=cell(0); %list of vars that will be taken from var list at the end unless protected
goon=[]; %list of lines to take out
goon2=0; %comment this line if goon2 is 1
goonimag=1; %last line of var decs
for i=fliplr(fs_good)
 %localVar,i,funstr{i}
%%% try
  % just pass through the var decs finding out all we can
 if ~isempty(funstrwords{i})
  temp9=length(funstrwords{i})>1 && (strcmpi(funstrwords{i}{2},'type') && strcmpi(funstrwords{i}{1},'end'));
   if (any(strcmpi(funstrwords{i}{1},var_words))||temp9)&&...
        (~any(strcmpi('function',funstrwords{i})))
    goonimag=max(goonimag,i);
    if temp9,  temp1=funstrwords_e{i}(2); else, temp1=strfind(funstr{i},'::'); end
    fixEndType
    temp2=find(funstrwords_b{i}>temp1);
    % has to be the first word in the line
    %if temp9, funstr{i},'bbbbbbbbbb',kb,end
    if ~isempty(temp2)
     temp2=temp2(1); %variable location
                     % go through all the words before this and add info as appropriate
%%%    goon=1; %add this to localVar after the loop, 0=>don't
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp2,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     for j=temp2-1:-1:1
      switch funstrwords{i}{j}
       case {'real','complex','integer','logical'}
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'type',funstrwords{i}{j});
        % don't let them decalre nargs
        if strcmp('nargs',funstrwords{i}{end})
         funstr{i}=['% ',funstr{i}];
        end
        %'sssssssssssssss',localVar,funstr{i},kb
       case 'character'
        [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
        [localVar,temp7]=insertLocalVar(localVar,funstrwords{i}{temp2},'type',funstrwords{i}{j});
        if howmany2>0
         temp8=strrep(regexprep(subscripts2{1},'.+=',''),' ',''); %take away the :"len="
         if ~strcmp('*',temp8) %could be (len=*)
          localVar{temp7,2}=temp8;
         else
          % then it must be an input or something
          %localVar{temp7,13}=1;
         end
         %if isempty(localVar{temp7,5}), localVar{temp7,5}={'1'}; end
        elseif howmany2==0
         localVar{temp7,2}='1'; 
         %if isempty(localVar{temp7,5}), localVar{temp7,5}={'1'}; end
        end
        %may have a *len there on the character
        fid=regexp(funstr{i},'character\*(\w+)','tokens');
        if ~isempty(fid)
         localVar{temp7,2}=fid{1}{1};
        end
        %may have a *(len) there on the character (note added parentheses)
        fid=regexp(funstr{i},'character\*\s*\((\w+)\s*\)','tokens');
        if ~isempty(fid)
         localVar{temp7,2}=fid{1}{1};
        end
        %may have a *len there on the variable itself
        fid=regexp(funstr{i},[funstrwords{i}{temp2},'\*(\w+)'],'tokens');
        if ~isempty(fid)
         localVar{temp7,2}=fid{1}{1};
        end
        %may have a *(len) there on the variable itself (note added parentheses)
        fid=regexp(funstr{i},[funstrwords{i}{temp2},'\*\s*\((\w+)\s*\)'],'tokens');
        if ~isempty(fid)
         localVar{temp7,2}=fid{1}{1};
        end
       case 'implicit'
        goon=[goon,i]; break
       case 'intrinsic'
        goon=[goon,i]; 
        temp5={temp5{:},funstrwords{i}{temp2}};
        break
       case 'dimension'
        [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
        if howmany2>0
         localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'extents',subscripts2);
        end
       case 'common'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'common',1);
       case {'double','precision','doubleprecision'}
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'type','real');
       case 'intent'
        [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
        temp4=subscripts2{1}(~isspace(subscripts2{1}));
        if ~isempty(findstr(temp4,'in'))
         if ~isempty(findstr(temp4,'out'))
          localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'intent',3);
         else
          localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'intent',1);
         end
        else
         localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'intent',2);
        end
       case 'allocatable'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'alloc',1);
       case 'pointer'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'alloc',1);
       case 'target'
       case 'equivalence' %can anything be done for these?
        goon=[goon,i]; 
        break
       case 'external'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'external',1);
        temp5={temp5{:},funstrwords{i}{temp2}};
        goon=[goon,i]; break
       case 'parameter'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'param',1);
       case 'save'
%%%       funstr{i},'lllllll',kb
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'save',1);
       case 'automatic'
       case 'private'
       case 'public'
       case 'static'
       case 'optional'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'optional',1);
       case 'volatile'
       case 'data'
        localVar=insertLocalVar(localVar,funstrwords{i}{temp2},'data',1);
       case 'type'
        %'ddddddddddddddddddddddd',funstr{i},kb
        takeCareOfTypes
      end
      %'freeeeeeeeee',funstr{i},funstrwords{i}{temp2},kb
     end % for j=1:temp2-1
         %can't allow this function to be a var
     if strcmp(funstrwords{i}{temp2},this_fun_name), goon=[goon,i]; end
     if ~any(goon==i)
      if howmany>0 %|| ~isempty(localVar{fid,2}) || ~isempty(localVar{fid,5})
                   %if isempty(localVar{fid,2}) && isempty(localVar{fid,5})
       [localVar,temp7]=insertLocalVar(localVar,funstrwords{i}{temp2},'extents',subscripts);
      end
     else
     end
%%%    if any(strcmp(funstrwords{i},'sum'))
%%%     '[[[[[[[[[44444444444',funstr{i},funstrwords{i}{temp2},localVar,temp5,kb
%%%    end   
     if goon2,
      funstr{i}=['%%% ',funstr{i}];
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
     end
    else
     if temp9
      funstr{i},error('you must help the type name in this line, not just ''end type'' only');
     end
    end % if ~isempty(temp2)
   else
    %break % break out of loop because we are done with variable declarations
   end % if (any(strcmpi(funstrwords{i}{1},
  end % if ~isempty(funstrwords{i})
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with assigning size of local variables')
%%%  warning(funstr{i})%,kb
%%% end
end

% if want_pst is set, make all the local vars default to save attribute
%localVar
for i=1:size(localVar,1)
 if all(cellfun('isempty',{localVar{i,[4,6,7,9:13,15]}}))
  %'fn----------',kb
  localVar=insertLocalVar(localVar,localVar{i,1},'save',1);
 end
end


% Change all the local vars that have the same var name as a var in any module to have MPstr if want_MP is set.
% This is in possible prep to have all the other functions be nested.
% this version only changes everything in the main program
if want_MP && ~subfun && ~ismod
 if                                                                                                 ~ismod
  temp2={};
  for i=1:size(modLocalVar,1)
   temp2={temp2{:},modLocalVar{i,2}{:,1}};
  end
  temp1=1;
  if ~subfun
   for i=2:size(localVar,1)
    if length(localVar{i,1})>1 %any(strcmp(localVar{i,1},temp2)) & isempty(localVar{i,13})
     funstr=regexprep(funstr,['\<',localVar{i,1},'\>'],[localVar{i,1},MPstr{temp1}]);
     localVar{i,1}=[localVar{i,1},MPstr{temp1}];
    end
   end
  end
 end
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
end
%'finnnn',localVar,temp5,kb

%%%% Change all the local vars that have the same var name as a var in any module to have MPstr if want_MP is set.
%%%% This is in possible prep to have all the other functions be nested.
%%%if want_MP && ~subfun && ~ismod
%%% if ~ismod
%%%  temp2={};
%%%  for i=1:size(modLocalVar,1)
%%%   temp2={temp2{:},modLocalVar{i,2}{:,1}};
%%%  end
%%%  temp1=1;
%%%  if ~subfun
%%%   for i=2:size(localVar,1)
%%%    if any(strcmp(localVar{i,1},temp2)) & isempty(localVar{i,13})
%%%     funstr=regexprep(funstr,['\<',localVar{i,1},'\>'],[localVar{i,1},MPstr{temp1}]);
%%%     localVar{i,1}=[localVar{i,1},MPstr{temp1}];
%%%    end
%%%   end
%%%  end
%%% end
%%% [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
%%%end
%%%%'finnnn',localVar,temp5,kb

%%%%%%%%% this tries to do both main and local
%%%% Change all the local vars that have the same var name as a var in any module to have MPstr if want_MP is set.
%%%% This is in possible prep to have all the other functions be nested.
%%%if want_MP% && ~subfun && ~ismod
%%% if ~ismod
%%%  temp2={};
%%%  for i=1:size(modLocalVar,1)
%%%   temp2={temp2{:},modLocalVar{i,2}{:,1}};
%%%  end
%%%  %'reeeeeeeeeee',kb
%%%  if subfun, temp1=2; else temp1=1; end
%%%  for i=2:size(localVar,1)
%%%   if any(strcmp(localVar{i,1},temp2)) & isempty(localVar{i,13})
%%%    funstr=regexprep(funstr,['\<',localVar{i,1},'\>'],[localVar{i,1},MPstr{temp1}]);
%%%    localVar{i,1}=[localVar{i,1},MPstr{temp1}];
%%%   end
%%%  end
%%% end
%%% [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
%%%end
%%%%'finnnn',localVar,temp5,kb

%the "external" declared words are
extwords=localVar(find(~cellfun('isempty',localVar(:,12))),1).';
commonvars=localVar(find(~cellfun('isempty',localVar(:,4))),1).';
% remove all the function arguments
if ~ismod
 temp1=1;
 for i=1:length(funstrwords{fundecline}(funargs))
  if ~strcmp(funstrwords{fundecline}(funargs(i)),'varargin')
   fid=find(strcmp(funstrwords{fundecline}(funargs(i)),{localVar{:,1}}));
   if ~isempty(fid)
    %'finnnn11',localVar,temp5,kb
    localVar=insertLocalVar(localVar,funstrwords{fundecline}{funargs(i)},'input',temp1);
    temp1=temp1+1;
   end % if ~isempty(fid)
  end
 end
end
%remove the flagged words
for i=1:length(temp5)
 localVar=remLocalVar(localVar,temp5{i});
end







%don't allow other functions to be local variables unless they have no extents
%or are used with no args outside a subroutine or function call (main level)
temp1={fun_name{:},funwords{:}};
for i=size(localVar,1):-1:1
 goon=1;
 % if it is a fun_name, then it must be removed
 if any(strcmp(localVar{i,1},fun_name))
  goon=0; 
 end
 %if      isempty(localVar{i,5})       &&      isempty(localVar{i,6})      &&      isempty(localVar{i,8})
%%%         if        strcmpi(this_fun_name,'get_domain_data_start_d_date')         &&         ...        
%%%      strcmpi(localVar{i,1},'domain_day_to_date')
%%%  localVar(i,:),kb
%%% end
 if goon
  if (any(strcmp(localVar{i,1},temp1)) && isempty(localVar{i,5})) || ...
       ( isempty(localVar{i,5}) && isempty(localVar{i,6}) && isempty(localVar{i,8}) )
%%%  if any(strcmp(localVar{i,1},temp1)) || ...
%%%       ( isempty(localVar{i,5}) && isempty(localVar{i,6}) && isempty(localVar{i,8}) )
%%%  if any(strcmp(localVar{i,1},temp1)) || ...
%%%       ( (isempty(localVar{i,5}) && ~strcmp(localVar{i,3},'character')) && ...
%%%         isempty(localVar{i,6}) && isempty(localVar{i,8}) )
   for j=fliplr(fs_good)
%scan the file, if on lhs of eq, then is a var, if has subscripts (>1 for chars), is not a var
    if length(funstrwords{j})>0
     foo=find(strcmp(funstrwords{j},localVar{i,1}));
     % apparently data statements can appear anywhere?
     if ~any(strcmp(funstrwords{j}{1},var_words)) || strcmp(funstrwords{j}{1},'data')
      for ii=1:length(foo)
%%%       if any(strcmpi(localVar{i,1},'sum'))
%%%        '[[[[[[[[[444444444441',funstr{j},localVar(i,:),j,kb
%%%       end        
       [howmany,subscripts,centercomma,parens]=hassubscript_f(j,foo(ii),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
       if strcmp(localVar{i,3},'character')
        if howmany>1
         goon=0; break;
        end
       else
        if ~isempty(parens), goon=0; break; end %function because no declared subscript
       end
%%%      [outflag2,howmany2,subscripts2,centercomma2,parens2]=inwhichlast_f(j,funstrwords_b{j}(foo(ii)),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
%%%      if outflag2==1
%%%       temp6=find(~isspace(funstr{j}));
%%%       temp7=find(temp6(find(temp6<parens2(1),1,'last'))==funstrwords_e{j});
%%%       if ~isempty(temp7)
%%%        if any(strcmp(funstrwords{j}{temp7},fun_name))
%%%         goon=0;
%%%         break
%%%        end
%%%       end
%%%      end
      end
     else
      break
     end
    end % if length(funstrwords{i})>0
   end
  end
 end
 if ~goon %remove this one
  localVar=remLocalVar(localVar,localVar{i,1});
 end
end
% change all empties to 0's, not sure I want to do this
% [localVar{cellfun('isempty',localVar)}]=deal(0);

%add module variables to the localVar
[localVar,origLocalVar]=addVars(localVar,modLocalVar,usedMods,modUsedMods);
%'smack,smack,meback',funstr,localVar,kb




%%%
%%%%add module variables to the localVar
%%%if ~isempty(usedMods)
%%% for i=1:length(usedMods)
%%%  [localVar{size(localVar,1)+1:size(localVar,1)+size(modLocalVar{usedMods(i),2},1),:}]=deal(modLocalVar{usedMods(i),2}{:,:});
%%% end % for i=1:length(usedMods)
%%%end % if ~isempty(usedMods)
%%% 

%replace funwordsML that have been deemed to be localVar's to add MLapp on the end
for i=1:size(localVar,1)
 if any(strcmp(localVar{i,1},funwordsML))
  % then switch
  funstr=regexprep(funstr,['\<',localVar{i,1},'\>'],[localVar{i,1},MLapp]);
  localVar{i,1}=[localVar{i,1},MLapp];
 end % if any(strcmp(localVar{i,
end % for i=1:size(localVar,

%%%  %put in struct definitions for derived types
temp=size(typeDefs,1);
tempstr=cell(1,1);
for i=1:temp
 tempstr{1}=['global ',typeDefs{i,1},'; ',typeDefs{i,1},'=',buildTypeDefLine(typeDefs,i,var_words,want_row),';'];
 % where does this go? the word type with no subscript and this typename
 %tempstr,'ooooooooo',kb
 goonimag=1;
 temp1=regexp(funstr,['\<type\>']);
 temp2=find(~cellfun('isempty',temp1));
 temp3=regexp(funstr,['\<',typeDefs{i,1},'\>']);
 temp4=find(~cellfun('isempty',temp3));
 temp5=intersect(temp2,temp4);
 if isempty(temp5)
  error('where is the type defined?')
 else
  goonimag=min(temp5);
 end
 funstr(goonimag+1+1:end+1)=funstr(goonimag+1:end);
 funstr(goonimag+1)=tempstr; 
end

%'treeeeeeeeeeee',funstr,kb

%%%%%%  %put in struct definitions for derived types
%%%temp=size(typeDefs,1);
%%%tempstr=cell(temp,1);
%%%for i=1:temp
%%% tempstr{temp-i+1}=[typeDefs{i,1},'=',buildTypeDefLine(typeDefs,i,var_words,want_row),';'];
%%%end
%%%tempstr,'ooooooooo',kb
%%%goonimag=1;
%%%funstr(goonimag+temp+1:end+temp)=funstr(goonimag+1:end);
%%%funstr(goonimag+1:goonimag+temp)=tempstr;

%add modTypeDefs to typeDefs
if ~isempty(usedMods)
 for i=1:length(usedMods)
  for j=1:size(modTypeDefs{usedMods(i),2},1)
   typeDefs{size(typeDefs,1)+1,1}=modTypeDefs{usedMods(i),2}{j,1};
   typeDefs{size(typeDefs,1)  ,2}=modTypeDefs{usedMods(i),2}{j,2};
  end % for j=1:size(modTypeDefs{usedMods(i),
 end % for i=1:length(usedMods)
end % if ~isempty(usedMods)

%we want to add any new type defs to allTypeDefs
for i=1:size(typeDefs,1)
 temp1=find(strcmp(typeDefs{i,1},{allTypeDefs{:,1}}));
 if isempty(temp1)
  allTypeDefs{size(allTypeDefs,1)+1,1}=typeDefs{i,1};
  allTypeDefs{size(allTypeDefs,1)  ,2}=typeDefs{i,2};  
 end
end

%'kkkkkkkkkkkk',typeDefs,allTypeDefs,funstr,kb


%Let's take care of the % => . for the type=>structs
for i=1:size(typeDefs,1)
 for j=1:size(typeDefs{i,2})
  %'...............2',typeDefs{i,2}{j,1},kb
     funstr=regexprep(funstr,['[\)\w ]%\s*',typeDefs{i,2}{j,1},'\>'],['\.',typeDefs{i,2}{j,1}]);
 end % for j=1:size(typeDefs{i,
end % for i=1:size(typeDefs,


[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);

%%%if strcmpi(this_fun_name,'set_sos_constraints')
%%% '81234444444444',ismod,localVar,kb
%%%end

%now take care of the type data statements like pipe(4.5,44.8,1200,"turbulent") 
%  unless they are part of the definition of that struct!
for i=1:size(typeDefs,1)
 temp=regexp(funstr,['\<',typeDefs{i,1},'\>']);
 temp1=find(~cellfun('isempty',temp));
 for j=1:length(temp1)
  for k=1:length(temp{temp1(j)})
   if validSpot(funstr{temp1(j)},temp{temp1(j)}(k))
    temp2=find((funstrwords_b{temp1(j)}==temp{temp1(j)}(k)));
    [howmany,subscripts,centercomma,parens]=hassubscript_f(temp1(j),temp2,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    if howmany==(size(typeDefs{i,2},1)-1)
     [outflag,whichword,whichsub,howmany,subscripts,centercomma,parens]=insubscript_f(temp1(j),funstrwords_b{temp1(j)}(temp2),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     %'dfdfdfdfd',funstr{temp1(j)},kb
     goonimag=1;
     if ~isempty(whichword) && strcmpi('struct',funstrwords{temp1(j)}{whichword})
      goonimag=0;
     end
     if goonimag
      tempstr='';
      for goon=1:howmany
       if goon==howmany, temp3='';,else, temp3=','; end
       tempstr=[tempstr,'''',typeDefs{i,2}{howmany+1+1-goon,1},''',',subscripts{goon},temp3];
      end % for goon=1:howmany
      funstr{temp1(j)}=[funstr{temp1(j)}(1:funstrwords_b{temp1(j)}(temp2)-1),'struct(',tempstr,funstr{temp1(j)}(parens(2):end)];
%%%  funstr{temp1(j)}=[funstr{temp1(j)}(1:parens(1)),tempstr,funstr{temp1(j)}(parens(2):end)];
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,temp1(j));
      %if ~ismod && strcmp('pipe2',typeDefs{i,1}),'000000000000',funstr{temp1(j)},kb,end
     end % if goonimag
    end % if howmany==size(typeDefs{i,
   end % if ~inastring_f(funstr{temp1(j)},
  end % for k=1:length(temp(temp1(j))
 end % for j=1:length(temp1)
end % for i=1:size(typeDefs, 


%'intttttttttttt',funstr,kb

%remove word= from intrinsic calls and dealing with optional args
tempstr={funwords{:},fun_name{:},sublist_all{:,1}};
for i=fs_good
%%% try
  for j=length(funstrwords{i}):-1:1
   fid=[]; %[optional args that this fun_name has, where is it called]
   temp1=find(strcmp(funstrwords{i}{j},tempstr));
%%%   if strcmp(funstrwords{i}{j},'deallocate') && any(strcmp(funstrwords{i},'x'))
%%%    'ppppppppppp',funstr{i},kb
%%%   end
   temp4=lastNonSpace(funstr{i},funstrwords_b{i}(j));
   %if ~isempty(temp1)
   if ~isempty(temp1) || (j==2 && strcmp(funstrwords{i}{1},'call')) || (temp4&&funstr{i}(temp4)=='=')
    [howmany,subscripts,centercomma,parens]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    if howmany>0
     centercomma=[parens(1),centercomma,parens(2)];
     for ii=length(centercomma)-1:-1:1
      temp2=find(subscripts{ii}=='=');
      %temp2=find(funstr{i}(centercomma(ii):centercomma(ii+1))=='=');
      if ~isempty(temp2)
       if ~inastring_f(funstr{i},centercomma(ii)+temp2(1))
        if ~any(ismember(funwordsNoRemoveEq,funstrwords{i}))
         [outflag,howmany2,subscripts2,centercomma2,parens2]=inwhichlast_f(i,centercomma(ii)+temp2(1),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
         if parens2(1)==parens(1)
          if ~any(strcmp(fun_name,funstrwords{i}{j}))
           funstr{i}=[funstr{i}(1:centercomma(ii)),funstr{i}(centercomma(ii)+temp2(end)+1:end)];
           [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
          else % this is a fun_name, and has optional args
           temp7=find(funstrwords_b{i}<centercomma(ii)+temp2(1),1,'last');
           temp8=find(strcmp(funstrwords{i}{j},{sublist_all{:,1}}));
           if ~isempty(temp7) && ~isempty(temp8)
            temp8=temp8(1);
            temp9=find(strcmpi({sublist_all{temp8,8}{:}},funstrwords{i}{temp7})); %which subscript is this optional arg?
            if ~isempty(temp9)
             fid=[fid;temp9,ii];
             subscripts{ii}=subscripts{ii}(temp2(1)+1:end);
            end
           end
          end % if ~any(strcmp(fun_name,
         end % if parens2(1)==parens(1)end
        end % if ~any(ismember(funwordsNoRemoveEq,
       end % if ~inastring_f(funstr{i},
      end % if ~isempty(temp2)s
     end % for ii=length(centercomma)-1:-1:1
%%%if strcmpi(this_fun_name,'gettargetdata') & any(strcmp(funstrwords{i},'compute_portwgts_from_taxlots'))
%%% '81234444444444',ismod,localVar,kb
%%%end
     if ~isempty(fid)
      %rebuild the function/subroutine call
      temp0='';
      for k=min(fid(:,2)):max(fid(:,1))
       if any(fid(:,1)==k)
        temp6=find(fid(:,1)==k);
        temp0=[temp0,',',subscripts{fid(temp6,2)}];
       else
        temp0=[temp0,',[]'];
       end
      end
      funstr{i}=[funstr{i}(1:centercomma(min(fid(:,2)))-1),temp0,funstr{i}(parens(2):end)];
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      %'sssssssssssss',funstr{i},funstrwords{i}{j},fid,subscripts,temp0,kb
     end % if ~isempty(fid)
    end % if howmany>0
   end % if ~isempty(temp1)
  end % for j=length(funstrwords{i}):-1:1
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with removing <word>= in the following line')
%%%  warning(funstr{i})%,kb
%%% end
end % for i=fs_good

%funstr,'ccccccccccccccc434343',kb


% we have to catch statement functions now
for i=fs_good
 try
  temp=find(funstr{i}=='=');
  if ~isempty(temp)
   temp=temp(1);
   temp1=find(funstrwords_b{i}<temp);
   if ~isempty(temp1)
    if ~any(strcmp(funstrwords{i}{1},{keywordsbegin{:},funwords{:},var_words{:}}))
     %OK test first word for subscripts when declaration says it should have none
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if howmany>0
%%%     if strcmp(funstrwords{i}{1},'gam')
%%%      'dddddd=-0',funstr{i},keyboard
%%%     end
      temp2=find(strcmp(funstrwords{i}{1},{localVar{:,1}}));
      goon=0;
      if ~isempty(temp2) %found this var in localVar
       if ~ischar(localVar{temp2,2}) && length(localVar{temp2,5})==0 && ~strcmp(localVar{temp2,3},'character')%&& ~strcmp(localVar{temp2,3},'string')
        goon=1;
       end % if localVar{temp2,
      else
       goon=1;
      end % if ~isempty(temp2)
      ;%if ~(the last statement was a statementFunction or had a var_word), then don't
      if ~(any(fs_good(find(i==fs_good)-1)==statementFunctionLines) | ...
           any(ismember(funstrwords{fs_good(find(i==fs_good)-1)},{var_words{:},'data'})) |...
           strcmp(funstrwords{fs_good(find(i==fs_good)-1)}{1},'function'))
       goon=0;
       %'ggggggggggg',funstr{i},keyboard
      end
      % or was a "data"
      if strcmpi(funstrwords{i}{1},'data')
       goon=0;
      end
      %not if its an input variable
      if ~isempty(funargs)
       if ~(~any(strcmpi(funstrwords{i}{1},{funstrwords{fundecline}{funargs}})))
        goon=0;
       end
      end
      if goon
       % we have a statement function (??)
       statementFunction{length(statementFunction)+1}=funstrwords{i}{1};
       statementFunctionLines=[statementFunctionLines,i];
       funstr{i}=['function ',funstrwords{i}{1},'=',...
                  funstr{i}(funstrwords_b{i}(1):parens(2)),', ',...
                  funstrwords{i}{1},'=',funstr{i}(temp+1:end),' end'];
       [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      end
      
     end % if howmany>0
    end % if ~any(strcmp(funstrwords{i}{1},
   end % if ~isempty(temp1)
  end % if ~isempty(temp)
 catch
  numErrors=numErrors+1;
  disp('problem with converting statement functions in the following line')
  warning(funstr{i})%,kb
 end
end % for i=fs_good

%'daaaaaaaaaaaaa',funstr,kb

%%%%%%%%%%% let's see if there are any <1 indices
% varp{n,1:3}, varp{n,1} => var name, varp{n,2} => which subscripts
%              varp{n,3} => increment for each sub
%Try to find zero and - indexed variables
try
 varp=cell(0);
 for i=1:size(localVar,1)
  if iscell(localVar{i,5})
   for j=1:length(localVar{i,5})
    temp4=strfind(localVar{i,5}{j},':');
    if ~isempty(temp4)
     temp1=str2num(localVar{i,5}{j}(1:temp4(1)-1));
     if ~isempty(temp1) && temp1==0 % found a 0
      if ~any(strcmpi(localVar{i,1},{varp{:,1}}))
       varp{end+1,1}=localVar{i,1};
       varp{end,2}=j;
       varp{end,3}=1;
      else
       temp5=find(strcmpi(localVar{i,1},{varp{:,1}}));
       varp{temp5,2}=unique([varp{temp5,2},j]);
       varp{temp5,3}=[varp{temp5,3},1];
      end
     end
     if ~isempty(temp1) && temp1<0 % found a -#
      if ~any(strcmpi(localVar{i,1},{varp{:,1}}))
       varp{end+1,1}=localVar{i,1};
       varp{end,2}=j;
       varp{end,3}=abs(temp1)+1;
      else
       temp5=find(strcmpi(localVar{i,1},{varp{:,1}}));
       varp{temp5,2}=unique([varp{temp5,2},j]);
       varp{temp5,3}=[varp{temp5,3},abs(temp1)+1];
      end
     end
    end % if ~isempty(temp4)
%%%   if (strcmp('adif',localVar{i,1}))
%%%    localVar{i,:},varp,'diffffffff',kb
%%%   end     
   end % for j=1:length(localVar{i,
  end % if iscell(localVar{i,
 end % for i=1:size(localVar,
catch
 numErrors=numErrors+1;
 disp('problem with finding <1 starting indices')
end


%Add on modVarp as needed
if ~ismod
 if ~isempty(usedMods)
  for i=usedMods(:).'
   varp=[varp;modVarp{i,2}];
  end % for usedMods(:).
 end % if ~isempty(usedMods)
end % if ~ismod
 
%'7777777777777777',funstr,varp,keyboard


%Get any parameter declarations and remove var declaration and dimensioning
temp=ones(s,1); %whether to keep this line at all
                %lines to add varPrefix to (so later routines know this is a var dec line)
filestr=zeros(1,s);
tempstr=zeros(size(localVar,1),1); %whether this var has been dealt with or not.
for i=(fs_good)
%%% try
  if ~isempty(funstrwords{i})
   if (any(strcmpi(funstrwords{i}{1},var_words)))&&(~any(strcmpi('function',funstrwords{i})))
    temp1=strfind(funstr{i},'::');
    temp2=find(funstrwords_b{i}>temp1); 
%%%    if (strcmp('first_time',funstrwords{i}{temp2(1)}))
%%%     '----------------ssss',funstr{i},temp3,temp5,kb
%%%    end
    if ~isempty(temp2)
     temp2=temp2(1); %variable location
     fid=find(strcmp(funstrwords{i}{temp2},{localVar{:,1}}));
     if isempty(fid)||...  %then bag it, not a local var         
          tempstr(fid)||... %then bag it, this has been dealt with already,
          ~isempty(localVar{fid,13}) %if it is an input var, then don't try to do anything
      temp(i)=0;
     end
     %but data statements with slashes get to go through
     temp10=0;
     if ~isempty(fid) && ~isempty(localVar{fid,6}) && ...
          ~isempty(find(funstr{i}(funstrwords_e{i}(temp2)+1:end)=='/'))
      temp(i)=1;     temp10=1;
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%deal with the * in some inputs
     temp9=1;
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp2,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);

%%%     if strcmp(funstrwords{i}{temp2},'sum')
%%%      funstr{i},'mmmmmmmmmm',temp9,fid,temp(i),i,kb
%%%     end
     
     if ~isempty(fid) && ~isempty(localVar{fid,13}) && ~isempty(localVar{fid,5}) && ...
          ( (howmany>0 && any(strcmp(strtrim(localVar{fid,5}),'*'))) ||...
            any(strcmp(strtrim(localVar{fid,5}),':')))
%%%     any(~cellfun('isempty',strfind(localVar{fid,5},'*')))
      temp(i)=1;     temp9=0;
      if length(localVar{fid,5})==1
       if want_row,        temp8='1,[]';       else,        temp8='[],1';       end
       if want_smm
        funstr{i}=[funstrwords{i}{temp2},shapeVar,'=shape(',funstrwords{i}{temp2},');',...
                   funstrwords{i}{temp2},'=reshape(',funstrwords{i}{temp2},',',temp8,');'];
        needRS={needRS{:},funstrwords{i}{temp2}};
       else
        funstr{i}=[funstrwords{i}{temp2},'=reshape(',funstrwords{i}{temp2},',',temp8,');'];
       end
      else
       if want_smm
        if (howmany>0 && any(strcmp(strtrim(localVar{fid,5}),'*')))
         temp6=funstr{i}(parens(1)+1:centercomma(end)-1);
         funstr{i}=[funstrwords{i}{temp2},shapeVar,'=shape(',funstrwords{i}{temp2},');',...
                    funstrwords{i}{temp2},'=reshape(',funstrwords{i}{temp2},...
                    '(1:floor(numel(',funstrwords{i}{temp2},')/prod([',temp6,']))',...
                    '*prod([',temp6,'])),prod([',temp6,']),[]);'];
%%%       funstr{i}=[funstrwords{i}{temp2},'=reshape(',funstrwords{i}{temp2},...
%%%                  '(1:floor(numel(',funstrwords{i}{temp2},')/prod([',temp6,']))',...
%%%                  '*prod([',temp6,'])),prod([',temp6,']),[]);'];
        else
         funstr{i}=[funstrwords{i}{temp2},shapeVar,'=shape(',funstrwords{i}{temp2},');'];         
        end
        needRS={needRS{:},funstrwords{i}{temp2}};
       else
        funstr{i}=[funstrwords{i}{temp2},'=reshape(',funstrwords{i}{temp2},',',funstr{i}(parens(1)+1:centercomma(end)),'[]);'];
       end
      end
      tempstr(fid)=1; %taken care of this var
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    if strcmp(funstrwords{i}{temp2},'cbrt2')
%%%     funstr{i},'mmmmmmmmmm',temp9,fid,temp(i),i,kb
%%%    end
     if temp9 %not taken care of as an assumed shape var above
      if temp(i) %if not, comment out this line
       filestr(i)=1;
       [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp2,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
       %remember, there should be only 1 var per line, and it is the first word after the ::
       goon1={''};goon1{2}='';goon1{3}='';goon1{4}='';
%%%%%%%%%%%%%%%%%%%%% data: let's take care of the data statements
       if ~isempty(localVar{fid,6})
        persistentVars=unique({persistentVars{:},funstrwords{i}{temp2}});
        [temp3,temp4]=getTopGroupsAfterLoc(funstr{i},temp1+1,'/');
        temp4=[temp1+1,temp4];
        temp5='';
        if temp10 %actual assigning of values with a slash list
         for ii=1:length(temp3)
          temp6=find(temp3{ii}=='/');
          if ~isempty(temp6)
           temp7=temp6(2);     temp6=temp6(1);
           temp8=find(~isspace(temp3{ii}) | inastring_f(temp3{ii},[1:length(temp3{ii})]));
           temp8=temp8((temp8>temp6)&(temp8<temp7));
           %'data',funstr{i},kb
           if length(find(((funstrwords_b{i}>temp4(ii))&(funstrwords_b{i}<temp4(ii)+temp6))))==1
            if strcmp(localVar{fid,3},'character') && ~isempty(localVar{fid,5})
             temp5=[temp5,temp3{ii}(1:temp6-1),'={',temp3{ii}(temp8),'}; '];
            else
             temp5=[temp5,temp3{ii}(1:temp6-1),'=[',temp3{ii}(temp8),']; '];
             %funstr{i},goon1,'/////////////111',kb
            end
            % what if this is an implied do loop
            %elseif any(funstr()=='=')
           else
            % if there is an equals in here, then it is probably an implied do loop
            if any(temp3{ii}(1:temp6-1)=='=') && ~strcmp(localVar{fid,3},'character') && ...
                 ~isempty(localVar{fid,5})
%%%            if any(temp3{ii}(temp4(ii)+1:temp6-1)=='=')
             temp5=[temp5,'[',temp3{ii}(1:temp6-1),']=[',temp3{ii}(temp8),'];'];
            else
             temp5=[temp5,',',funstrwords{i}{temp2},'={};[',temp3{ii}(1:temp6-1),']=deal(',temp3{ii}(temp8),');'];
            end
           end
          end % if ~isempty(temp)
         end % for ii=1:length(temp3)
             %is this a vector or scalar?
         %if isempty(localVar{fid,5})
         if isempty(parens)
          goon1{1}=['if isempty(',funstrwords{i}{temp2},'), '];goon1{2}=' end;';
         else
          goon1{1}=['try;',funstrwords{i}{temp2},funstr{i}(parens(1):parens(2)),';catch; '];goon1{2}=' end;';
         end
         %'ieeeeeee',funstr{i},goon1,kb
          %goon1{1}=['if isempty(',funstrwords{i}{temp2},'), '];goon1{2}=' end;';
         %else
          %'ieeeeeee',kb
          %goon1{1}=['if ',funstrwords{i}{temp2},'_isempty, '];goon1{2}=' end;';
         %end
         goon1{4}=temp5;
         %funstr{i}=temp5;
        else
         %set up the isempty var if not a scalar
%%%         if ~isempty(localVar{fid,5})
%%%          goon1{1}=['if isempty(',funstrwords{i}{temp2},'),',...
%%%                    funstrwords{i}{temp2},'_isempty=1; else ',...
%%%                    funstrwords{i}{temp2},'_isempty=0; end;' ];
%%%         else
          temp(i)=0; %don't need it! scalar data dec
%%%         end
         %tempstr(fid)=1; %taken care of this var -- may be many lines of same var data dec
         %temp(i)=0; %type dec of data, don't need
        end
        %continue %no need to go further with this line... (??)
        %funstr{i},goon1,'/////////////',kb
       end % if ~isempty(localVar{fid,
%%%%%%%%%%%%%%%%%%%%% parameter: easy, just keep all after ::
       if ~isempty(localVar{fid,9})
        %if isempty(find(funstr{i}(funstrwords_e{i}(temp2)+1:end)=='='))
        if ~isempty(find(funstr{i}(funstrwords_e{i}(temp2)+1:end)=='='))
         goon1{4}=funstr{i}(funstrwords_b{i}(temp2):end);
         %tempstr(fid)=1; %taken care of this var
        else
         temp(i)=0;
         continue %this is the type dec of a param, don't need
        end
       end % if localVar{i,
%%%%%%%%%%%%%%%%%%%%% replace fortran reserved words.
       if any(strcmp(funstrwords{i}{temp2},fortranVarOrRes))
        funstr{i}=strrep(funstr{i},funstrwords{i}{temp2},[funstrwords{i}{temp2},MLapp]);
        [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
       end
%%%%%%%%%%%%%%%%%%%%% does this need to be persistent?
       if isempty(localVar{fid,6}) %not a data statement
        goon2=0;
        if ~isempty(localVar{fid,7})||~isempty(localVar{fid,6}), goon2=1; end
        [temp6,temp7,temp8]=getTopLevelStrings(funstr{i},funstrwords_b{i}(temp2),'=',i,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
        if ~isempty(temp6) & ~isempty(temp8)
         goon2=1;
        end
        if ismod
         goon2=1;
%%%         if ~(~isempty(temp6) & ~isempty(temp8)) %if there is no = after
%%%          goon2=1;
%%%         else
%%%          goon2=0;
%%%         end % if ~(~isempty(temp6) & ~isempty(temp8)) %if there is no = after
        end % if ismod
        if goon2
         persistentVars=unique({persistentVars{:},funstrwords{i}{temp2}});
         goon1{1}=['if isempty(',funstrwords{i}{temp2},'), '];
         goon1{2}=' end;';
        end % if goon2
       end % if isempty(localVar{fid,
%%%    if strcmp(funstrwords{i}{temp2},'trgtoptismatdomain')
%%%     funstr{i},'nnnnnnnnn',temp9,fid,temp(i),i,localVar,kb
%%%    end
%%%%%%%%%%%%%%%%%%%%% Do we need this to be global?  yes if common or ismod
       if ~isempty(localVar{fid,4}) || ismod
        goon1{3}=['global ',funstrwords{i}{temp2},'; ']; 
       end
%%%%%%%%%%%%%%%%%%%%%zeroing
       if want_ze && isempty(localVar{fid,6}) &&...
            ~(~isempty(localVar{fid,4}) || ...
              any(strcmp(funstrwords{i}{temp2},statementFunction)) || ...
              tempstr(fid))
%%%      if want_ze && ~(~isempty(localVar{fid,4}) || ~isempty(localVar{fid,6}) || ...
%%%                      any(strcmp(funstrwords{i}{temp2},statementFunction)) || ...
%%%                      tempstr(fid))
        goon1{4}=zeroVarDec(funstr,i,temp2,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,localVar,fid,varp,funwords,want_row,var_words);
       end % if want_ze
%%%%%%%%%%%%%%%%%%%%% Put these last together
       if strcmp(localVar{fid,3},'character') %|| strcmp(localVar{fid,3},'string')
        goon1{4}=strrep(strrep(goon1{4},'(/','{'),'/)','}');
       end
       funstr{i}=[goon1{3},goon1{1},goon1{4},goon1{2}];
       tempstr(fid)=1; %taken care of this var
                       %funstr{i},goon1,'++++++++++++++',kb
      else
       funstr{i}=['% ',funstr{i}];
      end % if goon1
     end % if temp9 %not taken care of as an assumed shape var above
    else
     funstr{i}=['% ',funstr{i}];
     %'what, no var here?',funstr{i},kb
    end % if ~isempty(temp2)
   end % if (any(strcmpi(funstrwords{i}{1},
  end % if ~isempty(funstrwords{i})
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with parameter declarations and remove var declaration and dimensioning')
%%%  warning(funstr{i})
%%% end
end
for i=find(filestr), funstr{i}=[varPrefix,' ',funstr{i}]; end


%add in all the reshapes
temp6='';
for i=1:size(localVar,1)
 if ~isempty(localVar{i,6}) && localVar{i,6} && ~isempty(length(localVar{i,5})) && length(localVar{i,5})>1
  temp1='';
  for j=1:length(localVar{i,5})
   temp1=[temp1,localVar{i,5}{j},','];
  end % for j=1:length(localVar{i,3
  temp6=[temp6,localVar{i,1},'=reshape(',localVar{i,1},',[',temp1(1:end-1),']);'];
 end % if localVar{i,
end % for i=1:size(localVar,
    %now add this in to funstr
goonimag=find(filestr,1,'last');if isempty(goonimag), goonimag=1; end
funstr{goonimag}=[funstr{goonimag},temp6];
[s,fs_good]=updatefunstr_1line_f(funstr,fs_good,goonimag);

temp(find(almil))=0;   temp=find(temp);
temp1=cell(1,1);
[temp1{1:length(temp)}]=deal(funstr{temp});
funstr=temp1;
[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);


%'saaaaaaaaa',funstr.',kb


%if strcmp(this_fun_name,'splpmn'),'///////////////',kb,end
%'reeeeeeee3333334',funstr,keyboard

%Try to find vars to be initialized in subroutine calls
temp5=find(strcmpi(fun_name,this_fun_name));
temp3=fundecline;
for i=fs_good
%%% try
  temp1=strcmp('call',funstrwords{i});
  if any(temp1)
   temp1=find(temp1);
   temp1=temp1(1);
   if ~inastring_f(funstr{i},funstrwords_b{i}(temp1)) & ~incomment(funstr{i},funstrwords_b{i}(temp1))
    [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp1+1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    if howmany>0
     fid=find(((funstrwords_b{i}>parens(1))&(funstrwords_b{i}<parens(2))));
     %Initialize undeclared vars
     %fid holds the word indeces for all subscript
     if ~isempty(fid)
      for j=1:length(fid)
       % don't initialize function calls
%%%    if strcmp(this_fun_name,'splpmn') && strcmp(funstrwords{i}{temp1+1},'splpdm') && ...
%%%         strcmp('eps',funstrwords{i}{fid(j)})
%%%     'sttttttttt22',kb
%%%    end
       if ~any(strcmpi(funstrwords{i}{fid(j)},commonvars)) & ~any(strcmpi(funstrwords{i}{fid(j)},fortranfunwords)) & validSpot(funstr{i},funstrwords_b{i}(fid(j)))
        goon=0;
        if any(strcmp(funstrwords{i}{fid(j)},funstrwords{temp3})) %this word appears in the function definition
         temp4=find(funstr{temp3}=='=');
         if ~isempty(temp4)
          temp2=find(strcmp(funstrwords{i}{fid(j)},funstrwords{temp3}));
          if funstrwords_b{temp3}(temp2(end))>temp4(end)
           %do nothing, this var is an incoming argument or a common variable
          else
           %put in inout for initialization. Is an output argument
           goon=1;
          end
         end
        else
         [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,fid(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
         if howmany2==0 %no subscript => must be a variable, initialize
          goon=1;
         else %test to see if function call
          if ~(any(strcmp(funstrwords{i}{fid(j)},funwords))|any(strcmp(funstrwords{i}{fid(j)},fun_name)))
           goon=1;
          end
         end
         % but if this is the only word before an = sign, then it is a specifier only.
         % if the subroutine is part of funwordsNoRemoveEq, then don't add
         if any(strcmp(funstrwords{i}{temp1+1},funwordsNoRemoveEq))
          goon=0;
         end
         %if want_ze==1 and this is a local var (or module's local var), then don't initialize
         temp7=varInUsedMods(funstrwords{i}{fid(j)},modLocalVar,usedMods);
         if want_ze && (any(strcmp({localVar{:,1}},funstrwords{i}{fid(j)})) || ~isempty(temp7))
          goon=0;
         end % if want_ze && (any(strcmp({localVar{:,
        end
        %if this is a struct, then it (probably) doesn't need initialization up top
        temp8=find(strcmp({localVar{:,1}},funstrwords{i}{fid(j)}));
        if ~isempty(temp8)
         if ~any(strcmp(localVar{temp8,3},var_words))
          goon=0;
         end
        end
        if goon
         %'-=-=-=-=-=-=-',funstr{i},inout,kb
         if ~any(strcmpi(funstrwords{i}{fid(j)},inout{temp5})) && ...
              ~any(strcmpi(funstrwords{i}{fid(j)},fun_name)) && ...
              ~any(strcmpi(funstrwords{i}{fid(j)},statementFunction)) && ...
              ~any(strcmpi(funstrwords{i}{fid(j)},extwords)) && ...
              ~strcmpi(funstrwords{i}{fid(j)},[TFops{1,2},TFops{1,3}]) && ...
              ~strcmpi(funstrwords{i}{fid(j)},[TFops{2,2},TFops{2,3}])
          inout{temp5}{end+1}=funstrwords{i}{fid(j)};
         end
        end
       end
      end
     end
    end
   end
  end
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with finding vars to be initialized in subroutine calls')
%%%  warning(funstr{i})
%%% end
end


%'reeeeeeee3333333',funstr,inout,keyboard


%fix any : list in a subscript to have be enclosed in [] and fix order for a:b:step
%%%if ~isempty(strfind(version,'R14'))
tempflag=intersect(find(~cellfun('isempty',strfind(funstr,':'))),fs_good);
%%%else
%%% tempflag=[];
%%% for ii=1:length(funstr)
%%%  if ~isempty(strfind(funstr{ii},':'))
%%%   tempflag=[tempflag,ii];
%%%  end
%%% end
%%% tempflag=intersect(tempflag,fs_good);
%%%end
for i=tempflag
 try
  for j=length(funstrwords{i}):-1:1
   temp=funstr{i}=='(';
   temp1=funstr{i}==')';
   temp2=cumsum(temp)-cumsum([0 temp1(1:end-1)]);
   temp4=find(funstr{i}==':');
   if any(strcmp(funstrwords{i}{j},{localVar{:,1}}))
    if ~inastring_f(funstr{i},funstrwords_b{i}(j)) & ~incomment(funstr{i},funstrwords_b{i}(j))
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if howmany>0
      subscripts=strtrim(subscripts);
      temp3=[parens(1),centercomma,parens(2)];
      tempstr=[];
      for count=1:howmany
       temp5=temp4(temp4>temp3(count) & temp4<temp3(count+1)); %which subscript is this in?
       goon=0;
       if ~isempty(temp5)
        if all(temp2(temp5)==temp2(temp3(count)))
         goon=1;
        end
       end
       if goon
        temp6=''; temp6{1}='['; temp6{2}=']';
        if strcmp(subscripts{count}(1),'[')
         temp6{1}=''; temp6{2}='';
        end
        if length(temp5)==1
         goonimag='';
         if subscripts{count}(end)==':'
          goonimag='end';
         end
         tempflag='';
         if subscripts{count}(1)==':'
          tempflag='1';
         end
         % if this is a string, then limit the upper bound by the length of the string
%%%         if any(strcmpi(funstrwords{i},'timeseries'))
%%%          funstr{i},'///////////',kb
%%%         end
         temp8=find(strcmp(funstrwords{i}{j},{localVar{:,1}}));
         temp7=find(subscripts{count}==':');
         if strcmp(localVar{temp8,3},'character') && isempty(localVar{temp8,5}) && ...
              length(temp7)==1 && ...
              ~strcmp(strtrim(subscripts{count}(temp7+1:end)),'1') && ...
              ~strcmp(subscripts{count}(1:temp7-1),subscripts{count}(temp7+1:end))
%%%         if strcmp(localVar{temp8,3},'character') && isempty(localVar{temp8,5}) && ...
%%%              length(temp7)==1 && ~strcmp(subscripts{count}(temp7+1),'1') && ...
%%%              ~strcmp(subscripts{count}(1:temp7-1),subscripts{count}(temp7+1:end))
          subscripts{count}=[subscripts{count}(1:temp7),'min(length(',funstrwords{i}{j},...
                             '),',subscripts{count}(temp7+1:end),')'];
         end
         fid=[temp6{1},tempflag,subscripts{count},goonimag,temp6{2}];
        else
         fid=[temp6{1},...
              funstr{i}(temp3(count)+1:temp5(1)),...
              funstr{i}(temp5(2)+1:temp3(count+1)-1),...
              funstr{i}(temp5(1):temp5(2)-1),...
              temp6{2}];
        end
       else
        fid=subscripts{count};
       end
       if count~=howmany
        tempstr=[tempstr,fid,','];
       else
        tempstr=[tempstr,fid];
       end
      end
      funstr{i}=[funstr{i}(1:parens(1)),tempstr,funstr{i}(parens(2):end)];
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
     end
    end
   end % if any(strcmp(funstrwords{i}{j},
  end % for j=1:length(funstrwords{i})
%%%  if any(strcmp(funstrwords{i},'bprim'))
%%%   ',,,,,,,,,,,,,',funstr{i},this_fun_name,i,j,kb
%%%  end
 catch
  numErrors=numErrors+1;
  disp('problem with fix any : list in a subscript to have be enclosed in []')
  warning(funstr{i})
 end
end

%'reeeeeeee5555555555',funstr,keyboard

%Change over // string concatenations
for i=fs_good
%%% try
  temp=findstr(funstr{i},'//');
  for ii=length(temp):-1:1
   if validSpot(funstr{i},temp(ii))
    [tempflag,temp5,argDelin]=changeoperator_f(i,'//',temp(ii),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords, fortranfunwords,formats,localVar,typeDefs,var_words);
%%%    if any(strcmp(funstrwords{i},'def'))
%%%     funstr{i},funstr{i}(1:temp(ii)+1)
%%%     'iiiiiiiiii',argDelin,funstr{i},funstr{i}(argDelin(1):argDelin(2)),kb
%%%    end
    if all(argDelin(1:2)==0)
     argDelin(1)=temp(ii); argDelin(2)=temp(ii)-1;
    end
    if all(argDelin(3:4)==0)
     argDelin(3)=temp(ii); argDelin(4)=temp(ii)-1;
    end
    funstr{i}=[funstr{i}(1:argDelin(1)-1),'[',funstr{i}(argDelin(1):argDelin(2)),',',...
              funstr{i}(argDelin(3):argDelin(4)),']',funstr{i}(argDelin(4)+1:end)];
%%%    funstr{i}=fix_concats(funstr{i},temp(ii),funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,fs_good,i,funwords,fortranfunwords,formats,localVar,allTypeDefs,var_words);
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    temp=findstr(funstr{i},'//');
   end % if ~inastring_f(funstr{i},   
  end % for ii=1:length(temp)
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with Changing over // string concatenations')
%%%  warning(funstr{i})
%%% end
end

%Change calls to matlab function with no fortran equivalent (user m-files).
noChangeWords={keywordsbegin{:}}.';
%noChangeWords={keywordsbegin{:},fun_name{:}}.';
temp1={fun_name{:},keywordsbegin{:},var_words{:}};
%temp1={funwords{:},fun_name{:},keywordsbegin{:},var_words{:}};
temp3=0;
for i=fliplr(fs_good)
%%% try
  for j=length(funstrwords{i}):-1:1
   if j<=length(funstrwords{i}) && validSpot(funstr{i},funstrwords_b{i}(j))
    tempflag=0;
    temp6=0;
% if this is a var in a module, then put construct the global var statement if wanted
    if want_gl && ~ismod 
     %if want_gl && subfun && ~ismod 
     if any(strcmp(funstrwords{i}{j},{localVar{:,1},localVar{:,3}})) && ...
          ~any(strcmp(funstrwords{i}{j},{origLocalVar{:,1}})) && ...
          ~any(strcmp(funstrwords{i}{j},temp1)) && ...
          ~any(strcmp(funstrwords{i}{j},globVar)) && ...
          ~any(strcmp([funstrwords{i}{j},MLapp],globVar))
      if any(strcmp(funwords,funstrwords{i}{j})), temp0=MLapp; else temp0=''; end
      globVar={globVar{:},[funstrwords{i}{j},temp0]};
      %'ooooooooooooooooo',globVar,kb
     end
    end
    if ~any(strcmp(funstrwords{i}{j},noChangeWords))
     temp6=1;
     tempflag=0;
     tempstr=funstr{i};
     goon=1;
     if (~isempty(fundecline) && i==fundecline),      goon=0;     end
     %if this is another function declared in the same prg, then we shouldn't mess with it...
     if any(strcmpi(funstrwords{i}{j},fun_name))&&j>1&&...
          strcmpi(funstrwords{i}{j-1},'call')
          goon=0;
     end
%%%     if strcmp(funstrwords{i}{j},'shape')
%%%      'sssssssssss',funstr{i},goon,keyboard
%%%     end
     if goon && ~any(strcmp(funstrwords{i}{j},{localVar{:,1}})) || ...
          any(strcmpi(funstrwords{i}{j},{'trgtoptismatdomain','parsed_list_length','add_variable_to_matrix','loadconstraintvectorsparse'}))
      [funstr,fortranfunwords,tempflag,temp2,temp4]=wordconverter_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,fs_good,funwords,fortranfunwords,formats,localVar,modLocalVar,MLapp,varp,want_row,var_words,this_fun_name,TFops,allTypeDefs,funwordsML,statementFunction,fun_name,dumvar,want_gl);
      if any(strcmp(funstrwords{i}{j},fun_name)), tempflag=1; end
      if temp2, temp3=1; end
      extraFunctions=unique([extraFunctions,temp4]);
%%%     if any(strcmp(funstrwords{i},'readfrictionalcostpieces'))
%%%      '999999999999112',funstr{i},keyboard
%%%     end     
     elseif any(strcmp(funstrwords{i}{j},{funwords{:},{fortranVarOrRes{:}}}))
      %put an MLapp on the end
      funstr{i}=regexprep(funstr{i},['\<',funstrwords{i}{j},'\>'],[funstrwords{i}{j},MLapp]);
      %change the persistentVar list if appropriate
      %'oooooooooooo',funstr{i},kb
      fid=find(strcmp(funstrwords{i}{j},persistentVars));
      if ~isempty(fid)
       persistentVars{fid}=[persistentVars{fid},MLapp];
      end % if ~isempty(fid)
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
     end
    end
%%%    if i==35
%%%     funstr{i},funstrwords{i},funstrwords{i}{j},j,'pppppppppp',tempflag,kb
%%%    end
    if tempflag==0
     if temp6%~any(strcmp(funstrwords{i}{j},noChangeWords)) 
      noChangeWords{length(noChangeWords)+1}=funstrwords{i}{j};
     end
     temp=find(strcmpi(funstrwords{i}{j},{varp{:,1}}));
     if ~isempty(temp)
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if howmany>0
       temp7=find(strcmp({localVar{:,1}},funstrwords{i}{j})); %if this is data, might have to add the varp
       if isempty(strfind(funstr{i},varPrefix)) || (~isempty(temp7) && ~isempty(localVar{temp7,6}))
        temp1=[parens(1) centercomma parens(2)];
        for goon=length(varp{temp,2}):-1:1
%%%         if any(strcmp(funstrwords{i},'end'))
%%%          varp,temp,goon,varp{temp,2}(goon),funstr{i},keyboard
%%%         end
         if ~strcmp(subscripts{varp{temp,2}(goon)},'[1:end]')
          funstr{i}=[funstr{i}(1:temp1(varp{temp,2}(goon)+1)-1),'+',num2str(varp{temp,3}(goon)),funstr{i}(temp1(varp{temp,2}(goon)+1):end)];
          %funstr{i}=[funstr{i}(1:temp1(varp{temp,2}(goon)+1)-1+(goon-1)*2),'+',num2str(varp{temp,3}(goon)),funstr{i}(temp1(varp{temp,2}(goon)+1)+(goon-1)*2:end)];
         end
        end
       end
      end
      tempflag=1;
     end
    end
    if tempflag~=0
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    end
   end % if ~inastring_f(funstr{i},
  end % for j=length(funstrwords{i}):-1:1
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with performing word conversion')
%%%  warning(funstr{i})
%%% end
end
if want_kb,disp('finished performing word conversion'),disp(r),showall_f(funstr),disp(r),keyboard,end
if temp3
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
 %if strcmp(this_fun_name,'timestring'),'reeeeeeee444444442',funstr{i},keyboard,end
end

% fix multi statement lines
if ~ismod
 funstr=fixMultiStatementLines(funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,fs_good,funwords,filename);
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
end

%%% 'reeeeeeee88888888',funstr,keyboard




%put a fix() around all integer/integer combinations (rhs), 
for i=fliplr(fs_good)
 temp=find(funstr{i}=='/');
 if ~isempty(temp)
  for j=length(temp):-1:1
   if validSpot(funstr{i},temp(j))
    [tempflag,funstr,temp1]=changeoperator_f(i,'/',temp(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,fortranfunwords,formats,localVar,allTypeDefs,var_words);
    if tempflag
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    end
    if all(temp1~=0) && isInteger(i,temp1(1:2),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,fortranfunwords,formats,localVar) && ...
         isInteger(i,temp1(3:4),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,fortranfunwords,formats,localVar)
     %needs a fix()
     %funstr{i},temp1,'gggggggggg',kb
     funstr{i}=[funstr{i}(1:temp1(1)-1),'fix(',funstr{i}(temp1(1):temp1(4)),')',funstr{i}(temp1(4)+1:end)];
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    end % if ~incomment(funstr{i},
   end % if isInteger(i,
  end % for j=length(temp):-1:1
 end % if ~isempty(temp)
end % for i=fliplr(fs_good)

%'reee87878778787',funstr,keyboard


%Various replacements
try
 tempstr=strrep({funstr{fs_good}},'(/','[');[funstr{fs_good}]=deal(tempstr{:});
 tempstr=strrep({funstr{fs_good}},'/)',']');[funstr{fs_good}]=deal(tempstr{:});
 %Remove any spag processing statements
 funstr=regexprep(funstr,'^!.+processed by SPAG.+','');
 % Fix the logical operators
 for j=1:length(logicalops)
  tempstr=strrep({funstr{fs_good}},logicalops{j,1},logicalops{j,2});[funstr{fs_good}]=deal(tempstr{:});
 end
 %Change things about the math (matrix mult, /, .*, +, etc.), in cell 'operators'.
 for i=fs_good
  for j=1:length(operators)
   temp=strfind(funstr{i},operators{j,1});
   temp1=0;
   for ii=length(temp):-1:1
    if ~inastring_f(funstr{i},temp(ii))
     funstr{i}=[funstr{i}(1:temp(ii)-1),operators{j,2},funstr{i}(temp(ii)+length(operators{j,1}):end)];
     temp1=1;
    end % if ~inastring_f(funstr{i},
   end
   if temp1
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
   end
  end
 end
 %Fix the branch operator statements
 for j=1:length(branchops)
  tempstr=strrep({funstr{fs_good}},branchops{j,1},branchops{j,2});[funstr{fs_good}]=deal(tempstr{:});
 end
 %funstr,'000000000000',kb 
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
catch
 numErrors=numErrors+1;
 disp('problem with Various replacements')
 warning
end

%'reeeee999999999999999',funstr,keyboard


%logicalops still need some fixing for chars
logicalops_fix={'==','~=','.not.','>=','<=','>','<'};
for i=fliplr(fs_good)
 for j=1:length(logicalops_fix)
  temp=strfind(funstr{i},logicalops_fix{j});
  if ~isempty(temp)
   for k=length(temp):-1:1
    if ~incomment(funstr{i},temp(k)) & ~inastring_f(funstr{i},temp(k))
     if j==3
      %the .not. order of operations on mathematical structures is different for fortran and ML
      % for example in fortran:
      %   IF ( .NOT.ABS(Sd2)>=gamsq ) EXIT
      % should be
      %   if( ~(abs(sd2)>=gamsq) )
      % not
      %   if( ~abs(sd2)>=gamsq )
      % if the .not. is followed by a logical expression, then leave it alone though
      %'loooooooooo',funstr{i},kb
      [tempflag,funstr]=fixNotOperator(i,temp(k),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,fortranfunwords,formats,localVar,logicalops,allTypeDefs,var_words);
     else
      [tempflag,funstr]=changeoperator_f(i,logicalops_fix{j},temp(k),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,fortranfunwords,formats,localVar,allTypeDefs,var_words);   
     end % if j==3
     if tempflag
      %'sssssssssssss',funstr,keyboard
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
     end % if tempflag
    end % if ~incomment(funstr{i},
   end % for k=length(temp):-1:1
  end % if ~isempty(temp)
 end % for j=1:length(logicalops_fix)
end % for i=fs_good

%'sssssssssssss1',funstr,keyboard

%Fix for, while, if, keywords groups
for i=fliplr(fs_good)
%%% try
  if ~isempty(funstrwords{i})
   switch funstrwords{i}{1}
    case 'call'
    case 'case'
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if ~isempty(parens)
      funstr{i}(parens(1))='{';      funstr{i}(parens(2))='}';
     end
    case 'continue'
     %should we try to guess who points here?
     %funstr{i}=['% ',funstr{i}];
    case 'else'
     if length(funstrwords{i})>1
      if strcmp(funstrwords{i}{2},'if')
       funstr{i}=[funstr{i}(1:funstrwords_b{i}(1)-1),'elseif',funstr{i}(funstrwords_e{i}(2)+1:funstrwords_b{i}(end)-1),';'];
      end
     end
    case 'elseif'
     funstr{i}=[funstr{i}(1:funstrwords_b{i}(1)-1),'elseif',funstr{i}(funstrwords_e{i}(1)+1:funstrwords_b{i}(end)-1),';'];
    case 'do'
     if ~any(strcmpi(funstrwords{i},'while'))
      %fix this if it points to a label
      fixLabeledDoLoops
      fid=find(funstr{i}=='=');
      if ~isempty(fid)
       fid=fid(fid>funstrwords_e{i}(1));fid=fid(1);
       temp=findstr(funstr{i},',');temp1=[];
       temp=temp(temp>fid);
       for j=1:length(temp)
        if inwhichlast_f(i,temp(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename)==0
         temp1=[temp1 temp(j)];
        end
       end
%%%       if strcmp(this_fun_name,'setsectorconstraints')
%%%        'qqqqqqqqqqqqq',funstr{i},keyboard
%%%       end
       temp2=findend_f(i,s,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
       goon=1;
       %'qqqqqqqqqqqqq',funstr{i},keyboard
       for ii=i+1:temp2-1
        if any(strcmp(funstrwords{ii},'break'))
         goon=0;
        end
       end
       if length(temp1)==1
        if goon
         if want_for
          funstr{temp2}=[funstr{temp2},';',funstr{i}(funstrwords_e{i}(1)+1:fid),strrep(funstr{i}(temp1(1)+1:end),';',''),'+1;'];
         end
        end
        funstr{i}=[funstr{i}(1:funstrwords_b{i}(1)-1),'for',funstr{i}(funstrwords_e{i}(1)+1:fid),funstr{i}(fid+1:temp1(1)-1),':',funstr{i}(temp1(1)+1:end)];
       elseif length(temp1)==2
        if goon
         temp3='+'; if any(funstr{i}(temp1(2)+1:end-1)=='-'), temp3='-'; end
         if want_for
          funstr{temp2}=[funstr{temp2},';',funstr{i}(funstrwords_e{i}(1)+1:fid),funstr{i}(temp1(1)+1:temp1(2)-1),temp3,'1;'];
         end
        end
        funstr{i}=[funstr{i}(1:funstrwords_b{i}(1)-1),'for',funstr{i}(funstrwords_e{i}(1)+1:fid),funstr{i}(fid+1:temp1(1)-1),':',funstr{i}(temp1(2)+1:end-1),':',funstr{i}(temp1(1)+1:temp1(2)-1),';'];
       end
      else %There is no = sign here and no while, just replace with while
       temp=find(strcmpi(funstrwords{i},'do'));
       %funstr=replaceword_f(i,j,funstr,funstrwords,funstrwords_b,funstrwords_e,'while (1)');
       funstr{i}=[funstr{i}(1:funstrwords_b{i}(temp(1))-1),'while (1)',funstr{i}(funstrwords_e{i}(temp(1))+1:end)];
      end
     else %This is a do while construct
      temp=find(strcmpi(funstrwords{i},'while'));
      funstr{i}=funstr{i}(funstrwords_b{i}(temp(1)):end);
     end
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    case 'if'
%%%       if any(strcmp(funstrwords{i},'encountered'))
%%%        'iiiiiiiiiiiii',funstr{i},funstr{temp2},keyboard
%%%       end     
     if strcmpi('then',funstrwords{i}(end))
      funstr{i}=[funstr{i}(1:funstrwords_b{i}(1)-1),'if',funstr{i}(funstrwords_e{i}(1)+1:funstrwords_b{i}(end)-1),';'];
     else
      funstr{i}=[funstr{i}(1:funstrwords_b{i}(1)-1),'if',funstr{i}(funstrwords_e{i}(1)+1:end),' end;'];
     end
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    case 'otherwise'
    case 'switch'
    case 'where' %does not support an elsewhere separate mask right now
     ;% is this a statement where or does it have a body?
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if any(funstrwords_b{i}>parens(2)) %statement where
      funstr(i+1+2:end+2)=funstr(i+1:end);
      funstr{i+1}=funstr{i}(parens(2)+1:end);
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i+1);
      funstr{i}=funstr{i}(1:parens(2));
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      funstr{i+2}=['end where'];
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i+2);
      [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
     end
     temp=findend_f(i,s,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     temp2=findNextWord(i,'elsewhere',temp,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if temp2==0  %no elsewhere
      temp2=temp;
     else
      funstr{temp2}=funstr{temp2}(funstrwords_e{temp2}(1)+1:end);
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,temp2);
     end
     %get rid of where and end
     funstr{i}=['fmask=',funstr{i}(funstrwords_e{i}(1)+1:parens(2)),';'];
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);     
     funstr{temp}=['%',funstr{temp}];
     %funstr{temp}=funstr{temp}(funstrwords_e{temp}(1)+1:end);
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,temp);
     temp3='';
     for ii=i+1:temp-1
      if ii>temp2, temp3='~'; end
      for fid=length(funstrwords{ii}):-1:1
       temp4=find(strcmp({localVar{:,1}},funstrwords{ii}{fid}));
       if ~isempty(temp4) && any(strcmp(localVar{temp4,3},var_words))
        if ~ischar(localVar{temp4,2})
         if length(localVar{temp4,5})>0
          [howmany,subscripts,centercomma,parens]=hassubscript_f(ii,fid,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
          if length(localVar{temp4,5})==1 & howmany==0
           funstr{ii}=[funstr{ii}(1:funstrwords_e{ii}(fid)),'(',temp3,'fmask)',funstr{ii}(funstrwords_e{ii}(fid)+1:end)];
          elseif length(localVar{temp4,5})==1 & howmany~=0
           funstr{ii}=[funstr{ii}(1:parens(1)),temp3,'fmask',funstr{ii}(parens(2):end)];
          elseif length(localVar{temp4,5})>1 & howmany==0
           funstr{ii}=[funstr{ii}(1:funstrwords_e{ii}(fid)),'(',temp3,'fmask)',funstr{ii}(funstrwords_e{ii}(fid)+1:end)];
          elseif length(localVar{temp4,5})>1 & howmany~=0
           if any(subscripts{1}==':')
            funstr{ii}=[funstr{ii}(1:parens(1)),temp3,'fmask',funstr{ii}(centercomma(1):end)];
           else
            funstr{ii}=[funstr{ii}(1:centercomma(1)),temp3,'fmask',funstr{ii}(parens(2):end)];
           end % if any(subscripts{1}==':')
          end % if length(localVar{temp4,
         end % if length(localVar{temp4,
        end % if localVar{temp4,
       end % if ~isempty(temp4)
      end % for fid=length(funstrwords{ii}):-1:1
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,ii);
     end % for ii=
     %'whereeeeeeeeee',funstr{i},kb
    case 'while'
   end
  end
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with Fixing for, while, if, keywords groups')
%%%  warning(funstr{i})
%%% end
end
[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
if want_kb,disp('finished fixing if, for, etc keywords.'),disp(r),showall_f(funstr),disp(r),keyboard,end


%'tttrrrrrrrrrrr',funstr,kb

%split up the one line if statements
for i=fliplr(fs_good)
 if ~isempty(funstrwords{i})
  if strcmp(funstrwords{i}{1},'if')
   if strcmp('end',funstrwords{i}(end))
    funstr(i+3:end+2)=funstr(i+1:end);
    [howmany,subscripts,centercomma,parens]=hassubscript_f(i,1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    tempstr=funstr{i};
%%%       if any(strcmp(funstrwords{i},'encountered'))
%%%        'iiiiiiiiiiiii',funstr{i},keyboard
%%%       end     
    funstr{i}=[tempstr(1:parens(2))];
    funstr{i+1}=[tempstr(parens(2)+1:funstrwords_b{i}(end)-1)];
    funstr{i+2}=['end;'];
   end % if ~strcmp('end',
  end % if strcmp(funstrwords{i}{1},
 end % if ~isempty(funstrwords{i})
end % for i=fliplr(fs_good)
[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);


% fix struct array indexing, allow things like:
%%%type ttt1
%%%  integer i1
%%%end type ttt1
%%%type(ttt1) tv2(10)
%%%tv2%i1=3
%%%tv2(1:4)%i1=4
%%%tv2(1:4)%i1=4+tv2(1:4)%i1
tempstr=0;
for i=fliplr(fs_good)
 if ~isempty(funstrwords{i})
  for j=length(funstrwords{i}):-1:1
   temp1=find(strcmp(funstrwords{i}{j},{localVar{:,1}}));
   if ~isempty(temp1)
    temp2=find(strcmp(localVar{temp1,3},{typeDefs{:,1}})); 
    if ~isempty(temp2)
     temp3=lastNonSpace(funstr{i},funstrwords_b{i}(j));
     if temp3==0 || funstr{i}(temp3)~='.'
      %OK, get the varType
      [temp4,temp5,temp6]=varType(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,localVar,allTypeDefs,var_words);
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp6,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if temp6>j && isempty(parens)
       temp7=find(funstr{i}=='='); 
       if ~isempty(temp7),        temp7=temp7(validSpot(funstr{i},temp7));       end
       if ~isempty(temp7), temp7=temp7(1); else, temp7=0; end
       goon=0;     % add []=deal
       goonimag=0; % add [] only
       if ~strcmp(temp5{1,5},'character')
        if temp3==0 && temp7>0 && ...
                 ( (~isempty(localVar{temp1,5}) & isempty(parens2)) | ...
                   any(funstr{i}(funstrwords_b{i}(j):funstrwords_b{i}(temp6))==':') )
         goon=1;
        end
        if temp3>0 && any(funstr{i}(funstrwords_b{i}(j):funstrwords_b{i}(temp6))==':') && ...
             isempty(parens)
         goonimag=1;
        end
        %'greeeeeeeeeeee11',funstr{i},funstrwords{i}{j},goon,goonimag,kb
        if goon
         temp8=find(funstr{i}==';');  temp8=temp8(validSpot(funstr{i},temp8)&temp8>temp7); 
         temp8=temp8(1);
         funstr(i+1:end+1)=funstr(i:end);
         funstr{i}=['cellVec=num2cell(',funstr{i}(temp7+1:temp8-1),');'];
         funstr{i+1}=['[',funstr{i+1}(1:temp7-1),']',' = deal(cellVec{:});',funstr{i+1}(temp8+1:end)];
         tempstr=1;
         break
        elseif goonimag
         funstr{i}=[funstr{i}(1:funstrwords_b{i}(j)-1),'[',...
                    funstr{i}(funstrwords_b{i}(j):funstrwords_e{i}(temp6)),']',...
                    funstr{i}(funstrwords_e{i}(temp6)+1:end)];
         [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
        end
       end
       %'greeeeeeeeeeee',funstr{i},funstr{i+1},funstrwords{i}{j},goon,goonimag,kb
      end
     end % if temp3==0 || funstr{i}(temp3)~='.
    end % if ~isempty(temp2)
   end % if ~isempty(temp1)
  end % for j=length(funstrwords{i}):-1:1
 end % if ~isempty(funstrwords{i})
end % for i=fs_good
if tempstr
 [funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
end



% short circuit logic on if's and elseif's
tempstr=0;
for i=fliplr(fs_good)
 if ~isempty(funstrwords{i})
  if any(strcmp(funstrwords{i}{1},{'if','elseif'}))
   goon=1;
   if any(funstr{i}==':') | any(funstr{i}=='['),   goon=0;   end
   if goon
    for j=1:length(funstrwords{i})
     temp1=find(strcmp(funstrwords{i}{j},{localVar{:,1}}));
     if ~isempty(temp1)
      %OK, get the varType
      [temp4,temp5,temp6]=varType(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,localVar,allTypeDefs,var_words);
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp6,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if howmany~=length(temp5{1,5})
       goon=0; break
      end
     end % if ~isempty(temp1)
    end % for j=1:length(funstrwords{i})
    if goon
     funstr{i}=strrep(funstr{i},'|','||');
     funstr{i}=strrep(funstr{i},'&','&&');
     [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    end
   end % if goon
  end % if any(strcmp(funstrwords{i}{1},
 end % if ~isempty(funstrwords{i})
end % for i=fliplr(fs_good)


%Find complex(,) statements with no complex and fix them
for i=fs_good
 try
  count=1;gotto=1;
  while count==1
   count=0;
   temp=findstr('(',funstr{i});
   if ~isempty(temp)
    for j=gotto:length(temp)
     if ~inastring_f(funstr{i},temp(j)) & ~incomment(funstr{i},temp(j))
      [outflag,howmany,subscripts,centercomma,parens]=iscomplex(i,j,temp,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if outflag
       funstr{i}=[funstr{i}(1:temp(j)-1),'complex',funstr{i}(temp(j):(end))];
       [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
       count=1;gotto=j;
      end
     end
     if count==1, break; end
    end
   end
  end
 catch
  numErrors=numErrors+1;
  disp('problem with fixing (,) complex constructions')
  warning(funstr{i})
 end
end
if want_kb,disp('finished inserting complex''s'),disp(r),showall_f(funstr),disp(r),keyboard,end



% Misc tasks
if ~subfun
 filename_ml=[strrep(filename_base,'.','_'),'.m'];
end

%'reeeeeeee000000000',funstr,keyboard

%Let's go for implied do loops
for i=fs_good
%%% try
  temp=find(funstr{i}=='=');
  while ~isempty(temp)
   %temp=temp(end);
   if ~inastring_f(funstr{i},temp(end)) & ~incomment(funstr{i},temp(end))
    [outflag,howmany,subscripts,centercomma,parens]=inwhichlast_f(i,temp(end),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
    temp=temp(1:length(temp)-1);
    if outflag==1
     temp3=funstr{i}(parens(1):parens(2)-1);
     [subscripts,temp5]=getTopGroupsAfterLoc(temp3,1);
     if length(subscripts)>2
      %which subscript is the = sign in?
      for ii=length(subscripts):-1:1
       if any(subscripts{ii}=='=')
        temp2=ii;
        temp2(2)=find(subscripts{ii}=='=');
        break
       end
      end
      [outflag2,howmany2,subscripts2,centercomma2,parens2]=inwhichlast_f(i,parens(1),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
      if outflag2==2 %implied do loop in an array constructor
       if ~any(strcmp({'if','elseif','while'},funstrwords{i}{1}))
        tempstr=subscripts{temp2(1)}(1:temp2(2)-1);
        tempstr=tempstr(~isspace(tempstr)); %should contain the loop var
        fid=temp5(temp2(1)-1);
        if (length(subscripts)-temp2(1))==2 %then a two colon for loop
         howmany=['[',subscripts{temp2(1)}(temp2(2)+1:end),':',...
                  subscripts{temp2(1)+2},':',subscripts{temp2(1)+1},']'];
        else
         howmany=['[',subscripts{temp2(1)}(temp2(2)+1:end),':',...
                  subscripts{temp2(1)+1},']'];
        end
        goon=regexprep(funstr{i}(parens(1):parens(1)+fid-1),...
                       ['(\W)',tempstr,'(\W)'],['$1',howmany,'$2']);
        % only need the ones().* if there is no loop var in the expression.
        % For something like (10.0,j=1,4)
        temp6=[]; temp6{1}=''; temp6{2}='';
        goonimag=funstrwords_b{i}>(parens(1)) & funstrwords_b{i}<(parens(1)+temp5(1)-1);
        if ~any(goonimag) || ~any(strcmp({funstrwords{i}{goonimag}},tempstr))
         temp6{1}=['ones(size(',howmany,')).*(']; temp6{2}=')';
        end
        funstr{i}=[funstr{i}(1:parens(1)-1),temp6{1},goon(2:end-1),temp6{2},funstr{i}(parens(2)+1:end)];
        %'[[[[[[[[[[[[[[[',funstr{i},keyboard
       end % if ~strcmp({'if',
      else % by self, usually with a read or write 
       goon=1;
       if any(strcmp({'if','elseif','while'},funstrwords{i}{1}))
        goon=0;
        % if a read or write does not appear closer to the implied do than a "if" etc.
        fid=find(funstrwords_b{i}>funstrwords_b{i}(1) & funstrwords_b{i}<parens(1));
        if any(strcmp('fscanf',{funstrwords{i}{fid}})) | any(strcmp('fprintf',{funstrwords{i}{fid}})) | any(strcmp('writef',{funstrwords{i}{fid}}))
         goon=1;
        end % if any(strcmp('fscanf',
       end
       if goon
        tempstr='';
        for ii=1:temp2(1)-1
         if ii~=temp2(1)-1,temp4=',';else temp4='';end
         tempstr=[tempstr,subscripts{ii},temp4];
        end
        if (length(subscripts)-temp2(1))==2 %then a two colon for loop
         funstr{i}=['for ',subscripts{temp2(1)}(1:temp2(2)-1),'=(',...
                    subscripts{temp2(1)}(temp2(2)+1:end),'):(',...
                    subscripts{temp2(1)+2},'):(',subscripts{temp2(1)+1},'), ',...
                    funstr{i}(1:parens(1)-1),tempstr,funstr{i}(parens(2)+1:end),' end;'];
        else
         funstr{i}=['for ',subscripts{temp2(1)}(1:temp2(2)-1),'=(',...
                    subscripts{temp2(1)}(temp2(2)+1:end),'):(',...
                    subscripts{temp2(1)+1},'), ',...
                    funstr{i}(1:parens(1)-1),tempstr,funstr{i}(parens(2)+1:end),' end;'];     
        end
       end % if goon
      end
      [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
      temp=find(funstr{i}=='=');
      %funstr{i},subscripts,',,,,,,,,,,,,,,,,',keyboard
     end % if length(subscripts)>2)
    end % if outflag==1
   else
    temp=temp(1:length(temp)-1);
   end % if ~inastring_f(funstr{i},
  end % while ~isempty(temp)
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with fixing implied do loops'),%  keyboard
%%%  warning(funstr{i})
%%% end
end % for i=fs_good

%'reeeeeeee11111111',funstr.',keyboard


%Fix up the function definitions and calls
for i=fs_good
%%% try
  temp6=1;
  if length(funstrwords{i})>0
   if ~any(strcmp(funstrwords{i}{1},type_words))
    for ii=length(funstrwords{i}):-1:1
     temp1=find(strcmp(funstrwords{i}{ii},fun_name));
     if ~isempty(temp1)
      if ~inastring_f(funstr{i},funstrwords_b{i}(ii)) && ~any(strcmp(funstrwords{i}{ii},{localVar{:,1}})) && ~incomment(funstr{i},funstrwords_b{i}(ii))
       [howmany,subscripts,centercomma,parens]=hassubscript_f(i,ii,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
       if howmany>0
        tempstr=find(funstrwords_b{i}>parens(1) & funstrwords_b{i}<parens(2));
        fid=0;
        for j=length(tempstr):-1:1
         if any(strcmp(funstrwords{i}{tempstr(j)},fun_name)) && ~strcmp(funstrwords{i}{tempstr(j)},this_fun_name)
          [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,tempstr(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
          if howmany2==0 && ~any(strcmp(funstrwords{i}{tempstr(j)},{localVar{:,1}})) && ~inastring_f(funstr{i},funstrwords_b{i}(tempstr(j))) && ~any(strcmp(funstrwords{i}{tempstr(j)},funstrwords{fundecline}(funargs)))
           funstr{i}=[funstr{i}(1:funstrwords_b{i}(tempstr(j))-1),'@',funstr{i}(funstrwords_b{i}(tempstr(j)):end)];
           fid=1;
          end % if howmany2==0
         end % if any(strcmp(funstrwords{i}{tempstr(ii)},
        end % for ii=1:length(tempstr)
        if fid
         [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
        end

%%%        if any(strcmpi(funstrwords{i},'matdomain_open'))
%%%         funstr{i},'cccccccccc',kb
%%%        end

        
%%% This is preempted by the assignin functionality added
%when we have the format:
%   var= fun_name()
% we should change it to a call so that extra vars can be changed as well.
%  call fun_name(var,...)
        if isempty(find(funstrwords_b{i}>parens(2))) && ...
             isempty(find(funstrnumbers_b{i}>parens(2)))
         %temp2=findNext(funstrwords_b{i}(ii),'=',funstr{i},-1);
         temp2=lastNonSpace(funstr{i},funstrwords_b{i}(ii));
         if (temp2>0 && funstr{i}(temp2)=='=') %we've got our = sign just before the function call, change
          temp4=lastNonSpace(funstr{i},temp2);
          if suborfun(temp1)==2
           if (temp4>0 && funstr{i}(temp4)~=']') && ...
                (funstrwords_b{i}(ii)-temp2==1 || ...
                 all(funstr{i}(temp2+1:funstrwords_b{i}(ii)-1)==' '))
%%%        funstr{i}=['call ',funstrwords{i}{ii},'_function_(',funstr{i}(parens(1)+1:end)];
            funstr{i}=['call ',funstrwords{i}{ii},'(',funstr{i}(1:temp2-1),',',...
                       funstr{i}(parens(1)+1:end)];
            temp6=0; %marks this line as special for below
            [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
            %'fffffffffffffff',funstr{i},kb
           end % if funstrwords_b{i}(ii)-temp2==1 || all(funstr{i}(tem
          end % if suborfun(temp1)==2
         end % if temp~=-1 %we've got our = sign just before the function call,
        end % if isempty(find(funstrwords_b{i}>parens(2))) && .
        
       end % if howmany>0      
      end % if ~inastring_f(funstr{i},
     end % if ~isempty(temp1)
    end % for ii=length(funstrwords{i}):-1:1
   end % if ~any(strcmp(funstrwords{i}{1},
  end % if length(funstrwords{i}>0)

  %Adjust subroutine calls and piece multi-segmented files together
  temp=strcmp('call',funstrwords{i});
  if any(temp)
   %Need to fix the segment calls
   temp=find(temp); temp=temp(1);
   if ~inastring_f(funstr{i},funstrwords_b{i}(temp))
    temp=temp+1;
    %temp=find(strcmpi(fun_name{temp1},funstrwords{i}));
    [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    temp2=[funstr{i}(1:funstrwords_b{i}(temp-1)-1),'['];
    temp3=[]; fid=[];
    for ii=1:howmany
     %see if this subscript is in the form to be an output
     temp3(ii)=output_acceptable(i,temp,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,ii,howmany,subscripts,centercomma,parens,fun_name,statementFunction,localVar,fortranfunwords,var_words,this_fun_name,funwordsML,TFops,allTypeDefs);
     %Add that input to output list or put in dummyvar
    end

   goon=1;
    if any(temp3) %>0 outputs from the inputs
     for ii=1:howmany
      temp4=''; temp5='';
      if temp3(ii) %put in the copy of the input arg
       temp4=subscripts{ii};
      else %just put in a placeholder dummy output arg
       if any(temp3(ii:end))
        temp4=[dumvar,num2str(ii)];
       else
        goon=0;
       end
      end
      if ii<howmany
       if ~any(temp3(ii+1:end))
        goon=0;
       end
      end
      if ii~=howmany & goon~=0 %add a comma if not the last output arg
       temp4=[temp4,','];
      end
      temp2=[temp2,temp4];
     end
     temp2=[temp2,']='];
    else %none of the inputs are going to be outputs
     temp2=temp2(temp2~='[');
    end
%%%    if i==81
%%%     'ddddddddddd',find(~cellfun('isclass',funstr,'char')), kb
%%%    end
    if temp6
     funstr{i}=[temp2,funstrwords{i}{temp},funstr{i}(funstrwords_e{i}(temp)+1:end)];
    else % we have to remove the first var in the call (from above)
     temp7=[parens(1),centercomma,parens(2)];
     funstr{i}=[temp2,funstrwords{i}{temp},'(',funstr{i}(temp7(2)+1:end)];
    end
    [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
    
   
   end
  end

   % also have to do the handle thing on function calls
%%%          if strcmp(this_fun_name,'cdriv3')
%%%           ';;;;;;;;;;',funstr{i},kb
%%%          end

%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem with Fixing up the function definitions and calls')
%%%  warning(funstr{i})
%%% end
end

%'qweeeeeeeeeeeee',funstr,kb

% fix matrix=scalar assignments
for i=fs_good
%%% try
  if ~isempty(funstrwords{i})
%%%         if strcmp(funstrwords{i}{1},'bkgsum')
%%%          'iiiiiiiiiiii',funstr{i},keyboard
%%%         end
   temp6=find(strcmp(funstrwords{i}{1},{localVar{:,1}}));
   goon=0;
   if ~isempty(temp6) && ~strcmp(localVar{temp6,3},'character') && length(localVar{temp6,5})>0
    goon=1; 
   end
   %if ~isempty(temp6) && ~strcmp(localVar{temp6,3},'character') && ~strcmp(localVar{temp6,3},'string') && localVar{temp6,2}>0, goon=1; end
   % this may also be a var in the used module
   temp7={};
   temp7=varInUsedMods(funstrwords{i}{1},modLocalVar,usedMods);
   if ~isempty(temp7) && ~strcmp(temp7{3},'character') && ~strcmp(temp7{3},'string') && ~isempty(temp7{5}), goon=1; end
   if goon
    [howmany,subscripts,centercomma,parens]=hassubscript_f(i,1,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
    if howmany==0 %not subscripted, but has >0 dimensions
     [temp3,temp4,temp5]=getTopLevelStrings(funstr{i},funstrwords_e{i}(1),'=',i,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
     
     %only one word before the first equals
     if ~isempty(temp3) & temp4==0
      if length(find(funstrwords_b{i}<temp3(1)))==1

       % and only one number or scalar after
       goonimag=1;

%%%       if length(find(funstrwords_b{i}>temp5))==1
%%%        %if (length(find(funstrwords_b{i}>temp5)) + length(find(funstrnumbers_b{i}>temp5)))==1
%%%        goonimag=1;
%%%        fid=find(funstrwords_b{i}>temp5);
%%%        if ~isempty(fid)
%%%         temp4=find(strcmp({localVar{:,1}},funstrwords{i}{fid}));
%%%         if ~isempty(temp4)
%%%          if length(localVar{temp4,5})>0
%%%           goonimag=0;
%%%          end % if localVar{temp4,
%%%         else
%%%          % it must be in the mod list
%%%          temp7={};
%%%          temp7=varInUsedMods(funstrwords{i}{fid},modLocalVar,usedMods);
%%%          if ~isempty(temp7) && ~isempty(temp7{5}), goonimag=0; end
%%%         end
%%%        end % if ~isempty(fid)
%%%       end % if length(find(funstrwords_b{i}>

       temp8=find(funstr{i}=='=');
       if ~isempty(temp8)
        %if ~goonimag && ~isempty(temp8)
        j=find(funstrwords_b{i}>temp8(1),1,'first');
        if ~isempty(j)
         while j<=length(funstrwords{i})
          %'fdddddddd',funstr{i},j,kb
          if any(strcmp(funstrwords{i}{j},{'zeros','ones'})), goonimag=0; break; end
          [temp7,temp9,temp0]=varType(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,localVar,typeDefs,var_words);
          if ~isempty(temp9)
           if ~strcmp(temp9{3},'character') 
            if isempty(temp9{5})
             goonimag=1;
            else
             [howmany2,subscripts2,centercomma2,parens2]=hassubscript_f(i,temp0,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
             if isempty(parens2)
              goonimag=0; break;
             end
            end
           end
          end
          j=temp0+1;
         end % while j<=length(funstrwords{i})
        end % if ~isempty(j)
       end % if ~goonimag && ~isempty(temp8)
       
       temp9=find(funstr{i}==':');
       if ~isempty(temp8) && ~isempty(temp9)
        temp9=temp9(temp9>temp8(1));
        if any(validSpot(funstr{i},temp9))
         goonimag=0;
        end % if any(validSpot(funstr{i},
       end % if ~isempty(temp8) && ~isempty(temp9)
       
       if goonimag
        funstr{i}=[funstr{i}(1:funstrwords_e{i}(1)),'(:)',funstr{i}(funstrwords_e{i}(1)+1:end)];
        [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
       end
      end % if length(find(funstrwords_b{i}<temp3(1)))==1 
     end % if ~isempty(temp3) & isempty(temp4)
    end % if howmany==0 %not subscripted,
        %end % if localVar{temp6,
   end % if goon
  end % if ~isempty(funstrwords{i})
%%% catch
%%%  numErrors=numErrors+1;
%%%  disp('problem fixing matrix=scalar assignments')
%%%  warning(funstr{i})
%%% end
end % for i=fs_good


%'poiuy',funstr.',keyboard



%a fix() on the rhs of assignments
if want_fi
 temp8={localVar{find(strcmp({localVar{:,3}},'integer')),1}};
 for i=fs_good
%%%  try
   for j=length(funstrwords{i}):-1:1
    temp=find(strcmp(funstrwords{i}{j},temp8));
    if ~isempty(temp)
     if ~inastring_f(funstr{i},funstrwords_b{i}(j)) & ~incomment(funstr{i},funstrwords_b{i}(j))
      fid=1; %rhs default
             %is it on the rhs or lhs?
      temp1=find(funstr{i}=='=');
      [temp3,temp4,temp5]=getTopLevelStrings(funstr{i},funstrwords_b{i}(j),';',i,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
      if ~isempty(temp1)
       temp1=temp1(temp1>temp4(1));
       %temp1=temp1(1);
      else
       temp1=0;
      end
      if ~any(strcmp(funstrwords{i}{1},keywordsbegin))
       if temp1>funstrwords_b{i}(j)
        fid=0;
       end % if temp1>funstrwords_b{i}(j)
      else
       fid=2;
      end
      if strcmp(funstrwords{i}{1},'for')
       if temp1>funstrwords_b{i}(j)
        fid=2;
       end % if temp1>funstrwords_b{i}(j)
      end     
      if strcmp(funstrwords{i}{1},'function')
       fid=2;
      end
      if ~isempty(strfind(funstr{i},varPrefix)) % is this a var dec line?
       fid=2;
      end
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if howmany==0, parens(1)=funstrwords_b{i}(j);parens(2)=funstrwords_e{i}(j); end
      if fid==1
      elseif fid==0
       temp2=find(~isspace(funstr{i}));  temp2=temp2(temp2>temp4(1));  temp2=temp2(1);
       if temp2==funstrwords_b{i}(j)
        goon=1;
        temp6=find(funstrnumbers_b{i}>=temp1+1 & funstrnumbers_b{i}<=temp5(1)-1);
        temp7=find(funstrwords_b{i}>=temp1+1 & funstrwords_b{i}<=temp5(1)-1);
        if length(temp6)==1 & isempty(temp7)
         if isempty(find(funstrnumbers{i}{temp6}=='.',1))
          goon=0;
         end
        end
        if goon
         temp1=nextNonSpace(funstr{i},temp1);
         %temp1,temp9,funstr{i},'//////////',kb
         funstr{i}=[funstr{i}(1:temp1-1),'fix(',funstr{i}(temp1:temp5(1)-1),');',funstr{i}(temp5(1)+1:end)];
         %funstr{i}=[funstr{i}(1:temp1),'fix(',funstr{i}(temp1+1:temp5(1)-1),');',funstr{i}(temp5(1)+1:end)];
        end
       end
      else % do nothing
      end % if fid
     end % if ~inastring_f(funstr{i},
    end % if ~isempty(temp)
   end % for j=length(funstrwords{i}):-1:1
%%%  catch
%%%   numErrors=numErrors+1;
%%%   disp('problem with put a fix() around delcared ints (rhs), or a fix() when on rhs')
%%%   warning(funstr{i})
%%%  end
 end % for i=fs_good
end




% fix persistent var decs
%for ii=1:s, funstr{ii}=strrep(funstr{ii},'%%__%%__',''); end
funstr=strrep(funstr,'%%__%%__','');

[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);
tempstr=strrep({funstr{fs_good}},'(/','[');[funstr{fs_good}]=deal(tempstr{:});
tempstr=strrep({funstr{fs_good}},'/)',']');[funstr{fs_good}]=deal(tempstr{:});

%'reeeeeeee44444444',funstr,keyboard


%put curly braces around string arrays (became cells)
%this must be the last call to hassubscript if you care about not finding bracketized subscripts
for i=fs_good
 for j=1:length(funstrwords{i})
  temp=find(strcmp(funstrwords{i}{j},{localVar{:,1}}));
  if ~isempty(temp)
   if validSpot(funstr{i},funstrwords_b{i}(j))
%%%    if strcmp(funstrwords{i}{1},'yymmdd')
%%%     'iiiiiiiiiiii',funstr{i},keyboard
%%%    end
    [temp5,temp6,temp7]=varType(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,localVar,allTypeDefs,var_words);
    if strcmp(temp5,'character') && length(temp6{5})>0
     [howmany,subscripts,centercomma,parens]=hassubscript_f(i,temp7,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
     if howmany>0
      %if strcmp(funstrwords{i}{j},'fmt'), 'ooooooo',funstr{i},kb,end
      funstr{i}(parens(1))='{';
      funstr{i}(parens(2))='}';
      % cell_var{r1:r2} cell variables passed into a subroutine 
      %  (with a colon in their subscript) need {} around them
      if any(funstr{i}(parens(1)+1:parens(2)-1)==':')
       [outflag2,howmany2,subscripts2,centercomma2,parens2]=inwhichlast_f(i,funstrwords_b{i}(j),funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords,filename);
       if outflag2==1
        temp3=find(lastNonSpace(funstr{i},parens2(1))==funstrwords_e{i});
        if ~isempty(temp3)
         temp4=find(strcmpi(funstrwords{i}{temp3},fun_name));
         if ~isempty(temp4)
          %put curly braces around this
          funstr{i}=[funstr{i}(1:funstrwords_b{i}(j)-1),'{',...
                     funstr{i}(funstrwords_b{i}(j):parens(2)),'}',funstr{i}(parens(2)+1:end)];
          [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
          %'ddddddddddd',funstr{i},kb
         end % if ~isempty(temp4)
        end % if ~isempty(temp3)
       end % if outflag2==1
      
       % cell arrays = string need some help too
       temp9=nextNonSpace(funstr{i},parens(2));
       %'pppppppp',funstr{i},keyboard
       if ~isempty(temp9)
        if funstr{i}(temp9)=='='
        temp8=nextNonSpace(funstr{i},temp9);
        funstr{i}=[funstr{i}(1:funstrwords_b{i}(j)-1),...
                   'for tempi=1:numel(',funstr{i}(funstrwords_b{i}(j):parens(2)),...
                   '); ',funstrwords{i}{j},'{tempi}=',funstr{i}(temp8:end-1),'; end'];
%%%        funstr{i}=[funstr{i}(1:funstrwords_b{i}(j)-1),...
%%%                   '[',funstr{i}(funstrwords_b{i}(j):parens(2)),...
%%%                   '] = deal(',funstr{i}(temp8:end-1),');'];
        %funstr{i},'ggggggggg',kb
        [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
        end % if funstr{i}(nextNonSpace(funstr{i},
       end % if funstr{i}(temp9)=='='
       
      end % if any(funstr{i}(parens(1)+1:parens(2)-1)==':')
     end % if howmany>0
    end % if strcmp(localVar{temp(1),
   end % if ~inastring_f(funstr{i},
  end % if ~isempty(temp)
 end % for j=1:length(funstrwords{i})
end % for i=fs_good




%remove any trailing end? (could this be a legit end?)
if ~isempty(fs_good)
 if length(funstrwords{fs_good(end)})>0
  if strcmp(funstrwords{fs_good(end)}{1},'end') %& ~subfun
   funstr{fs_good(end)}=strrep(funstr{fs_good(end)},';','');
   [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,fs_good(end));
  end
 end % if length(funstrwords{fs_good(end)})>0
end



% recursive functions may get in trouble with var vs function calls if there is no result()
temp8='Result';
if ~ismod && suborfun(whichsub)==2
 if ~any(strcmp(funstrwords{1},'result'))
  for i=fs_good
   funstr{i}=regexprep(funstr{i},['([^\w]|^)(',this_fun_name,')([^\w])'],['$1$2',temp8,'$3']);
   %funstr{i}=regexprep(funstr{i},['(',this_fun_name,')([^\w])'],['$1',temp8,'$2']);
   % now fix any inline functions
   funstr{i}=regexprep(funstr{i},['@',this_fun_name,temp8,'([^\w])'],['@',this_fun_name,'$1']);
   [s,fs_good]=updatefunstr_1line_f(funstr,fs_good,i);
   %is this a recursive call? if so, remove the result
   temp=find(strcmp(funstrwords{i},[this_fun_name,temp8]));
   if ~isempty(temp)
    %'eeeeeeeeeeeeeeee',funstr{i},kb
    for j=temp(:)'
     temp1=lastNonSpace(funstr{i},funstrwords_b{i}(j));
     if temp1~=0 && funstr{i}(temp1)=='='
      [howmany,subscripts,centercomma,parens]=hassubscript_f(i,j,funstr,funstrnumbers,funstrnumbers_b,funstrnumbers_e,funstrwords,funstrwords_b,funstrwords_e,funwords);
      if howmany==length(funargs)
       funstr{i}=[funstr{i}(1:funstrwords_b{i}(j)-1),this_fun_name,funstr{i}(parens(1):end)];
       %funstr{i}=regexprep(funstr{i},[this_fun_name,temp8,'\s*\('],[this_fun_name,'(']);
      end
     end
    end
   end
  end
  % now fix the function def
  %'dddddddddd',funstr{i},kb
  funstr{1}=regexprep(funstr{1},[this_fun_name,temp8,'\s*\('],[this_fun_name,'(']);
  %funstr{1}=strrep(funstr{1},[this_fun_name,temp8,'('],[this_fun_name,'(']);
 end % if ~any(strcmp(funstrwords{1},
end % if suborfun==2

%'fffffffff',funstr,keyboard

% put the resizing of assumed sized arrays before all return statements and at the end.
% also add the caller assignments for functions
% assign fortran function variables in the caller's workspace
if subfun && ~ismod
 temp5=s;
 temp=regexp(funstr,'\<end\>');
 temp=find(~cellfun('isempty',temp));
 temp1=regexp(funstr,'\<return\>');
 temp1=find(~cellfun('isempty',temp1));
 if ~isempty(temp)
  for i=length(temp):-1:1
   if ~isempty(funstrwords{temp(i)})
    temp3=find(strcmp(funstrwords{temp(i)},'end'));    temp3=temp3(1);
    if validSpot(funstr{temp(i)},funstrwords_b{temp(i)}(temp3))
     temp5=temp(i);
     break
    end % if validSpot(funstr{i},
   end % if ~isempty(funstrwords{i})
  end % for i=length(temp):-1:1
 end
 temp1(temp1>temp5)=[];
 if ~isempty(temp1)
  goon=1;
  for i=temp5-1:-1:temp1(end)+1
   if ~isempty(funstrwords{i})
    goon=0;
   end % if ~isempty(funstrwords{i})
  end  
  if goon, temp5=temp1(end); end
 end
 %'deeeeeeeffffffffff',funstr.',kb
 tempstr={};
 if want_smm && ~isempty(needRS)
  for i=1:length(needRS)
   temp7='zeros';
   temp8=find(strcmpi(needRS{i},{localVar{:,1}}));
   if ~isempty(temp8) && strcmp(localVar{temp8,3},'character') && ~isempty(localVar{temp8,5})
    temp7='cell';
   end
   tempstr{length(tempstr)+1}=[needRS{i},shapeVar,'=',temp7,'(',needRS{i},shapeVar,');',...
                       needRS{i},shapeVar,'(1:numel(',needRS{i},'))=',needRS{i},';',...
                       needRS{i},'=',needRS{i},shapeVar,';'];
  end % for i=1:length(needRS)
 end
 %tempstr={r,'%%%%% fortran allows functions to modify input arguments in the','%%%%% caller''s workspace, so we need to let matlab do so as well'};
 if suborfun(whichsub)==2
  for i=size(localVar,1):-1:1
   if ~isempty(localVar{i,13}) && localVar{i,13}>0 && ...
        ( isempty(localVar{i,10}) || (~isempty(localVar{i,10}) && localVar{i,10}>1))
    
    if any(strcmp(localVar{i,1},{funwords{:},fortranVarOrRes{:},funwordsML{:}}))
     temp4=MLapp;
    else
     temp4='';
    end
    temp6=''; if ~isempty(localVar{i,14}), temp6=['nargin>=',num2str(localVar{i,13}),'&&']; end
    tempstr{length(tempstr)+1}=['if ',temp6,'~isempty(inputname(',num2str(localVar{i,13}),')),',...
                        ' assignin(''caller'',''FUntemp'',', localVar{i,1},temp4,'); ',...
                        'evalin(''caller'',[inputname(',num2str(localVar{i,13}),...
                        '),''=FUntemp;'']); end'];
%%%    tempstr{length(tempstr)+1}=['if ~isempty(inputname(',num2str(localVar{i,13}),')),',...
%%%                        ' assignin(''caller'',''FUntemp'',', localVar{i,1},temp4,'); ',...
%%%                        'evalin(''caller'',[inputname(',num2str(localVar{i,13}),...
%%%                        '),''=FUntemp;'']); end'];
%%%   tempstr{length(tempstr)+1}=['if ~isempty(inputname(',num2str(localVar{i,13}),')) && ',...
%%%                       '~any(inputname(',num2str(localVar{i,13}),')==''.'')',',',...
%%%                       ' assignin(''caller'',inputname(',num2str(localVar{i,13}),...
%%%                       '),', localVar{i,1},'); end'];
   end % if localVar{i,
  end % for i=1:size(localVar,
 end % if suborfun(whichsub)==2
 %tempstr{length(tempstr)+1}='';
 if ~isempty(tempstr)
  temp6=length(tempstr);
  funstr(temp5+temp6:end+temp6)=funstr(temp5:end);
  funstr(temp5:temp5+temp6-1)=tempstr;
  fs_good=sort(unique([fs_good,temp5:temp5+temp6-1]));
  s=s+temp6; 
  % now we also have to put this in front of every return
  %'gfgfgfgfgfgfgfgfg',kb
  temp7=find(~cellfun('isempty',regexp(funstr,'\<return\>')));
   if ~isempty(temp7)
   for i=length(temp7):-1:1
    if temp7(i)<temp5
     temp8=strfind(funstr{temp7(i)},'return');
     if ~inastring_f(funstr{temp7(i)},temp8) && ~inaDQstring_f(funstr{temp7(i)},temp8) && ...
          ~incomment(funstr{temp7(i)},temp8) && length(funstrwords{temp7(i)})==1
      funstr(temp7(i)+temp6:end+temp6)=funstr(temp7(i):end);
      funstr(temp7(i):temp7(i)+temp6-1)=tempstr;
      %'fgfgfgfgfgf',funstr,kb
     end % if ~inastring_f(funstr{temp7(i)},
    end % if temp7(i)<temp5)
   end % for i=1:length(temp7)
  end % if ~isempty(temp)  
 end % if ~isempty(tempstr) 
end % if subfun && ~ismod && suborfun(whichsub)














%%%% put the resizing of assumed sized arrays before all return statements and at the end.
%%%% also add the caller assignments for functions
%%%tempstr='';
%%%if ~isempty(needRS)
%%% for i=1:length(needRS)
%%%  tempstr=[tempstr,needRS{i},shapeVar,'=zeros(',needRS{i},shapeVar,');',...
%%%           needRS{i},shapeVar,'(1:numel(',needRS{i},'))=',needRS{i},';',...
%%%           needRS{i},'=',needRS{i},shapeVar,';'];
%%%  
%%% end % for i=1:length(needRS)
%%%     %find the last end, with a possible return before it.
%%% temp5=s;
%%% temp=regexp(funstr,'\<end\>');
%%% temp=find(~cellfun('isempty',temp));
%%% temp1=regexp(funstr,'\<return\>');
%%% temp1=find(~cellfun('isempty',temp1));
%%% if ~isempty(temp)
%%%  for i=length(temp):-1:1
%%%   if ~isempty(funstrwords{temp(i)})
%%%    temp3=find(strcmp(funstrwords{temp(i)},'end'));    temp3=temp3(1);
%%%    if validSpot(funstr{temp(i)},funstrwords_b{temp(i)}(temp3))
%%%     temp5=temp(i);
%%%     break
%%%    end % if validSpot(funstr{i},
%%%   end % if ~isempty(funstrwords{i})
%%%  end % for i=length(temp):-1:1
%%% end
%%% temp1(temp1>temp5)=[];
%%% if ~isempty(temp1)
%%%  goon=1;
%%%  for i=temp5-1:-1:temp1(end)+1
%%%   if ~isempty(funstrwords{i})
%%%    goon=0;
%%%   end % if ~isempty(funstrwords{i})
%%%  end  
%%%  if goon, temp5=temp1(end); end
%%% end
%%% funstr(temp5+1:end+1)=funstr(temp5:end);
%%% funstr{temp5}=[tempstr];
%%% s=s+1; 
%%%end % for i=1:length(needRS)
%%%
%%%% assign fortran function variables in the caller's workspace
%%%if subfun && ~ismod && suborfun(whichsub)==2
%%% temp5=s;
%%% temp=regexp(funstr,'\<end\>');
%%% temp=find(~cellfun('isempty',temp));
%%% temp1=regexp(funstr,'\<return\>');
%%% temp1=find(~cellfun('isempty',temp1));
%%% if ~isempty(temp)
%%%  for i=length(temp):-1:1
%%%   if ~isempty(funstrwords{temp(i)})
%%%    temp3=find(strcmp(funstrwords{temp(i)},'end'));    temp3=temp3(1);
%%%    if validSpot(funstr{temp(i)},funstrwords_b{temp(i)}(temp3))
%%%     temp5=temp(i);
%%%     break
%%%    end % if validSpot(funstr{i},
%%%   end % if ~isempty(funstrwords{i})
%%%  end % for i=length(temp):-1:1
%%% end
%%% temp1(temp1>temp5)=[];
%%% if ~isempty(temp1)
%%%  goon=1;
%%%  for i=temp5-1:-1:temp1(end)+1
%%%   if ~isempty(funstrwords{i})
%%%    goon=0;
%%%   end % if ~isempty(funstrwords{i})
%%%  end  
%%%  if goon, temp5=temp1(end); end
%%% end
%%% %'deeeeeeeffffffffff',funstr.',kb
%%% %tempstr={r,'%%%%% fortran allows functions to modify input arguments in the','%%%%% caller''s workspace, so we need to let matlab do so as well'};
%%% tempstr={};
%%% for i=size(localVar,1):-1:1
%%%  if ~isempty(localVar{i,13}) && localVar{i,13}>0 && ...
%%%       ( isempty(localVar{i,10}) || (~isempty(localVar{i,10}) && localVar{i,10}>1))
%%%   
%%%   if any(strcmp(localVar{i,1},{funwords{:},fortranVarOrRes{:},funwordsML{:}}))
%%%    temp4=MLapp;
%%%   else
%%%    temp4='';
%%%   end
%%%   tempstr{length(tempstr)+1}=['if ~isempty(inputname(',num2str(localVar{i,13}),')),',...
%%%                       ' assignin(''caller'',''FUntemp'',', localVar{i,1},temp4,'); ',...
%%%                       'evalin(''caller'',[inputname(',num2str(localVar{i,13}),...
%%%                       '),''=FUntemp;'']); end'];
%%%%%%   tempstr{length(tempstr)+1}=['if ~isempty(inputname(',num2str(localVar{i,13}),')) && ',...
%%%%%%                       '~any(inputname(',num2str(localVar{i,13}),')==''.'')',',',...
%%%%%%                       ' assignin(''caller'',inputname(',num2str(localVar{i,13}),...
%%%%%%                       '),', localVar{i,1},'); end'];
%%%  end % if localVar{i,
%%% end % for i=1:size(localVar,
%%% %tempstr{length(tempstr)+1}='';
%%% if ~isempty(tempstr)
%%%  temp6=length(tempstr);
%%%  funstr(temp5+temp6:end+temp6)=funstr(temp5:end);
%%%  funstr(temp5:temp5+temp6-1)=tempstr;
%%%  fs_good=sort(unique([fs_good,temp5:temp5+temp6-1]));
%%%  s=s+temp6; 
%%%  % now we also have to put this in front of every return
%%%  %'gfgfgfgfgfgfgfgfg',kb
%%%  temp7=find(~cellfun('isempty',regexp(funstr,'\<return\>')));
%%%   if ~isempty(temp7)
%%%   for i=length(temp7):-1:1
%%%    if temp7(i)<temp5
%%%     temp8=strfind(funstr{temp7(i)},'return');
%%%     if ~inastring_f(funstr{temp7(i)},temp8) && ~inaDQstring_f(funstr{temp7(i)},temp8) && ...
%%%          ~incomment(funstr{temp7(i)},temp8) && length(funstrwords{temp7(i)})==1
%%%      funstr(temp7(i)+temp6:end+temp6)=funstr(temp7(i):end);
%%%      funstr(temp7(i):temp7(i)+temp6-1)=tempstr;
%%%      %'fgfgfgfgfgf',funstr,kb
%%%     end % if ~inastring_f(funstr{temp7(i)},
%%%    end % if temp7(i)<temp5)
%%%   end % for i=1:length(temp7)
%%%  end % if ~isempty(temp)  
%%% end % if ~isempty(tempstr) 
%%%end % if subfun && ~ismod && suborfun(whichsub)










[funstr,funstrwords,funstrwords_b,funstrwords_e,funstrnumbers,funstrnumbers_b,funstrnumbers_e,s,fs_good]=updatefunstr_f(funstr);

%'eeeeeeeeeee',funstr.',kb

%Now put in required variable initializations
%%%temp2=fs_good(min(2,length(fs_good)));temp1=0;fid=1;
%%%temp3=regexp(funstr,'\<(function)'); %This ignores whitespace at the beginning of the line
%%%temp3=find(~cellfun('isempty',temp3));
%%%for i=temp3(:).'
%%% if any(i==fs_good)
%%%  if length(intersect({'function',fun_name{:}},funstrwords{i}))==2
%%%   temp=intersect(fun_name,funstrwords{i});
%%%   temp1=find(strcmpi(temp,fun_name));
%%%  end
%%% end
%%%end
insertExtra=0;
if length(fs_good)>0
 insertExtra=fs_good(min(2,length(fs_good)));
end
fid=0;
if ~isempty(fundecline)
 fid=find(strcmpi(this_fun_name,fun_name));
end

%Construct filestr adding in initializations including persistent var declarations
filestr=[];
temp3={'','','',''};
%fid=temp1;
for i=1:s
 if exist('inout','var')
  %put in the persistence vars at the beginning
  if i==insertExtra
   %'aaaaaaaaaaaaaaa',filestr,kb
   if suborfun(whichsub)==2     %initialize function result if need be
    temp3{1}=[this_fun_name,'Result=[];'];
   end
   if ~isempty(persistentVars)
    temp3{2}=['persistent '];
    for ii=1:length(persistentVars)
     temp3{2}=[temp3{2},persistentVars{ii},' '];
    end % for ii=1:length(persistentVars)
   end
%%%   %let's piggyback the optional arg clearing on the back of the persistent decs
%%%   if any(~cellfun('isempty',{origLocalVar{:,14}}))
%%%    temp3{2}=[temp3{2},r];
%%%   end
%%%   for j=size(origLocalVar,1):-1:2
%%%    if ~isempty(origLocalVar{j,14})
%%%     temp3{2}=[temp3{2},'if exist(''',origLocalVar{j,1},''',''var'') && isempty(',origLocalVar{j,1},'), clear ',origLocalVar{j,1},', end;',r];
%%%    end
%%%   end
  end
  if i==insertExtra & ~isempty(inout) & fid~=0
   for j=1:length(inout{fid})
    % if this has been initialized in a module, then don't
    temp7={};
    temp7=varInUsedMods(inout{fid}{j},modLocalVar,usedMods);
%%%    if strcmp(inout{fid}{j},'dim_xc')
%%%     'reeeeeeee3333333',funstr,keyboard
%%%    end
    if isempty(temp7)
     temp3{3}=[temp3{3},inout{fid}{j},'=[];'];
    end
   end % for j=1:length(inout{fid})
  end % if i==insertExtra & ~isempty(inout) & fid~=0
 end % if exist('inout',
end % for i=1:s

%%%if want_lc
%%% if ~isempty(changeCase)
%%%  if want_MP
%%%   for i=1:length(tempcc)
%%%    temp3=regexprep(temp3,['\<',changeCase{i},'(\>|',MPstr{1},'\>|',MPstr{2},'\>)'],...
%%%                    [changeCase{i},'$1'],'ignorecase');
%%%   end
%%%  else
%%%   temp3=regexprep(temp3,tempcc,changeCase,'ignorecase');
%%%  end
%%%%%%  for i=1:length(changeCase)
%%%%%%   temp1=regexpi(funstr,tempcc{i});
%%%%%%   temp1=strfind(funstr,lower(changeCase{i}));
%%%%%%   temp2=find(~cellfun('isempty',temp1));
%%%%%%   for j=1:length(temp2)
%%%%%%    for k=1:length(temp1{temp2(j)})
%%%%%%%%%       if strcmp(this_fun_name,'test1')
%%%%%%%%%   'ttttttttttt',kb
%%%%%%%%%  end
%%%%%%     if validSpot(funstr{temp2(j)},temp1{temp2(j)}(k)) || ...
%%%%%%          ~isempty(strfind(funstr{temp2(j)},'...')) %then it's a struct so change it
%%%%%%      funstr{temp2(j)}(temp1{temp2(j)}(k):temp1{temp2(j)}(k)+length(changeCase{i})-1)=...
%%%%%%          changeCase{i};
%%%%%%     end % if validSpot(funstr{temp2(j)},
%%%%%%    end % for k=1:length(temp1{temp2(j)})
%%%%%%   end % for j=1:length(temp2)
%%%%%%  end % for i=1:length(changeCase)
%%%  
%%%  %protectSomeStrings
%%%  if want_MP
%%%   for i=1:length(tempcc)
%%%    tempstr=regexprep({funstr{fs_good}},...
%%%                      ['\<',changeCase{i},'(\>|',MPstr{1},'\>|',MPstr{2},'\>)'],...
%%%                      [changeCase{i},'$1'],'ignorecase');
%%%    [funstr{fs_good}]=deal(tempstr{:});   
%%%   end
%%%  else
%%%   tempstr=regexprep({funstr{fs_good}},tempcc,changeCase,'ignorecase');
%%%   [funstr{fs_good}]=deal(tempstr{:});
%%%  end
%%%
%%%
%%% end % if ~isempty(changeCase)
%%%end


for i=1:s
 if i==insertExtra
  %'gggggggggggggggg',kb
  if ~subfun && ~ismod 
   temp3{4}=['clear global; clear functions;',r];
   if want_cla
    temp3{4}=[temp3{4},'global GlobInArgs nargs',r,...
              'GlobInArgs={mfilename,varargin{:}}; nargs=nargin+1;'];
   end
   if want_gl
    for j=1:size(modLocalVar,1)
     temp3{4}=[temp3{4},r,modLocalVar{j,1}];
    end
   end
   filestr=[filestr,temp3{4},r];
  elseif want_cla
   if any(~cellfun('isempty',regexpi(funstr,'(\<nargs\>)|(\<getarg\>)')))
    temp3{4}=['global GlobInArgs nargs'];  
    filestr=[filestr,temp3{4},r];
   end % if ~isempty(regexpi(filestr,
  end % if ~subfun && ~ismod && want_cla
  if want_gl && subfun
   %add in global statement
   if ~isempty(globVar)
    temp4='global';
    for j=1:length(globVar)
     temp4=[temp4,' ',globVar{j}];
    end
    temp4=[temp4,r];
    filestr=[filestr,temp4];
    %'dddddddddddd',globVar,filestr,kb
   end % if ~isempty(globVar)
  end
 end
 if exist('inout','var')
  %put in the persistence vars at the beginning
  if i==insertExtra
   %'aaaaaaaaaaaaaaa',filestr,kb
   if suborfun(whichsub)==2     %initialize function result if need be
    filestr=[filestr,temp3{1},r];
   end
   if ~isempty(persistentVars)
    filestr=[filestr,temp3{2},r];
   end
  end
  if i==insertExtra & ~isempty(inout) & fid~=0
   filestr=[filestr,temp3{3},r];
   filestr=[filestr,funstr{i},r];
  else
   filestr=[filestr,funstr{i},r];
  end
 else
  filestr=[filestr,funstr{i},r];
 end
end

if want_lc
 if ~isempty(changeCase)
  %protectSomeStrings
  if want_MP
   for i=1:length(tempcc)
    filestr=regexprep(filestr,...
                      ['\<',changeCase{i},'(\>|',MPstr{1},'\>|',MPstr{2},'\>)'],...
                      [changeCase{i},'$1'],'ignorecase');
   end
  else
   filestr=regexprep(filestr,tempcc,changeCase,'ignorecase');
  end
 end % if ~isempty(changeCase)
end


%'pppppppppp',persistentVars,filestr,insertExtra,keyboard

if numErrors>0
 disp(['*** There were ',num2str(numErrors),' problems f2matlab encountered during conversion.'])
else
 disp(['    f2matlab finished ',this_fun_name,' normally'])
end

%Write converted file out
filestr=filestr(filestr~=char(9)); %Remove tabs from the file
;%also get rid of some things plusfort may have put there
filestr=strrep(filestr,['use f77kinds;',r],'');
filestr=strrep(filestr,['%*** Start of declarations rewritten by SPAG',r],'');
filestr=strrep(filestr,['%',r,...
                    '% COMMON variables',r,...
                    '%',r],'');
filestr=strrep(filestr,['%',r,...
                    '% Dummy arguments',r,...
                    '%',r],'');
filestr=strrep(filestr,['%',r,...
                    '% Local variables',r,...
                    '%',r],'');
filestr=strrep(filestr,['%',r,...
                    '%*** End of declarations rewritten by SPAG',r,...
                    '%',r],'');
filestr=strrep(filestr,',)',')');
if want_fi
%%% filestr=strrep(filestr,'fix(0)','0');
%%% filestr=strrep(filestr,'fix( 0)','0');
%%% filestr=strrep(filestr,'fix(0.0)','0');
%%% filestr=strrep(filestr,'fix( 0.0)','0');
%%% filestr=strrep(filestr,'fix(1)','1');
%%% filestr=strrep(filestr,'fix( 1)','1');
%%% filestr=strrep(filestr,'fix(1.0)','1');
%%% filestr=strrep(filestr,'fix( 1.0)','1');
 filestr=strrep(filestr,'fix(zeros(','(zeros(');
end
filestr=strrep(filestr,')(',',');
filestr=strrep(filestr,'$$$$$_$$$$$','.''');
filestr=strrep(filestr,'#####_#####','*');
filestr=strrep(filestr,varPrefix,'');
filestr=strrep(filestr,[';',r,';',r,'end;',r],['; end',r]);
filestr=strrep(filestr,[TFops{1,2},TFops{1,3}],TFops{1,2});
filestr=strrep(filestr,[TFops{2,2},TFops{2,3}],TFops{2,2});
filestr=regexprep(filestr,['\<type',MLapp,'\>'],'type','ignorecase');
filestr=strrep(filestr,DQ{1},'''''');
filestr=strrep(filestr,'[1:end]',':');

%Get rid of subprogram spag declarations
rets=findstr(r,filestr);
temp=regexp(filestr,'%\*--');
if ~isempty(temp)
 temp1=find(rets<temp(1)); temp1=temp1(end);
 temp2=find(rets>temp(1)); temp2=temp2(1);
 filestr=filestr([1:rets(temp1),rets(temp2)+1:end]);
end

% some small housekeeping tasks
filestr=strrep(filestr,';;',';');
filestr=strrep(filestr,';,',';');
%%%if want_lc
%%% temp=changeCase;
%%% for i=1:length(changeCase)
%%%  temp{i}=['\<',changeCase{i},'\>'];
%%% end
%%% %'hmmmmmmmmmmmm',changeCase,kb
%%% tic;filestr=regexprep(filestr,temp,changeCase,'ignorecase');'gggggggggggggggggggggggg',toc
%%%end
%'fiiiiiiiiiiiiii',filestr,kb

if ~subfun
 %attach subroutines and the final trailing end
 filestr=[filestr,filestr_subfun,r];
 %add extraFunctions as needed
 if ~isempty(extraFunctions)
  temp=getExtraFunctions(extraFunctions);
  %temp,keyboard
  filestr=[filestr,r,r,r,...
           '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%',r,...
           '%%%%%%%%%%% extra functions as needed by the translation %%%%%%%%%%%',r,r];
  filestr=[filestr,temp];
 end % if ~isempty(extraFunctions) 
 disp(['  time before post processing: ',num2str(cputime-tt1)])
 %'yyyyyyyyyyy'
 %filestr,kb
 if ~ismod
  fixScalarCalls
  addwritef
  addreadf
  addGetArg
 end
 %ilename_ml=regexprep(filename_ml,tempcc,changeCase,'ignorecase');
 fprintf(1,'    Writing file:  ');   fprintf(1,filename_ml);   fprintf(1,' ... ')
 fid=fopen(filename_ml,'w');  fprintf(fid,'%c',filestr);   fclose(fid);
end

if want_kb
 disp([' ']);
 if ~subfun
  disp(['Finished writing ',filename_ml,':'])
 end
 if length(funstr)<20
  showall_f(funstr,1);
 else
  showall_f(funstr(1:20),1);
  disp(['   . . .'])
 end
end
if ~subfun
 fprintf(1,'completed \n')
end
if ~subfun
 disp(['  Total time: ',num2str(cputime-tt1)])
end
if want_kb,'At the end.',keyboard; end
%showall_f(funstr),keyboard

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End f2matlab.


%%%        if any(strcmp(funstrwords{i},'none'))
%%%         'ffffffffff from bottom',funstr{i},keyboard
%%%        end        

%'sssssssssss',funstr{i},keyboard