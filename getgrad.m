function [gradx,grady] = getgrad(image)
%GETGRAD �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
h=fspecial("sobel");                    %sobel
gradx = filter2(h,image,'same');
grady = filter2(h',image,'same');
end

