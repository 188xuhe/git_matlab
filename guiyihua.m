function g=guiyihua(image,nlev)

g=histeq(image,nlev);
figure, imshow(g);title('直方图均衡化');%show the figure