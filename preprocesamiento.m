function ipp = preprocesamiento(image,w)
%Quito el baias
ISB = quitarBias(image,w);

%Se aplica el filtro de Difusion Anisotropica
iter = 25;
delta_t = 1/25;
kappa = 2;  
option = 1; 
diff_im = anisodiff2D(ISB, iter , delta_t, kappa, option);

%Se aplica realce a la imagen, aplicando CLAHE
imagenRealsada = adapthisteq(diff_im);

ipp = imagenRealsada;