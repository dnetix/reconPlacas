%% Reconocimiento de Placas
% Definido el escenario, permite con una imagen detectar los 6 elementos de
% una placa, seleccionando de color verde las areas donde se encuentran los
% caracteres
%
% Procesamiento Digital de Imagenes
% Por: Diego Calle - dnetix@gmail.com
%     Estudiante de Ingenieria de Sistemas
%     UdeA
clear all; clc;

keySet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
valueSet = [6, 6, 2, 2, 5, 16, 9, 12, 7, 6, 6, 6, 25, 8, 10, 2, 4, 6, 7, 6, 2, 10, 6, 7, 5, 2, 11, 11, 16, 19, 19, 23, 27, 20, 13, 18];
defaultSet = [5, 2, 1, 1, 3, 4, 3, 3, 7, 4, 2, 6, 1, 4, 6, 2, 4, 2, 3, 1, 1, 3, 5, 7, 4, 2, 1, 9, 1, 13, 1, 16, 5, 10, 8, 10];
mapObj = containers.Map(keySet, valueSet);
defaultObj = containers.Map(keySet, defaultSet);

%% Itero entre las imagenes a reconocer
for ite = 41 : 120
    close all;
    % Concateno el numero de la iteracion con el nombre del archivo de
    % imagen a reconocer
    filename = strcat('placas/carro (', int2str(ite), ').jpg');
    a = imread(filename);
    % Realizo el llamado a cortar placa, que se encarga de reconocer la
    % placa por la descomposicion de colores y cortar el mas sobresaliente
    img = rgb2gray(cortarPlaca(a));
    % Guardo la imagen obtenida en una variable temporal, con el proposito de
    % pruebas posteriores en caso de no funcionar
    tmp = img;
    % Con caracteres obtengo la imagen binaria de los caracteres, el numero
    % de elementos reconocidos y las areas de los elementos reconocidos,
    % siendo cada area un vector de la manera [x, y, ancho, alto]
    [img, elements, areas] = caracteres(img);
    % Muestro las imagenes en gris y binaria
    imshow([tmp; log2gray(img)]);
    % Itero entre los elementos para dibujar las areas encontradas
    for i = 1 : elements
        img_cropped = cropimage(img, areas(i,:));
        
        figure(2); imshow(img_cropped);
        tmp = input('Nombre de Letra', 's');
        if ~isempty(tmp)
            number = mapObj(tmp);
            imwrite(img_cropped, strcat('letters/', tmp, '_', int2str(number + 1), '.jpg'));
            mapObj(tmp) = number + 1;
        end
        
        rectangle('Position', areas(i,:), 'EdgeColor', 'g', 'LineWidth', 1);
    end
    % Muestro el numero de la imagen actual
    ite
    % Espero el evento del usuario para realizar el proceso con la
    % siguiente
    pause;
end
