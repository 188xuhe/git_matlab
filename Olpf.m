
% low-pass filter according to the paper
function A = Olpf(O, w)
    kernel = fspecial('gaussian', [w, w], 50);
    phix = cos(O);
    phiy = sin(O);
    phix = imfilter(phix, kernel, 'replicate');
    phiy = imfilter(phiy, kernel, 'replicate');
    A = atan(phiy ./phix);
end
