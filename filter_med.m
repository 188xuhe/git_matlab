function image_medfilt = filter_med(image)
%FILTER_MED 此处显示有关此函数的摘要
%   此处显示详细说明
image_medfilt=medfilt2(image,'symmetric');
figure, imshow(image_medfilt),title("中值滤波");%show the figure
end

