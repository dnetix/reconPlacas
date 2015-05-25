function [ img, elm_count, areas ] = caracteresV2( img )
%CARACTERES 
    img = ~im2bw(img, graythresh(img));
    
    ee = strel('square', 3);
    img = imerode(img, ee);
    img = imclearborder(img);
    img = imdilate(img, ee);
    
    [fil, col, ~] = size(img);
    [l,num] = bwlabel(img);
    
    y_range = fil * 0.4;
    x_range = col * 0.2;
    elm_count = 0;
    areas = [];
    for i = 1:num
        [fil,col] = find(l==i);
        y_min = min(fil(:));
        y_max = max(fil(:));
        x_min = min(col(:));
        x_max = max(col(:));
        if((y_max - y_min) > y_range && (x_max - x_min) < x_range)
            areas = [areas; x_min, y_min, (x_max - x_min), (y_max - y_min)];
            elm_count = elm_count + 1;
        else
            img(l == i) = 0;
        end
    end
end

