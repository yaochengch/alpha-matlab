function outp = randprice(n, startprice, seed)
%RANDPRICE ��������һϵ�йɼۣ���һ�չɼ���ǰһ�չɼ����[-10%,10%]
% n�����ɹ�Ʊ�۸������
% startprice�� ��ʼ�۸�
% seed: ���������������

% ���û���������ӣ���������Ϊ0
if nargin <3
    seed = 0;
end



% ���������������
rng(seed);
% ��ʼ��
outp = zeros(n,1);

% ��ֵ
outp(1) = startprice;
for i=2:n
    outp(i) = outp(i-1) *( 0.2*rand(1)+0.9);

end


end