%Cargo las imagenes en el arreglo my_img
myDir = 'DataSet/DRIVE/training/images/';
ext_img = '*.tif';
a = dir([myDir ext_img]);
nfile = max(size(a)) ;  % number of image files
for i=1:nfile
  my_img(i).img = imread([myDir a(i).name]);
  imshow(my_img(i).img);
end

%% Muestro la imagen de la posicion 1 del arreglo
image=my_img(1).img;
imshow(image);

%% Baias a la imagen
verde = image(:,:,2);
fondo = medfilt2(verde, [40 40]);
image_sin_bias = double(verde) - double(fondo);
neighbourhood = [5 5];
ISinFondo = medfilt2(image_sin_bias, neighbourhood);
figure('name','Imagen preprocesada sin fondo');
imshow(ISinFondo, [min(ISinFondo(:)) max(ISinFondo(:))]);

%% Segmentar imagen
%segmenatacion
threshold = 0.46;
% Segmentación por umbralado
segm = ISinFondo;
segm(ISinFondo <= threshold) = 1;
segm(ISinFondo > threshold) = 0;
figure('name','Imagen preprocesada y su segmentación por umbralado');
imshow(segm);

%%
%CURVA ROC

%Image_01R  - Original
%Image_01R_1stHO - Segmentada 1
%Image_01R_2ndHO - Segmentada 2
IVector = ISinFondo(:);
numPos = 5 ;
numNeg = 100 ;
labels = [ones(1, numPos) -ones(1,numNeg)] ;
scores = randn(size(labels)) + labels ;
[TPR,TNR] = vl_roc(labels, scores);
plotroc(TNR,TPR)



        
