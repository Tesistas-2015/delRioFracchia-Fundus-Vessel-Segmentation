function ipp = preprocesamientoCF(image,w)
%Quito el baias
ISB = quitarBias(image,w);
%Aplicamos un filtro Gaussiano
% n=5;
% sigma = 5;
% f = fspecial('gaussian',n,sigma);
% IFG = imfilter(ISB,f,'same');

%Se aplica el filtro de Difusion Anisotropica
ICF = CoherenceFilter(ISB,struct('T',20,'rho',5,'Scheme','O','eigenmode','3'));
                          
%Se aplica realce a la imagen, aplicando CLAHE
imagenRealsada = adapthisteq(ICF);
ipp = imagenRealsada;