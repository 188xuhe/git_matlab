function image_seg = segment_filter(image,grad,m,n)
%SEGMENT_FILTER 此处显示有关此函数的摘要
%   此处显示详细说明
%% 梯度图像二值化
%grad=tofloat(grad);
image=double(image);
grad=grad/max(grad(:));
hp=imhist(grad);
hp(1)=0;
T=otsuthresh(hp);%可对比考虑graythresh
g=imbinarize(grad,T);
%% 图像分割
image_g=image .* g;
figure,imshow(image_g),title('图像分割');
%% 
image_seg=image_g+255*(1-g);
figure,imshow(image_seg,[0 255]),title('清除背景');
end

