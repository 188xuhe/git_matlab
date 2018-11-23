function image_meanfilt = filter_mean(image,r)
%FILTER_MEAN 此处显示有关此函数的摘要
%   r为均值滤波器的半径
w=fspecial('average', r);
image_meanfilt = imfilter(image, w, 'replicate');
figure,imshow(image_meanfilt,[0 256]),title('均值滤波');
end

