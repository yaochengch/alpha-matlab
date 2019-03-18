function StockIndice = StockSelection(StockPool, Factor, Case)
%STOCKSELECTION 将股票依据因子大小排序，选择出合适的因子
%   StockPool：股票范围，这是一个矩阵，每行代表一个交易日，每个数字对应一只股
%   票。多次一举设置该变量的原因是，Factor变量中可以包含数千只股票的factor，
%   但我可以只关心其中300只股票，此时，只需在StockPool中列明这300只股票的序号
%   即可。此外，对于停牌类的股票，可以通过在StockPool变量中用NaN替换对应序号
%   来处理。
%   Factor: 因子值，每行代表一个交易日，每列代表一只股票的因子取值
%   Case： 因子和收益率的逻辑，Case=1表示因子值越大，收益率可能越高；Case=2表
%   示因子值越小，收益率可能越低。

% 初始化操作
StockIndice = zeros(size(StockPool));

% 循环：每个交易日做一次
for i = 1: size(StockPool, 1)
  % 股票范围
  SubStockPool = StockPool(i,:);
  SubStockPool(isnan(SubStockPool) == 1) = [] ;
  
  % 因子值
  SubFactor= Factor(i,SubStockPool);
  
  % 找出异常值
  OutliersIndice = (SubFactor > (mean(SubFactor)+3*std(SubFactor))) | ...
      (SubFactor < (mean(SubFactor)-3*std(SubFactor)));
  
  % 情形1
  if Case == 1
      % 将异常值设为-inf
    SubFactor(OutliersIndice) = -inf;
      % 因子排序
     [~, Ind] = sort(SubFactor, 2, 'descend');
  end 
  
  
  % 情形2
  if Case == 2
      % 将异常值设为inf
    SubFactor(OutliersIndice) = inf;
      % 因子排序
     [~, Ind] = sort(SubFactor, 2, 'ascend');
  end
    StockIndice(i,1:length(SubStockPool)) = SubStockPool(Ind);
end