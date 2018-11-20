function image_seg=segment(image,gradx,grady,m,n,r)
%rΪ��ĳߴ�
%% ����ͼ���sobel�ݶ�
grad=abs(gradx)+abs(grady);
grad=grad/max(grad(:));
figure,imshow(grad),title('grad');
%% ���ݶ�ͼ
gradm=floor(m/r);
gradn=floor(n/r);
grad_div=zeros(r,r);
for i=1:1:gradm
    for j=1:1:gradn
        grad_div=grad((i-1)*r+1:i*r,(j-1)*r+1:j*r);
        average=sum(sum(grad_div))/(r*r);
        grad((i-1)*r+1:i*r,(j-1)*r+1:j*r)=average*ones(r,r);
    end
end
w=fspecial('average',5);
grad_avr=imfilter(grad,w,'replicate');
grad_avr=imfilter(grad_avr,w,'replicate');
figure,imshow(grad_avr),title('grad avr');
%% ��ֵ�ָ�
p=imhist(grad_avr);
Q=percentile2i(p,0.09);
markImage=grad > Q;
figure, imshow(markImage),title('markImage');
image_fp=image .* markImage;
figure, imshow(image_fp),title('image fp 1');
%�������
markImage_con=(ones(m,n)-markImage)*255;
image_seg=image_fp + markImage_con;
figure, imshow(image_seg),title('image_seg');

%δ�����Կ��Ƕ��ݶ�ͼ�����ݶȣ��ٽ��д���㷨����ֵ�ָ�





