%Cargo las imagenes en el arreglo my_img
myDir = 'DataSet/DRIVE/training/images/';
ext_img = '*.tif';
a = dir([myDir ext_img]);
nfile = max(size(a)) ;  % number of image files
for i=1:nfile
  my_img(i).img = imread([myDir a(i).name]);
  %figure(i);
  imshow(my_img(i).img);
end

%% Muestro la imagen de la posicion 1 del arreglo
image=my_img(1).img;
imshow(image);


%%
    I = im2double(imread('DataSet/DRIVE/training/images/21_training.tif'));
    im=I(:,:,2); % Canal verde
    fondo = medfilt2(im, [35 35]); % Estimo el fondo usando filtro de mediana
    
    figure,
    subplot(1,2,1), imshow(im), title('Canal verde');
    subplot(1,2,2), imshow(fondo), title('Fondo estimado');
    
%%
    sin_fondo = im - fondo;
    sin_fondo=1-((sin_fondo-min(sin_fondo(:)))/(max(sin_fondo(:))-min(sin_fondo(:))));  
    figure,
    subplot(1,1,1), imshow(sin_fondo), title('Canal verde con fondo removido');
    
%%
    JO=adapthisteq(sin_fondo); %CLAHE a sinfondo

%% Coherence de la imagen con CLAHE
   JOC = CoherenceFilter(JO,struct('T',75,'rho',3,'Scheme','O', 'eigenmode', '3'));
   figure
   subplot(1,1,1), imshow(JOC), title('Optimizado con ruido');
   
%%

I = im2double(imread('DataSet/DRIVE/training/1st_manual/21_manual1.gif'));
I = I-0.5;

figure,
% vl_roc(I,JOC);
[TPR,TNR,info]=vl_roc(I,JOC);
plot(1-TNR,TPR);
title(sprintf('AUC: %f, Error: %f', info.auc, info.eer));

