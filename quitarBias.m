function imagen_sin_bias = quitarBias(I, W)
%Se quita el Baias, tomando el canal verde de la imagen, luego se aplica un
%filtro de mediana para estimar el fondo, y se le resta el fondo al canal
%verde de la imagen original. Normalizo la imagen para retornarla.
img = im2double(I);
verde = img(:,:,2);
fondo = medfilt2(verde, W);
isb = double(verde) - double(fondo);
imagen_sin_bias = (isb - min(isb(:)))/(max(isb(:)) - min(isb(:)));