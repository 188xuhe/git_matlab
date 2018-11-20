clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
[m,n] = size(image1);
figure, imshow(image1);figure, imhist(image1);%show the figure

%直方图均衡化 
image1_g=guiyihua(image1,256);

%中值滤波
image1_medfilt=medfilt2(image1_g,'symmetric');
figure, imshow(image1_medfilt),title("image1_medfilt");%show the figure

%浮点型
image1_medfilt=tofloat(image1_medfilt);

%梯度
[gradx,grady] = getgrad(image1_medfilt);

%分割
segment(image1_medfilt,gradx,grady,m,n,5);

% %方向场
% r=5;
% h=fspecial("sobel");                    %sobel
% image=tofloat(image);
% gradx = filter2(h,image,'same');
% grady = filter2(h',image,'same');
% gradm=floor(m/r);
% gradn=floor(n/r);
% for i=1:1:gradm
%     for j=1:1:gradn
%         gradx_r=gradx((i-1)*r+1:i*r,(j-1)*r+1:j*r);
%         grady_r=grady((i-1)*r+1:i*r,(j-1)*r+1:j*r);
%         
%         grad((i-1)*r+1:i*r,(j-1)*r+1:j*r)=average*ones(r,r);
%     end
% end





