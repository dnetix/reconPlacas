function [ img, elm_count, areas ] = caracteres( img )
%CARACTERES 
    brillo = mean(mean(img));
    if(brillo < 100)
        img = img * (120 / brillo);
    elseif(brillo > 140)
        img = img * (120 / brillo);
    end
    desviacion = std(mean(img));

    p_0 = prctile(mean(img), 0);
    p_25 = prctile(mean(img), 25);
    min_rgb = floor(p_25 - ((p_0 / p_25) * 5));
    
    img(img < min_rgb) = 255;
    img(img < 255) = 0;
    
    [fil, col, ~] = size(img);
    minSize = floor((fil * col) * 0.01);
    img = bwareaopen(img, minSize);
    
    ee = strel('square', 3);
    img = imerode(img, ee);
    img = imclearborder(img);
    img = imdilate(img, ee);
    
    if(fil > col)
        img = rot90(img, 3);
        [fil, col, ~] = size(img);
    end
%     figure(2); boxplot(mean(x));
%     figure(3); plot(mean(x));
    figure(1); imshow(img);
    
    [l,num]=bwlabel(img);
    
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

