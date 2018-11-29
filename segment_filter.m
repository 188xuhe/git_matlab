function [image_seg,g] = segment_filter(image,grad,m,n)
%SEGMENT_FILTER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%% �ݶ�ͼ���ֵ��
%grad=tofloat(grad);
image=double(image);
grad=grad/max(grad(:));
hp=imhist(grad);
hp(1)=0;
T=otsuthresh(hp);%�ɶԱȿ���graythresh
g=imbinarize(grad,T);
figure,imshow(g),title('�ָ�����');
%% ͼ��ָ�
image_seg=image .* g;
figure,imshow(image_seg,[0 255]),title('ͼ��ָ�');
%% 
% image_seg=image_g+255*(1-g);
% figure,imshow(image_seg,[0 255]),title('�������');
end

