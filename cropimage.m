function [ img_cropped ] = cropimage( img, areas )
%CROPIMAGE Corta de una matriz un segmento con base en una area
    
    % Obtengo el valor de X y Y del punto inicial de corte
    x = areas(1);
    y = areas(2);
    % Obtengo hasta donde hay que cortar en X y Y
    x_max = x + areas(3);
    y_max = y + areas(4);
    % Corto el segmento determinado
    img_cropped = img(y:y_max, x:x_max);

end

