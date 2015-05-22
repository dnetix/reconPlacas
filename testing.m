clear all, close all, clc

for ite = 10 : 120
    close all;
    filename = strcat('placas/carro (', int2str(ite), ').jpg');
    a = imread(filename);
    
    img = rgb2gray(cortarPlaca(a));
    tmp = img;
    
    [img, elements, areas] = caracteres(img);
    imshow(img);
    
    for i = 1 : elements
        rectangle('Position', areas(i,:), 'EdgeColor', 'g', 'LineWidth', 1);
    end
    
    ite
%     brillo = mean(mean(img));
%     if(brillo < 100)
%         img = img * (120 / brillo);
%         brillo = mean(mean(img));
%     elseif(brillo > 140)
%         img = img * (120 / brillo);
%         brillo = mean(mean(img));
%     end
%     desviacion = std(mean(img));
%      
%     x = img;
%     p_0 = prctile(mean(img), 0);
%     p_25 = prctile(mean(img), 25);
%     min_rgb = floor(p_25 - ((p_0 / p_25) * 5));
%     
%     img(img < min_rgb) = 255;
%     img(img < 255) = 0;
%     
%     [fil, col, ~] = size(img);
%     minSize = floor((fil * col) * 0.01);
%     img = bwareaopen(img, minSize);
%     
%     ee = strel('square', 3);
%     img = imerode(img, ee);
%     img = imclearborder(img);
%     img = imdilate(img, ee);
%     
%     if(fil > col)
%         img = rot90(img, 3);
%         [fil, col, ~] = size(img);
%     end
% %     figure(2); boxplot(mean(x));
% %     figure(3); plot(mean(x));
%     figure(1); imshow(img);
%     
%     [l,num]=bwlabel(img);
%     
%     y_range = fil * 0.4;
%     x_range = col * 0.2;
%     elm_count = 0;
%     
%     for i = 1:num
%         ind = find(l==i);
%         [fil,col] = find(l==i);
%         y_min = min(fil(:));
%         y_max = max(fil(:));
%         x_min = min(col(:));
%         x_max = max(col(:));
%         
%         if((y_max - y_min) > y_range && (x_max - x_min) < x_range)
%             rectangle('Position', [x_min, y_min, (x_max - x_min), (y_max - y_min)], 'EdgeColor', 'g', 'LineWidth', 1)
%             elm_count = elm_count + 1;
%         else
%             rectangle('Position', [x_min, y_min, (x_max - x_min), (y_max - y_min)], 'EdgeColor', 'r', 'LineWidth', 1)
%             img(ind) = 0;
%         end
%     end
%     
%     [ite, brillo, desviacion, p_25, p_0, min_rgb]
    
    pause;
end
