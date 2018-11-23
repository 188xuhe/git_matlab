function index = DDIndex(angle,x,y)
%DDINDEX 此处显示有关此函数的摘要
%   angle: [in] 角度 （0 - 180）

    if angle(x,y) >= 173 || angle(x,y) < 8
       index = 1;
       return
    else
       index = ceil((angle(x,y)-8)/15 + 1);
       return 
    end
end

