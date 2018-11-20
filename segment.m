function image_seg=segment(image,gradx,grady,m,n,r)
%r为块的尺寸
%% 计算图像的sobel梯度
grad=abs(gradx)+abs(grady);
grad=grad/max(grad(:));
figure,imshow(grad),title('grad');
%% 块梯度图
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
%% 阈值分割
p=imhist(grad_avr);
Q=percentile2i(p,0.09);
markImage=grad > Q;
figure, imshow(markImage),title('markImage');
image_fp=image .* markImage;
figure, imshow(image_fp),title('image fp 1');
%清除背景
markImage_con=(ones(m,n)-markImage)*255;
image_seg=image_fp + markImage_con;
figure, imshow(image_seg),title('image_seg');

%未来可以考虑对梯度图像求梯度，再进行大津算法的阈值分割





