function index = DDIndex(angle,x,y)
%DDINDEX �˴���ʾ�йش˺�����ժҪ
%   angle: [in] �Ƕ� ��0 - 180��

    if angle(x,y) >= 173 || angle(x,y) < 8
       index = 1;
       return
    else
       index = ceil((angle(x,y)-8)/15 + 1);
       return 
    end
end

