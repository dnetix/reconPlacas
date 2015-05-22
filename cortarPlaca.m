function [ placa ] = cortarPlaca( a )
%CORTARPLACA 
% Corto la imagen
    [fil, col, ~] = size(a);
    p = 0.2;
    f_min = floor(fil * 0.4);
    f_max = ceil(fil * (1 - p));
    c_min = floor(col * p);
    c_max = ceil(col * (1 - 0.35));

    a = a(f_min:f_max, c_min:c_max, :);
    
    [b, s, y, T] = componentes(a);
    % Resaltar el recuadro de la placa
    d = max(b, s);

    ee = strel('square', 3);
    for i = 1:2
        d = imdilate(d, ee);
    end
    % figure(1); imshow([d, e]); impixelinfo;
    
    d(d < 200) = 0;
    d(d > 0) = 255;

    for i = 1:3
        d = imdilate(d, ee);
    end
    for i = 1:6
        d = imerode(d, ee);
    end
    for i = 1:3
        d = imdilate(d, ee);
    end

    d = imclearborder(d);
    
    [l, num] = bwlabel(d);
    % figure(1); imagesc(l); colormap(jet);
    area = [];
    for i = 1:num
        e = d * 0;
        e(l == i) = 1;
        areaI = sum(e(:));
        area = [area, areaI];
    end

    areaM = max(area);
    obj = find(area == areaM);

    e = d * 0;
    e(l == obj) = 255;
    
    % figure(1); imshow([y, e]); impixelinfo;
    
    [fil, col] = find(e > 0);
    f_min = min(fil);
    f_max = max(fil);
    c_min = min(col);
    c_max = max(col);
    
    placa = a(f_min:f_max, c_min:c_max, :);
end

