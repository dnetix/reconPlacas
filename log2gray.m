%% Convierte una matriz logica a una de enteros con valores 0 y 255
function [ gray ] = log2gray( logical )
%LOG2GRAY Summary of this function goes here
%   Detailed explanation goes here
    gray = uint8(logical);
    gray(gray == 1) = 255;
end

