clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
[m,n] = size(image1);
figure, imshow(image1);%figure, imhist(image1);%show the figure

%直方图均衡化 
image1_g=guiyihua(image1,256);

%中值滤波
image1_medfilt=medfilt2(image1_g,'symmetric');
figure, imshow(image1_medfilt),title("image1_medfilt");%show the figure


%梯度
[gradx,grady,grad,angle] = getgrad(image1_medfilt,m,n,6);

%方向场图
%[block_dmap,theta] = block_dmap(gradx,grady,m,n);

%块梯度分割
%image1_seg=segment_block(image1_medfilt,gradx,grady,m,n,5);
%梯度、大津分割
image1_seg=segment_filter(image1_medfilt,grad,m,n);

%智能增强






