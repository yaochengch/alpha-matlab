function outp = randprice(n, startprice, seed)
%RANDPRICE 用于生成一系列股价，后一日股价与前一日股价相差[-10%,10%]
% n：生成股票价格的数量
% startprice： 起始价格
% seed: 随机数生成器种子

% 如果没有设置种子，则将种子设为0
if nargin <3
    seed = 0;
end



% 设置随机数生成器
rng(seed);
% 初始化
outp = zeros(n,1);

% 赋值
outp(1) = startprice;
for i=2:n
    outp(i) = outp(i-1) *( 0.2*rand(1)+0.9);

end


end