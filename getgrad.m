function [gradx,grady,grad,angle] = getgrad(image,m,n,r)
%GETGRAD �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%% �˲������õ��ݶ�
h=fspecial("sobel");                    %sobel
gradx = filter2(h,image,'same');
grady = filter2(h',image,'same');
%% 
EPI	= 57.29578;     %360/2pi���ǶȺͻ��ȵĻ���
Vx = zeros(m,n);
Vy = zeros(m,n);
grad = zeros(m,n);
angle = zeros(m,n);
f_temp = double(image);
for x = 1:m
    for y = 1: n
         lvx = 0;
         lvy = 0;
         gradsum = 0;
         num = 0;
            %%%%%%%%%%%%%%%%%%%r * r ���µĴ���%%%%%%%%%%%%%%%%%%%
            for i = -r:r
                %%%%%%%%%%%%%%%%%% �߽紦�� %%%%%%%%%%%%%%%%%%%%%
                if(x + i -1 < 1 || x + i + 1 > m )
                    continue;
                end
                    for j = -r:r
                        if (y + j -1 < 1 || y + j + 1 > n)
                            continue;
                        end
                         Vx(x+i,y+j) = f_temp(x+i+1,y+j+1) - f_temp(x+i+1,y+j-1) + f_temp(x+i,y+j+1)*2 - f_temp(x+i,y+j-1)*2 + f_temp(x+i-1,y+j+1) - f_temp(x+i-1,y+j-1);
                         Vy(x+i,y+j) = (f_temp(x+i-1,y+j+1) - f_temp(x+i+1,y+j+1)) + (f_temp(x+i-1,y+j)*2 - f_temp(x+i+1,y+j)*2) + (f_temp(x+i-1,y+j-1) - f_temp(x+i+1,y+j-1) );
                        
                         gradsum = gradsum+abs(Vx(x+i,y+j))+abs(Vy(x+i,y+j));
                        
                         lvx = lvx + 2*Vx(x+i,y+j)*Vy(x+i,y+j);        %sin(2sita)
                         lvy = lvy + (Vx(x+i,y+j)*Vx(x+i,y+j) - Vy(x+i,y+j)*Vy(x+i,y+j));%cos(2sita)
                         
                         num=num+1;                         
                    end
            end
            if num==0
                num=1;
            end
            grad(x,y)=gradsum/num;     %ͼ���ݶ�
            fangle = atan2(lvy,lvx);
            if fangle<0 
                fangle = fangle + 2*pi;
            end
            fangle = fangle*EPI*0.5 + 0.5;
            fangle = fangle - 135;
            if fangle<=0
                fangle = fangle +180;
            end
            angle(x,y) = 180 - fangle;  %ͼ��Ƕ�
    end
end
figure,imshow(grad,[0 256]),title("grad");
figure,imshow(angle,[0 180]),title("angle");

