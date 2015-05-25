%% Funcion que se encarga de encontrar la placa en una imagen y cortarla
function [ placa ] = cortarPlaca( a )
% CORTARPLACA 
    % Obtengo las dimensiones fil (alto) y col (ancho) de la imagen
    [fil, col, ~] = size(a);
    % De acuerdo con el escenario se establecen los cortes iniciales dados
    % en porcentaje del total de la imagen.
    f_min = floor(fil * 0.4);
    f_max = ceil(fil * (1 - 0.2));
    c_min = floor(col * 0.2);
    c_max = ceil(col * (1 - 0.35));
    % Corto la imagen con los porcentajes dados
    a = a(f_min:f_max, c_min:c_max, :);
    % Obtengo los componentes de color de la imagen
    [b, s, ~, ~] = componentes(a);
    % Resaltar el recuadro de la placa con los componentes azul y
    % saturacion
    d = max(b, s);
    % genero una entidad estructurada cuadradad para dilatar la imagen y
    % reducir ruido
    ee = strel('square', 3);
    % Dilato 2 veces
    for i = 1:2
        d = imdilate(d, ee);
    end
    % figure(1); imshow([d, e]); impixelinfo;
    % Genero una imagen binaria a partir de los pixeles con valores mayores
    % a 200
    d(d < 200) = 0;
    d(d > 0) = 255;
    % Operaciones de dilatacion y erosion para reducir mas ruido
    for i = 1:3
        d = imdilate(d, ee);
    end
    for i = 1:6
        d = imerode(d, ee);
    end
    for i = 1:3
        d = imdilate(d, ee);
    end

    % Remuevo elementos pegados al borde
    d = imclearborder(d);
    % Obtengo los elementos binarios que quedaron despues de la limpieza
    [l, num] = bwlabel(d);
    % figure(1); imagesc(l); colormap(jet);
    area = [];
    for i = 1:num
        e = d * 0;
        e(l == i) = 1;
        areaI = sum(e(:));
        area = [area, areaI];
    end
    % Encuentro el area mayor de los elementos
    areaM = max(area);
    % Encuentro las posiciones donde se encuentre el elemento de mayor area
    obj = find(area == areaM);
    % Creo una maatriz de ceros con el mismo tamaño de la imagen
    e = d * 0;
    % A esta matriz nueva solo le establezco valores donde el area es mayor
    e(l == obj) = 255;
    
    % figure(1); imshow([y, e]); impixelinfo;
    
    % Ahora con las posiciones de esta area obtengo las posiciones donde se
    % encuentra este elemento, que si el escenario se presta, debe ser la
    % placa
    [fil, col] = find(e > 0);
    f_min = min(fil);
    f_max = max(fil);
    c_min = min(col);
    c_max = max(col);
    % Recorto la placa
    placa = a(f_min:f_max, c_min:c_max, :);
    % Obtengo el tamaño de la placa
    [fil, col, ~] = size(placa);
    % En caso de que sea mas alto que ancho roto la placa
    if(fil > col)
        placa = rot90(placa, 3);
    end
    
end

