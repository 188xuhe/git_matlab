function image_medfilt = filter_med(image)
%FILTER_MED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
image_medfilt=medfilt2(image,'symmetric');
figure, imshow(image_medfilt),title("��ֵ�˲�");%show the figure
end

