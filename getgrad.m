function [gradx,grady] = getgrad(image)
%GETGRAD 此处显示有关此函数的摘要
%   此处显示详细说明
h=fspecial("sobel");                    %sobel
gradx = filter2(h,image,'same');
grady = filter2(h',image,'same');
end

