%% ���ڽ����л���300�ɷݹ����ݵ�Excel���ת��Ϊ.mat����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: C:\Users\yaoch\Documents\matlab alpha\CsvFiles\hs300.xlsx
%    ������: Wind
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2019/03/03 17:29:14

%% ��������
[~, ~, raw] = xlsread('C:\Users\yaoch\Documents\matlab alpha\CsvFiles\hs300.xlsx','Wind');
raw = raw(2:end,:);
stringVectors = string(raw(:,[1,2]));
stringVectors(ismissing(stringVectors)) = '';

%% ������
hs2 = table;

%% ����������������б�������
hs2.VarName1 = stringVectors(:,1);
hs2.VarName2 = stringVectors(:,2);

%% �����ʱ����
clearvars data raw stringVectors;

%% ����Ʊ����洢��.mat�ļ��У��洢���ļ�����Ϊstkcdlist.mat   �ļ����ƣ� stkcdlist
stkcdlist= hs2{:,1};
save stkcdlist.mat stkcdlist;

%% �����ʱ����
clearvars hs2 stkcdlist;