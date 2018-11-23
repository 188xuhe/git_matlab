clc
clear
close all
image1=imread('H:\ZKFinger SDK 5.0.0.20_20170424\ActiveX\samples\VC\Debug\fingerprint4.bmp');
[m,n] = size(image1);
figure, imshow(image1);%figure, imhist(image1);%show the figure

%% 直方图均衡化 
image1_g=guiyihua(image1,256);

%% 中值滤波
image1_medfilt = filter_med(image1_g);

%% 均值滤波
%加上效果并不好
%image1_meanfilt = filter_mean(image1_medfilt,3);
%image1_meanfilt = filter_mean(image1_meanfilt,3);

%% 梯度
[gradx,grady,grad,angle] = getgrad(image1_medfilt,m,n,6);

%% 方向场图
%[block_dmap,theta] = block_dmap(gradx,grady,m,n);

%% 分割
%块梯度分割
%image1_seg=segment_block(image1_medfilt,gradx,grady,m,n,5);
%梯度、大津分割
image1_seg=segment_filter(image1_medfilt,grad,m,n);

%% 智能增强
g_Dsite(:,:,1)=[ -3,-2,-1,0,1,2,3;
                 -3,-2,-1,0,1,2,3;
                 -3,-2,-1,0,1,2,3;
                 -3,-2,-1,0,1,2,3;
                 -2,-1,-1,0,1,1,2;
                 -1,-1, 0,0,0,1,1;
                  0, 0, 0,0,0,0,0;
                 -1,-1, 0,0,0,1,1;
                 -2,-1,-1,0,1,1,2;
                 -3,-2,-1,0,1,2,3;
                 -3,-2,-1,0,1,2,3;
                 -3,-2,-1,0,1,2,3;];
             
g_Dsite(:,:,2) =[ 0, 0, 0,0, 0, 0, 0;
                 -1,-1, 0,0, 0, 1, 1;
                 -2,-1,-1,0, 1, 1, 2; 
                 -3,-2,-1,0, 1, 2, 3;
                 -3,-2,-1,0, 1, 2, 3;
                 -3,-2,-1,0, 1, 2, 3;
                 -3,-2,-1,0, 1, 2, 3;
                  3, 2, 1,0,-1,-2,-3;
                  3, 2, 1,0,-1,-2,-3;
                  3, 2, 1,0,-1,-2,-3;
                  2, 1, 1,0,-1,-1,-2;
                  1, 1, 0,0 ,0,-1,-1;];
Hw =[1,1,1,1,1,1,1];
Vw =[-3,-1,3,9,3,-1,-3];
%orgfinger = double(image1_seg);
orgfinger = image1_seg;
for x = 1:m
    for y = 1: n
        d = DDIndex(angle,x,y);
        sum=0;
        hsum=0;
        for i = 1:7
            if x + g_Dsite(d,i,2)<1 || x + g_Dsite(d,i,2) > m || y + g_Dsite(d,i,1)<1 || y + g_Dsite(d,i,1) > n
                continue
            end
            sum = sum + Hw(i)*(orgfinger( x+g_Dsite(d,i,2),y+g_Dsite(d,i,1)));
            hsum = hsum + Hw(i);
        end
        if (hsum ~= 0 )
            temp(x,y) = sum/hsum;
        else
            temp(x,y) = 255;  
        end
    end
end


for x = 1:m
    for y = 1: n
        d = mod(DDIndex(angle,x,y)+6,12);
        if d == 0 
            d =12;
        end
        sum=0;
        vsum=0;
        for i = 1:7
            if x + g_Dsite(d,i,2)<1 || x + g_Dsite(d,i,2) > m || y + g_Dsite(d,i,1)<1 || y + g_Dsite(d,i,1) > n
                continue
            end
            sum = sum + Vw(i) * (temp(x+g_Dsite(d,i,2), y+g_Dsite(d,i,1)));
            vsum = vsum + Vw(i);
        end
        if (vsum > 0 )
            sum = sum/vsum;
            if sum >255
                orgfinger(x,y) = 255;
            elseif sum <0        
                orgfinger(x,y) = 0;
            else
                orgfinger(x,y) = sum;
            end          
        else
            orgfinger(x,y) = 255;  
        end
    end
end
figure,imshow(temp,[0,255]),title('智能增强');






