%% 用于将存有沪深300成份股数据的Excel表格转化为.mat数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\yaoch\Documents\matlab alpha\CsvFiles\hs300.xlsx
%    工作表: Wind
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2019/03/03 17:29:14

%% 导入数据
[~, ~, raw] = xlsread('C:\Users\yaoch\Documents\matlab alpha\CsvFiles\hs300.xlsx','Wind');
raw = raw(2:end,:);
stringVectors = string(raw(:,[1,2]));
stringVectors(ismissing(stringVectors)) = '';

%% 创建表
hs2 = table;

%% 将导入的数组分配给列变量名称
hs2.VarName1 = stringVectors(:,1);
hs2.VarName2 = stringVectors(:,2);

%% 清除临时变量
clearvars data raw stringVectors;

%% 将股票代码存储在.mat文件中，存储的文件名称为stkcdlist.mat   文件名称： stkcdlist
stkcdlist= hs2{:,1};
save stkcdlist.mat stkcdlist;

%% 清除临时变量
clearvars hs2 stkcdlist;