%Cargo las imagenes en el arreglo my_img
%Y muestro la imagen de la posicion 1 del arreglo

for p=1:2
    path ='DataSet/DRIVE/training/images/';
    ext = '*.tif';
    my_img = cargarImagenes(path,ext);

    path ='DataSet/DRIVE/training/1st_manual/';
    ext = '*.gif';
    my_imgGT = cargarImagenes(path,ext);
    size = length(my_img) - 1;
    %for  j = 1:size        
    for  j = 1:2        
        image = my_img(j).img;
        imageGT = my_imgGT(j).img;    
        %calculo la mascara de la imagen
        mask = calcularMascara(image);
        %Preproceso la imagen
        w = [30 30];
        if p == 1
            ipp = preprocesamiento(image,w);
        else
            ipp = preprocesamientoCF(image,w);
        end
        % Segmentar imagen por umbralado 
        threshold = graythresh(ipp);
        segm = segmentar(ipp,threshold,mask);
        % Calculo la curva roc
        isb =  double(imageGT);
        imgSegmNorm = (isb - min(isb(:)))/(max(isb(:)) - min(isb(:)));
        imgSegmNorm = imgSegmNorm - 0.5;
        figure(j);vl_roc(imgSegmNorm,segm);
        [TPR,TNR,INFO] = vl_roc(imgSegmNorm,segm);
        data(j).info = INFO;
    end
    ext = '.txt';
    nombre = 'archivo';
    path = 'C:\Users\Marcos\Desktop\TESIS\Desarrollo\RepoDesarrollo\Resultados\';
    long = length(data);
    nfile = strcat(path,nombre,num2str(p),ext);
    fid=fopen(nfile,'w'); 
    for l = 1:long
        fprintf(fid,'%f\t',data(l).info.auc); 
        fprintf(fid,'%f\t',data(l).info.eer); 
        fprintf(fid,'%f\t',data(l).info.eerThreshold);    
        fprintf(fid,'\n');
    end
    fclose(fid);
end
%%
%Segundo codigo de prueba del filtro de Difusion Anisotropica
fontSize = 18;
neighbourhood = [5 5];
iM = my_img(1).img(:,:,2);
%imagenConFilterMediana = medfilt2(imagen, neighbourhood);
imagenConFilterMediana = medfilt2(iM, neighbourhood);
grayImage = imagenConFilterMediana;
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
% set(gcf, 'Position', get(0,'Screensize')); 
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'name','Image Analysis Demo','numbertitle','off') 
niter = 6;
kappa = 66;
lambda = 0.25;
option = 1;
diff = anisodiff(grayImage, niter, kappa, lambda, option);
subplot(2,2,2);
imshow(diff, []);
title('Diffused Gray Scale Image', 'FontSize', fontSize);
drawnow;

%aplicar algun filtro cuando obtiene los distintos canales
rgbImage = my_img(1).img;
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);
% Display the original color image.
subplot(2, 2, 3);
imshow(rgbImage, []);
title('Original Color Image', 'FontSize', fontSize);
drawnow;
% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
niter = 8;%70;
kappa = 8;
lambda = 0.25;
option = 2;
diffR = anisodiff(redChannel, niter, kappa, lambda, option);
diffG = anisodiff(greenChannel, niter, kappa, lambda, option);
diffB = anisodiff(blueChannel, niter, kappa, lambda, option);
rgbOutput = uint8(cat(3, diffR, diffG, diffB));
%Display the diffused images.
subplot(2, 2, 1);
imshow(diffR, []);
title('Diffused Red Channel Image');
subplot(2, 2, 2);imshow(diffG, []);
title('Diffused Green Channel Image');
subplot(2, 2, 3);imshow(diffB, []);
title('Diffused Blue Channel Image');
subplot(2, 2, 4);imshow(rgbOutput);
title('Diffused Color Image');

%% Se aplica Opening sobre la imagen
%opening de la imagen
w = 5;
se = strel('square',w);
openin = imopen(image,se);
%opMediana = medfilt2(openin, [20 20]);
figure(4),imshow(openin);
titulo = strcat('Opening con w=5');
title(titulo);
