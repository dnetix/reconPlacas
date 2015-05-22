function [ b, y, s, T ] = componentes( a )
%COMPONENTES Summary of this function goes here
%   Detailed explanation goes here

%     'lab2lch'   'lch2lab'   'upvpl2xyz'   'xyz2upvpl'
%     'uvl2xyz'   'xyz2uvl'   'xyl2xyz'     'xyz2xyl'
%     'xyz2lab'   'lab2xyz'   'srgb2xyz'    'xyz2srgb'
%     'srgb2lab'  'lab2srgb'  'srgb2cmyk'   'cmyk2srgb'
    [fil, col, cap] = size(a);

    cform = makecform('srgb2lab');
    b = applycform(a, cform);
    b = double(b);
    b = b / max(b(:)) * 255;
    b = uint8(b);
    b = reshape(b, [fil, col * cap]);
    lab = b;
    
    cform = makecform('srgb2cmyk');
    b = applycform(a, cform);
    b = double(b);
    b = b / max(b(:)) * 255;
    b = uint8(b);
    b = reshape(b, [fil, col * (cap + 1)]);
    cmyk = b;
    cmy = cmyk(:,1:(col * 3));
    
    b = rgb2hsv(a);
    b = b / max(b(:)) * 255;
    b = uint8(b);
    b = reshape(b, [fil, col * cap]);
    hsv = b;
    
    rgb = reshape(a, [fil, col * cap]);
    
    T = [lab; cmy; hsv; rgb];
    
    b = lab(:, ((col * 2) + 1):(col * 3));
    s = hsv(:, (col + 1):(col * 2));
    y = cmy(:, ((col * 2) + 1):(col * 3));
end

