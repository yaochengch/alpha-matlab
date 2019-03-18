function StockIndice = StockSelection(StockPool, Factor, Case)
%STOCKSELECTION ����Ʊ�������Ӵ�С����ѡ������ʵ�����
%   StockPool����Ʊ��Χ������һ������ÿ�д���һ�������գ�ÿ�����ֶ�Ӧһֻ��
%   Ʊ�����һ�����øñ�����ԭ���ǣ�Factor�����п��԰�����ǧֻ��Ʊ��factor��
%   ���ҿ���ֻ��������300ֻ��Ʊ����ʱ��ֻ����StockPool��������300ֻ��Ʊ�����
%   ���ɡ����⣬����ͣ����Ĺ�Ʊ������ͨ����StockPool��������NaN�滻��Ӧ���
%   ������
%   Factor: ����ֵ��ÿ�д���һ�������գ�ÿ�д���һֻ��Ʊ������ȡֵ
%   Case�� ���Ӻ������ʵ��߼���Case=1��ʾ����ֵԽ�������ʿ���Խ�ߣ�Case=2��
%   ʾ����ֵԽС�������ʿ���Խ�͡�

% ��ʼ������
StockIndice = zeros(size(StockPool));

% ѭ����ÿ����������һ��
for i = 1: size(StockPool, 1)
  % ��Ʊ��Χ
  SubStockPool = StockPool(i,:);
  SubStockPool(isnan(SubStockPool) == 1) = [] ;
  
  % ����ֵ
  SubFactor= Factor(i,SubStockPool);
  
  % �ҳ��쳣ֵ
  OutliersIndice = (SubFactor > (mean(SubFactor)+3*std(SubFactor))) | ...
      (SubFactor < (mean(SubFactor)-3*std(SubFactor)));
  
  % ����1
  if Case == 1
      % ���쳣ֵ��Ϊ-inf
    SubFactor(OutliersIndice) = -inf;
      % ��������
     [~, Ind] = sort(SubFactor, 2, 'descend');
  end 
  
  
  % ����2
  if Case == 2
      % ���쳣ֵ��Ϊinf
    SubFactor(OutliersIndice) = inf;
      % ��������
     [~, Ind] = sort(SubFactor, 2, 'ascend');
  end
    StockIndice(i,1:length(SubStockPool)) = SubStockPool(Ind);
end