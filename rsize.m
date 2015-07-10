function [ n_img ] = rsize( img, height, width )
%RSIZE Realiza el proceso de redimension y aumento de ancho para la matriz
%proporcionada
    [fil, ~] = size(img);
    n_img = imresize(img, height / fil);
    n_img = fillMatrix(n_img, width);
end

