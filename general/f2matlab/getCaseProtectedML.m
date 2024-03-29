function casePML=getCaseProtectedML
% these are the function in general, elmat, and elfun under toolbox matlab
casePML=cell(221,1);
casePML{1}='abs';
casePML{2}='accumarray';
casePML{3}='acos';
casePML{4}='acosd';
casePML{5}='acosh';
casePML{6}='acot';
casePML{7}='acotd';
casePML{8}='acoth';
casePML{9}='acsc';
casePML{10}='acscd';
casePML{11}='acsch';
casePML{12}='addpath';
casePML{13}='angle';
casePML{14}='ans';
casePML{15}='asec';
casePML{16}='asecd';
casePML{17}='asech';
casePML{18}='asin';
casePML{19}='asind';
casePML{20}='asinh';
casePML{21}='atan';
casePML{22}='atan2';
casePML{23}='atand';
casePML{24}='atanh';
casePML{25}='beep';
casePML{26}='binpatch';
casePML{27}='blkdiag';
casePML{28}='calllib';
casePML{29}='cat';
casePML{30}='cd';
casePML{31}='ceil';
casePML{32}='circshift';
casePML{33}='ckdepfun';
casePML{34}='clear';
casePML{35}='compan';
casePML{36}='complex';
casePML{37}='computer';
casePML{38}='conj';
casePML{39}='copyfile';
casePML{40}='cos';
casePML{41}='cosd';
casePML{42}='cosh';
casePML{43}='cot';
casePML{44}='cotd';
casePML{45}='coth';
casePML{46}='cplxpair';
casePML{47}='csc';
casePML{48}='cscd';
casePML{49}='csch';
casePML{50}='delete';
casePML{51}='depdir';
casePML{52}='depfun';
casePML{53}='depfunprophelper';
casePML{54}='desktop';
casePML{55}='diag';
casePML{56}='diary';
casePML{57}='dir';
casePML{58}='dos';
casePML{59}='echo';
casePML{60}='eps';
casePML{61}='exit';
casePML{62}='exp';
casePML{63}='expm1';
casePML{64}='eye';
casePML{65}='false';
casePML{66}='fileattrib';
casePML{67}='find';
casePML{68}='finfo';
casePML{69}='fix';
casePML{70}='flipdim';
casePML{71}='fliplr';
casePML{72}='flipud';
casePML{73}='floor';
casePML{74}='flops';
casePML{75}='format';
casePML{76}='freqspace';
casePML{77}='gallery';
casePML{78}='genpath';
casePML{79}='getenv';
casePML{80}='hadamard';
casePML{81}='hankel';
casePML{82}='hilb';
casePML{83}='hypot';
casePML{84}='i';
casePML{85}='imag';
casePML{86}='import';
casePML{87}='ind2sub';
casePML{88}='inf';
casePML{89}='inmem';
casePML{90}='intmax';
casePML{91}='intmin';
casePML{92}='invhilb';
casePML{93}='ipermute';
casePML{94}='isdeployed';
casePML{95}='isdir';
casePML{96}='isempty';
casePML{97}='isequal';
casePML{98}='isequalwithequalnans';
casePML{99}='isfinite';
casePML{100}='isinf';
casePML{101}='isnan';
casePML{102}='ispc';
casePML{103}='ispuma';
casePML{104}='isreal';
casePML{105}='isscalar';
casePML{106}='isstudent';
casePML{107}='isunix';
casePML{108}='isvector';
casePML{109}='j';
casePML{110}='java';
casePML{111}='javaaddpath';
casePML{112}='javaclasspath';
casePML{113}='javarmpath';
casePML{114}='length';
casePML{115}='libfunctions';
casePML{116}='libfunctionsview';
casePML{117}='libisloaded';
casePML{118}='libpointer';
casePML{119}='libstruct';
casePML{120}='linspace';
casePML{121}='load';
casePML{122}='loadlibrary';
casePML{123}='log';
casePML{124}='log10';
casePML{125}='log1p';
casePML{126}='log2';
casePML{127}='logspace';
casePML{128}='ls';
casePML{129}='magic';
casePML{130}='matlabpath';
casePML{131}='memory';
casePML{132}='meshgrid';
casePML{133}='mex';
casePML{134}='mex_helper';
casePML{135}='mexdebug';
casePML{136}='mkdir';
casePML{137}='mod';
casePML{138}='more';
casePML{139}='movefile';
casePML{140}='namelengthmax';
casePML{141}='nan';
casePML{142}='ndgrid';
casePML{143}='ndims';
casePML{144}='nextpow2';
casePML{145}='nthroot';
casePML{146}='numel';
casePML{147}='ones';
casePML{148}='open';
casePML{149}='pack';
casePML{150}='pascal';
casePML{151}='path';
casePML{152}='path2rc';
casePML{153}='pcode';
casePML{154}='perl';
casePML{155}='permute';
casePML{156}='pi';
casePML{157}='pow2';
casePML{158}='preferences';
casePML{159}='prepender';
casePML{160}='pwd';
casePML{161}='quit';
casePML{162}='rand';
casePML{163}='randn';
casePML{164}='real';
casePML{165}='reallog';
casePML{166}='realmax';
casePML{167}='realmin';
casePML{168}='realpow';
casePML{169}='realsqrt';
casePML{170}='recycle';
casePML{171}='rehash';
casePML{172}='rem';
casePML{173}='repmat';
casePML{174}='reshape';
casePML{175}='rmdir';
casePML{176}='rmpath';
casePML{177}='rosser';
casePML{178}='rot90';
casePML{179}='round';
casePML{180}='save';
casePML{181}='saveas';
casePML{182}='savepath';
casePML{183}='sec';
casePML{184}='secd';
casePML{185}='sech';
casePML{186}='setenv';
casePML{187}='shiftdim';
casePML{188}='sign';
casePML{189}='sin';
casePML{190}='sind';
casePML{191}='sinh';
casePML{192}='size';
casePML{193}='sqrt';
casePML{194}='squeeze';
casePML{195}='sub2ind';
casePML{196}='syntax';
casePML{197}='system';
casePML{198}='tan';
casePML{199}='tand';
casePML{200}='tanh';
casePML{201}='toeplitz';
casePML{202}='toolboxdir';
casePML{203}='tril';
casePML{204}='triu';
casePML{205}='true';
casePML{206}='type';
casePML{207}='unix';
casePML{208}='unloadlibrary';
casePML{209}='unwrap';
casePML{210}='usejava';
casePML{211}='vander';
casePML{212}='ver';
casePML{213}='what';
casePML{214}='which';
casePML{215}='who';
casePML{216}='whos';
casePML{217}='why';
casePML{218}='wilkinson';
casePML{219}='xgetselection';
casePML{220}='xsetselection';
casePML{221}='zeros';
