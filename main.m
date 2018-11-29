clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
image1=image1(1:368,1:272);
[m,n] = size(image1);
figure, imshow(image1);%figure, imhist(image1);%show the figure

%% 直方图均衡化 
image1_g=guiyihua(image1,256);

%% 中值滤波
image1_medfilt = filter_med(image1_g);

%% 均值滤波
%加上效果并不好
%image1_meanfilt = filter_mean(image1_medfilt,3);
%image1_meanfilt = filter_mean(image1_meanfilt,3);

%% 梯度
[gradx,grady,grad,image1_angle] = getgrad(image1_medfilt,m,n,8);

%% 方向场图
%[block_dmap,theta] = block_dmap(gradx,grady,m,n);
 O = localOrientation(image1, 32);
 figure, plotOrientation(image1, O,  32); title('Orientation & Mask');
%% 分割
%块梯度分割
%image1_seg=segment_block(image1_medfilt,gradx,grady,m,n,5);
%梯度、大津分割   分割有些过度！！
[image1_seg,g]=segment_filter(image1_medfilt,grad,m,n);

%% 频率场
 %F = localFrequency(image1_seg, 32);
 F=8*ones(m,n);


%% 智能增强
 image1_enhance = spatialGabor(image1_seg, double(g), O, F, 32) .* g + 255*(1-g);
 figure, imshow(image1_enhance); title('Fingerprint Enhancement');
 
%% 二值化
[T,SM] = graythresh(image1_enhance);
image1_bw = im2bw (image1_enhance,T);
figure,imshow(image1_bw),title('二值化');
 
 
 
 
 
 
