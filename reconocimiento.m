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

%% Itero entre las imagenes a reconocer
for ite = 1 : 40
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
        rectangle('Position', areas(i,:), 'EdgeColor', 'g', 'LineWidth', 1);
    end
    % Muestro el numero de la imagen actual
    ite
    % Espero el evento del usuario para realizar el proceso con la
    % siguiente
    pause;
end
