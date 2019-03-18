%ALPHA   Alpha策略的主文件，用于参数设定
%% 定义关键参数
%  定义整个项目的关键参数，包括： 
%  股票范围 
%  起始日 
%  结束日 
%  组合大小 
%  换股频率 
%  成本 
%  初始资本
%  等内容

% 股票代码列表,用于提取数据（DataPretreatment文件夹生成）
load('stocklist.mat')

% 股票范围，这是一个矩阵，每行代表一个交易日，每个数字对应一个股票（DataPretreatment文件夹生成）
load('StockPool_CSI300.mat')

%测试起始日和结束日（手动修改）
startdate = '2010-4-16';
enddate = '2014-9-18';

% 交易日
w = windmatlab;
tradingDates=datetime(w.tdays(startdate,enddate));
save tradingDates.mat tradingDates

% 因子属性，表示因子和收益率的内在逻辑
% Case=1 因子数值越大，收益率越高
% Case=2 因子数值越小，收益率越高
Case = 1;
    
% 组合股票数量
PortSize = 100;

% 换仓频率， HoldDays=20 表示持有20个交易日后换仓
HoldDays = 5;

% 交易成本
tradingCostofStock = 0.0025;

% 初始成本（如果为1，则收益曲线为净值曲线）
InitialCapital = 1;

% 无风险收益率 
RisklessRet = 0.03;

% 因子名称
factorname = 'MAofRetAdjustedByStd20';

%% 提取数据
% 提取股票行情数据
[TradeDate, OpenofStock, HighofStock, LowofStock, CloseofStock] = GetAndMergeMarketData(stkcdlist, startdate, enddate);

% 提取期货行情数据
[DateofIF, OpenofIF, CloseofIF] = GetTheIF888Data(startdate, enddate);

% 提取因子数据
Factor = GetAndMergeFactorData(stkcdlist, startdate, enddate, factorname, Case);

%% 选股
stockIndice = StockSelection(StockPool, Factor, Case);

%% 回测
[OpenPosDate, OpenPosPriceofStock, OpenPosPriceofIF, ClosePosDate, ClosePosPriceofStock, ClosePosPriceofIF, TradeTimes, RetofStockPortfolio, RetofIF, RetofFund, DynamicEquityofStock, DynamicEquityofIF, DynamicEquityofFund] ...
    = FactorBackTest(StockIndice, PortSize, HoldDays, TradeDate, OpenofStock, HighofStock, LowofStock, CloseofStock, OpenofIF, CloseofIF, TradingCostofStock, OpenofIF, CloseofIF, TradingCostofStock, OpenofIF, CloseofIF, TradingCostofStock, TradingCostofIF,  InitialCapital);
disp('回测完成')

%% 策略评价
StrategyEvaluation(CloseofCSI300, TradeDate, OpenPosPriceofStock, OpenPosPriceofIF, ClosePosPriceofStock, ClosePosPriceofIF, TradeTimes, RetofFund, DynamicEquityofStock, DynamicEquityofIF, DynamicEquityofFund, RisklessRet, TradingCostofStock, TradingCostofIF);
disp("完成作图")





