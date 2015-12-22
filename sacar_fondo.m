function imagen_sin_fondo = sacar_fondo( metodo, im, v)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

switch metodo
    case 'mediana'    
        fondo = medfilt2(im, [v v]); % Estimo el fondo usando filtro de mediana
        sin_fondo = im - fondo;
        imagen_sin_fondo = 1-((sin_fondo-min(sin_fondo(:)))/(max(sin_fondo(:))-min(sin_fondo(:))));  

    case 'media'
        h1 = fspecial('average', [v v]);
        fondo = roifilt2(h1, im, calcularMascara(im)); % Estimo el fondo usando filtro de media
        sin_fondo = im - fondo;
        imagen_sin_fondo = 1-((sin_fondo-min(sin_fondo(:)))/(max(sin_fondo(:))-min(sin_fondo(:))));  
        
    case 'gaussiano'
        h1 = fspecial('gaussian');
        fondo=imfilter(im,h1);
        sin_fondo = im - fondo;
        imagen_sin_fondo = 1-((sin_fondo-min(sin_fondo(:)))/(max(sin_fondo(:))-min(sin_fondo(:))));  
    otherwise
         imagen_sin_fondo = im; 
   
        
end

