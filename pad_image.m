%--------------------------------------------------------
%pad the image to make height and width multiples of N
%--------------------------------------------------------
function y = pad_image(x,N)
    [ht,wt] = size(x);
    padcol  = N-mod(wt,N);
    if(padcol ~= N) %need padding
        x    = [x,ones(ht,padcol)*255];
    else
        padcol  = 0;
    end
    padrow  = N-mod(ht,N);
    if(padrow~= N) 
        x     = [x;ones(padrow,padcol+wt)*255];
    else        
        padrow = 0;
    end
    %---------------
    %changet ht,wt
    %--------------
    ht = ht+padrow;
    wt = wt+padcol;
    y=x;
%end function pad_image
