function mask = calcularMascara(I)
id = im2double(I);
% i = id(:,:,2);
aux = id + id;
maskTemp = aux;
maskTemp(aux <= (30/255)) = 0;
maskTemp(aux > (30/255)) = 1;
mask = maskTemp;
