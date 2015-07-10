function [ recognized ] = ocrish( toRecognize )
%OCRISH Un OCR de caracteres de placa
%   Detailed explanation goes here
    
    % Diferentes caracteres posibles
    keySet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    % Numero de imagen de la base de datos a usar por caracter
    defaultSet = [5, 2, 1, 1, 3, 4, 3, 3, 7, 4, 2, 6, 1, 4, 6, 2, 4, 2, 3, 1, 1, 3, 5, 7, 4, 2, 1, 9, 1, 13, 1, 16, 5, 10, 8, 10];
    
    % Porcentaje de correlacion inicial
    old_p = 0;
    % Valor numerico de la letra inicial
    key = 1;
    % Itero entre cada letra
    for j = 1 : length(keySet)
        % Obtengo la letra a iterar y el numero de letra por esta en la
        % base de datos
        letter = keySet(j);
        default = defaultSet(j);
        % Construyo la direccion de la letra en la base de datos
        filename = char(strcat('characters/', letter, '_', int2str(default), '.jpg'));
        % Obtengo la imagen y la convierto a binaria
        db_character = im2bw(imread(filename));
        % Obtengo el porcentaje de correlacion entre la letra a reconocer y
        % la letra que se itera
        p = corr2(toRecognize, db_character);
        % Si el porcentaje de correlacion es mayor al que ya se tenia
        % entonces voy determinando que este es el caracter
        if p > old_p
            old_p = p;
            key = j;
        end
    end
    % Una vez iterados todos obtengo el caracter que haya obtenido el mayor
    % porcentaje de correlacion
    recognized = keySet(key);

end

