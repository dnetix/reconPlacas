function [ filled ] = fillMatrix( m, desired_width )
%FILLMATRIX Incrementa el numero de columnas de una matriz con ceros hasta
%alcanzar el tamaño deseado centrando el contenido original

    % Obtengo las dimensiones de la matriz
    [fil, col] = size(m);
    % Obtengo el numero de columnas que necesito llenar
    overfill = desired_width - col;
    if overfill > 0
        % Si este numero es par entonces es simetrico y puedo dividir por 2
        if(mod(overfill, 2) == 0)
            fill_left = int8(overfill / 2);
            fill_right = fill_left;
        else
            % Si no es par entonces el llenado de la izquiera tendra una
            % columna de mas
            fill_right = int8(floor(overfill / 2));
            fill_left = fill_right + 1;
        end
        
        % Matrices de ceros para el lado izquierdo y derecho
        mfl = zeros(fil, fill_left);
        mfr = zeros(fil, fill_right);
        
        % Retorno la matriz llena
        filled = [mfl, m, mfr];
        
    else
        filled = m;
    end

end

