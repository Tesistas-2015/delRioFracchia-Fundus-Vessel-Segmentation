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

