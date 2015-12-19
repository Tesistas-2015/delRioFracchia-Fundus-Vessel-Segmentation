function [ imagen_sin_ruido ] = sacar_ruido( metodo, I )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

switch metodo
    case 'coherence_filter'
        imagen_sin_ruido = CoherenceFilter(I,struct('T',105,'rho',1,'Scheme','O', 'eigenmode', '3'));
    case 'anisotropic_filter'
        imagen_sin_ruido = anisodiff(I, 15, 1/20, 2, 1);
    otherwise
        imagen_sin_ruido = I;

end

