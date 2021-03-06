%% Reconocimiento de Placas
% Definido el escenario, permite con una imagen detectar los 6 elementos de
% una placa, seleccionando de color verde las areas donde se encuentran los
% caracteres y convirtiendolos a caracteres ascii
%
% Procesamiento Digital de Imagenes
% Por: Diego Calle - dnetix@gmail.com
%     Estudiante de Ingenieria de Sistemas
%     UdeA
clear all; clc;

%% Itero entre las imagenes a reconocer
for ite = 1 : 20
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
    
    placa = '';
    % Una vez limpiada la placa al llegar a este punto cada caracter estara
    % determinado por un area
    for i = 1 : elements
        % Corto la el area de la imagen donde supuestamente se encuentra el
        % caracter
        character = cropimage(img, areas(i,:));
        % Para poder realizar una correlacion efectiva ambas matrices deben
        % coincidir en dimensiones por lo que la redimensiono al mismo
        % tama�o de las imagenes en la base de datos de caracteres
        character = rsize(character, 140, 88);
        % Llamo la funcion que se encargara de comprobar las correlaciones
        % y devolver el caracter con el cual tiene el mayor porcentaje de
        % correlacion
        letter = ocrish(character);
        % Concateno el caracter dado para construir la placa
        placa = strcat(placa, letter);
        % Recuadro verde sobre cada caracter
        rectangle('Position', areas(i,:), 'EdgeColor', 'g', 'LineWidth', 1);
    end
    % Muestro en la figura la placa obtenida.
    uicontrol('Style', 'text',...
       'String', placa,...
       'Units','pixels',...
       'HorizontalAlignment','left',...
       'ForegroundColor', [0, 0, 1],...
       'FontSize', 24,...
       'Position', [10 10 220 40]);
   
    % Muestro el numero de la imagen actual
    ite
    % Espero el evento del usuario para realizar el proceso con la
    % siguiente
    pause;
end
