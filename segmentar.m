%Segmenta la imagen I por umbralado, segun el valor de t. Y se erosiona con
%la mascara antes de devolver.
%function imagen_segmentada = segmentar(I,t)
function imagen_segmentada = segmentar(I,t,mask)
threshold = t;
% Segmentación por umbralado
segm = I;
segm(I <= threshold) = 1;
segm(I > threshold) = 0;
se = strel('disk',1);
ism = imerode(mask,se);
segm(ism < 1) = 0;
segm = imopen(segm,se);
imagen_segmentada = segm;