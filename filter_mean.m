function image_meanfilt = filter_mean(image,r)
%FILTER_MEAN �˴���ʾ�йش˺�����ժҪ
%   rΪ��ֵ�˲����İ뾶
w=fspecial('average', r);
image_meanfilt = imfilter(image, w, 'replicate');
figure,imshow(image_meanfilt,[0 256]),title('��ֵ�˲�');
end

