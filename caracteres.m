%% Con una imagen de la placa obtengo los caracteres de la placa
function [ img, elm_count, areas ] = caracteres( img )
%CARACTERES
  
    % Binarizo la imagen
    img = ~im2bw(img, graythresh(img));
    
    % Obtengo el alto y el ancho de la imagen
    [fil, col, ~] = size(img);
    % Determino un valor para el ruido como el 1% del tamaño del area
    minSize = floor((fil * col) * 0.01);
    % Elimino los elementos que sean menores a el tamaño definido
    img = bwareaopen(img, minSize);
    % Con un elemento estructurado cuadrado erosiono, limpio bordes y luego
    % dilato
    ee = strel('square', 3);
    img = imerode(img, ee);
    img = imclearborder(img);
    img = imdilate(img, ee);
    % Obtengo los elementos que hayan quedado
    [l,num]=bwlabel(img);
    % Determino un rango (tamaño minimo que los elementos deben cumplir) de
    % ancho un 20% y de alto un 40%
    y_range = fil * 0.4;
    x_range = col * 0.2;
    % Contadores
    elm_count = 0;
    areas = [];
    % Por cada elemento encontrado determino su area
    for i = 1:num
        [fil,col] = find(l==i);
        y_min = min(fil(:));
        y_max = max(fil(:));
        x_min = min(col(:));
        x_max = max(col(:));
        % Para considerarlo, el area del elemento debe ser mayor que el
        % rango de y determinado y menor que el rango de x determinado
        if((y_max - y_min) > y_range && (x_max - x_min) < x_range)
            areas = [areas; x_min, y_min, (x_max - x_min), (y_max - y_min)];
            elm_count = elm_count + 1;
        else
            img(l == i) = 0;
        end
    end
end

