clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
[m,n] = size(image1);
figure, imshow(image1);%figure, imhist(image1);%show the figure

%ֱ��ͼ���⻯ 
image1_g=guiyihua(image1,256);

%��ֵ�˲�
image1_medfilt=medfilt2(image1_g,'symmetric');
figure, imshow(image1_medfilt),title("image1_medfilt");%show the figure


%�ݶ�
[gradx,grady,grad,angle] = getgrad(image1_medfilt,m,n,6);

%����ͼ
%[block_dmap,theta] = block_dmap(gradx,grady,m,n);

%���ݶȷָ�
%image1_seg=segment_block(image1_medfilt,gradx,grady,m,n,5);
%�ݶȡ����ָ�
image1_seg=segment_filter(image1_medfilt,grad,m,n);

%������ǿ






