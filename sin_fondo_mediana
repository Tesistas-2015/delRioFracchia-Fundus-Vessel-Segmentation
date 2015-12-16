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
    aux=im+im; %Mascara
    mask=aux;
    mask(aux <= (30/255)) = 0;
    mask(aux > (30/255)) = 1; %Fin mascara
    fondo = medfilt2(im, [30 30]); % Estimo el fondo usando filtro de mediana
    
    figure,
    subplot(2,2,1), imshow(im), title('Canal verde');
    subplot(2,2,2), imshow(fondo), title('Fondo estimado');
    subplot(2,2,3), imshow(mask), title('Mascara');
    
%%
    sin_fondo = im - fondo;
    sin_fondo=(sin_fondo-min(sin_fondo(:)))/(max(sin_fondo(:))-min(sin_fondo(:)));  
    figure,
    subplot(1,1,1), imshow(sin_fondo), title('Canal verde con fondo removido');
    
%%
    JOA=adapthisteq(JO); %CLAHE a JO con coherenceFilter

%% Coherence de la imagen sin aplicar gaussiano
   JO = CoherenceFilter(sin_fondo,struct('T',5,'rho',5,'Scheme','O', 'eigenmode', '3'));
   figure
   subplot(1,1,1), imshow(JO), title('Optimizado con ruido');
   
%%

I = im2double(imread('DataSet/DRIVE/training/1st_manual/21_manual1.gif'));
I=I-0.5;
% segmNorm=(segm-min(segm(:)))/(max(segm(:))-min(segm(:)));  
figure,
vl_roc(I,JOA2);

% %%
% I = im2double(imread('DataSet/DRIVE/training/1st_manual/21_manual1.gif'));
% I=I-0.5;
% % segmNorm=(segm-min(segm(:)))/(max(segm(:))-min(segm(:)));  
% figure,
% vl_roc(I,JOA);
