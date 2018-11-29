clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
image1=image1(1:368,1:272);
[m,n] = size(image1);
figure, imshow(image1);%figure, imhist(image1);%show the figure

%% ֱ��ͼ���⻯ 
image1_g=guiyihua(image1,256);

%% ��ֵ�˲�
image1_medfilt = filter_med(image1_g);

%% ��ֵ�˲�
%����Ч��������
%image1_meanfilt = filter_mean(image1_medfilt,3);
%image1_meanfilt = filter_mean(image1_meanfilt,3);

%% �ݶ�
[gradx,grady,grad,image1_angle] = getgrad(image1_medfilt,m,n,8);

%% ����ͼ
%[block_dmap,theta] = block_dmap(gradx,grady,m,n);
 O = localOrientation(image1, 32);
 figure, plotOrientation(image1, O,  32); title('Orientation & Mask');
%% �ָ�
%���ݶȷָ�
%image1_seg=segment_block(image1_medfilt,gradx,grady,m,n,5);
%�ݶȡ����ָ�   �ָ���Щ���ȣ���
[image1_seg,g]=segment_filter(image1_medfilt,grad,m,n);

%% Ƶ�ʳ�
 %F = localFrequency(image1_seg, 32);
 F=8*ones(m,n);


%% ������ǿ
 image1_enhance = spatialGabor(image1_seg, double(g), O, F, 32) .* g + 255*(1-g);
 figure, imshow(image1_enhance); title('Fingerprint Enhancement');
 
%% ��ֵ��
[T,SM] = graythresh(image1_enhance);
image1_bw = im2bw (image1_enhance,T);
figure,imshow(image1_bw),title('��ֵ��');
 
 
 
 
 
 
