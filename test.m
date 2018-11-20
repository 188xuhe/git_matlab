clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
[m,n] = size(image1);
figure, imshow(image1);%figure, imhist(image1);%show the figure

% for x=1:m
%  for y=1:n
%   M=M+I(x,y);
%  end
% end
% M1=M/(m*n);%均值
% 
% for x=1:m
%  for y=1:n
%   var=var+(image1(x,y)-M1)^2;
%  end
% end
% var1=var/(m*n);
% for x=1:m
%  for y=1:n
%   if image1(x,y)>=M1
%    image1(x,y)=150+sqrt(2000*(image1(x,y)-M1)/var1);
%   else
%    image1(x,y)=150-sqrt(2000*(M1-image1(x,y))/var1);
%   end
%  end
% end
% % figure, imshow(uint8(I));title('归一化');

[f_angle,f_grad] = FingerprintOrient_convolution_f(image1,6);


