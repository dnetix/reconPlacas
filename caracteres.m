%% Con una imagen de la placa obtengo los caracteres de la placa
function [ img, elm_count, areas ] = caracteres( img )
%CARACTERES
    % Dado que se trata de una imagen en grises obtengo la media de la intensidad 
    % de cada columna de la imagen
    mediaColumnas = mean(img);
    % Determino el brillo como la media de las medias de cada columna
    brillo = mean(mediaColumnas);
    % Si este valor es menor que 100 la considero oscura y la trato de
    % normalizar a 120 lo mismo si es superior a 140
    if(brillo < 100)
        img = img * (120 / brillo);
    elseif(brillo > 140)
        img = img * (120 / brillo);
    end
    % desviacion = std(mediaColumnas);
    % Obtengo los percentiles 0 y 25 de los promedios de intensidad
    p_0 = prctile(mediaColumnas, 0);
    p_25 = prctile(mediaColumnas, 25);
    % Determino el valor de corte para binarizar como el percentil 25 menos
    % 5 desviaciones estandar entre este y el percentil 0
    min_rgb = floor(p_25 - ((p_0 / p_25) * 5));
    % Binarizo la imagen con el valor obtenido
    img(img < min_rgb) = 255;
    img(img < 255) = 0;
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

