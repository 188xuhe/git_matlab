function [block_dmap,theta] = block_dmap(gradx,grady,m,n)
%ORIENT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
theta=zeros(m,n);EPI=57.29578;
block_dmap=ones(m,n)*255;                   %���鷽��ͼ����洢�ռ䣬��ֵΪ1
gradm=floor(m/8);
gradn=floor(n/8);
Vx=zeros(gradm,gradn);
Vy=zeros(gradm,gradn);
jiaodu=zeros(gradm,gradn);

for i=1:1:gradm
    for j=1:1:gradn
       x=gradx([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]); 
       y=grady([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]); 
       temp=x.*y;       
       Vx(i,j)=2*sum(temp(:));
       temp=x.^2-y.^2;
       Vy(i,j)=sum(temp(:));
       
       %���ȸĳɽǶ�
       jiaodu(i,j)=atan2(Vy(i,j),Vx(i,j));
       if  jiaodu(i,j)<0
           jiaodu(i,j)=jiaodu(i,j)+2*pi;
       end
       jiaodu(i,j)=jiaodu(i,j)*EPI*0.5+0.5;
       jiaodu(i,j)=jiaodu(i,j)-135;
       if jiaodu(i,j)<=0
           jiaodu(i,j)=jiaodu(i,j)+180;
       end
       jiaodu(i,j)=180-jiaodu(i,j);
       theta([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8])=jiaodu(i,j);

               if  jiaodu(i,j)<=11.25 |  jiaodu(i,j)>168.75;
                    y1=1;
                elseif    jiaodu(i,j)>11.25 &jiaodu(i,j)<=33.75;
                    y1=2;  
                elseif    jiaodu(i,j)>33.75 &  jiaodu(i,j)<=56.25; 
                    y1=3;  
                elseif   jiaodu(i,j)>56.25 & jiaodu(i,j)<=78.75;
                   y1=4;    
               elseif   jiaodu(i,j)>78.75 & jiaodu(i,j)<=101.25;
                    y1=5;
               elseif    jiaodu(i,j)>101.25 & jiaodu(i,j)<=123.75;
                    y1=6;
               elseif    jiaodu(i,j)>123.75 & jiaodu(i,j)<=146.25;
                    y1=7;
               elseif   jiaodu(i,j)>146.25 & jiaodu(i,j)<=168.75;
                    y1=8;
                end
      angle_xy=ones(8,8);
       
       switch  y1
                case 1
                  angle_xy(4,[2:7])=0;                 %����1��������Ϊ0��ʱ�����8�е�2-15�е�Ԫ��Ϊ0����ɫ��
                case 2
                  idx=sub2ind(size(angle_xy),[  3 4 4 5 5 6  ],[2:7]);
                  angle_xy(idx)=0;                 
                case 3
                  idx=sub2ind(size(angle_xy),[2:7],[2:7]);
                  angle_xy(idx)=0;
                case 4
                  idx=sub2ind(size(angle_xy),[2:7],[  3 4 4 5 5 6  ]);
                  angle_xy(idx)=0;
                case 5
                  angle_xy([2:7],4)=0;
                case 6
                  idx=sub2ind(size(angle_xy),[7:-1:2],[   3 4 4 5 5 6 ]);
                  angle_xy(idx)=0;
                case 7
                  idx=sub2ind(size(angle_xy),[7:-1:2],[7:-1:2]);
                  angle_xy(idx)=0;                     
                case 8
                  idx=sub2ind(size(angle_xy),[  6 5 5 4 4 3  ],[2:7]);
                  angle_xy(idx)=0;
                end
  
                block_dmap([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8])=angle_xy;
       
    end
end
figure;imshow(block_dmap);title('RAO�ݶȷ���õĿ鷽��ͼ');
end

