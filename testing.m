clear all, close all, clc

for ite = 1 : 80
    close all;
    filename = strcat('placas/carro (', int2str(ite), ').jpg');
    a = imread(filename);
    
    img = rgb2gray(cortarPlaca(a));
    tmp = img;
    brillo = mean(mean(img));
    if(brillo < 100)
        img = img * 2;
    end
    
    img(img < 110) = 255;
    img(img < 255) = 0;
    
    [fil, col, ~] = size(img);
    minSize = floor((fil * col) * 0.01);
    img = bwareaopen(img, minSize);
    
    ee = strel('square', 3);
    img = imerode(img, ee);
    img = imclearborder(img);
    img = imdilate(img, ee);
    
    figure(1); imshow(img);
    
    mean(mean(tmp))
    
    ite
    pause;
end
