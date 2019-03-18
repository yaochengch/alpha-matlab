%ALPHA   Alpha���Ե����ļ������ڲ����趨
%% ����ؼ�����
%  ����������Ŀ�Ĺؼ������������� 
%  ��Ʊ��Χ 
%  ��ʼ�� 
%  ������ 
%  ��ϴ�С 
%  ����Ƶ�� 
%  �ɱ� 
%  ��ʼ�ʱ�
%  ������

% ��Ʊ�����б�,������ȡ���ݣ�DataPretreatment�ļ������ɣ�
load('stocklist.mat')

% ��Ʊ��Χ������һ������ÿ�д���һ�������գ�ÿ�����ֶ�Ӧһ����Ʊ��DataPretreatment�ļ������ɣ�
load('StockPool_CSI300.mat')

%������ʼ�պͽ����գ��ֶ��޸ģ�
startdate = '2010-4-16';
enddate = '2014-9-18';

% ������
w = windmatlab;
tradingDates=datetime(w.tdays(startdate,enddate));
save tradingDates.mat tradingDates

% �������ԣ���ʾ���Ӻ������ʵ������߼�
% Case=1 ������ֵԽ��������Խ��
% Case=2 ������ֵԽС��������Խ��
Case = 1;
    
% ��Ϲ�Ʊ����
PortSize = 100;

% ����Ƶ�ʣ� HoldDays=20 ��ʾ����20�������պ󻻲�
HoldDays = 5;

% ���׳ɱ�
tradingCostofStock = 0.0025;

% ��ʼ�ɱ������Ϊ1������������Ϊ��ֵ���ߣ�
InitialCapital = 1;

% �޷��������� 
RisklessRet = 0.03;

% ��������
factorname = 'MAofRetAdjustedByStd20';

%% ��ȡ����
% ��ȡ��Ʊ��������
[TradeDate, OpenofStock, HighofStock, LowofStock, CloseofStock] = GetAndMergeMarketData(stkcdlist, startdate, enddate);

% ��ȡ�ڻ���������
[DateofIF, OpenofIF, CloseofIF] = GetTheIF888Data(startdate, enddate);

% ��ȡ��������
Factor = GetAndMergeFactorData(stkcdlist, startdate, enddate, factorname, Case);

%% ѡ��
stockIndice = StockSelection(StockPool, Factor, Case);

%% �ز�
[OpenPosDate, OpenPosPriceofStock, OpenPosPriceofIF, ClosePosDate, ClosePosPriceofStock, ClosePosPriceofIF, TradeTimes, RetofStockPortfolio, RetofIF, RetofFund, DynamicEquityofStock, DynamicEquityofIF, DynamicEquityofFund] ...
    = FactorBackTest(StockIndice, PortSize, HoldDays, TradeDate, OpenofStock, HighofStock, LowofStock, CloseofStock, OpenofIF, CloseofIF, TradingCostofStock, OpenofIF, CloseofIF, TradingCostofStock, OpenofIF, CloseofIF, TradingCostofStock, TradingCostofIF,  InitialCapital);
disp('�ز����')

%% ��������
StrategyEvaluation(CloseofCSI300, TradeDate, OpenPosPriceofStock, OpenPosPriceofIF, ClosePosPriceofStock, ClosePosPriceofIF, TradeTimes, RetofFund, DynamicEquityofStock, DynamicEquityofIF, DynamicEquityofFund, RisklessRet, TradingCostofStock, TradingCostofIF);
disp("�����ͼ")





