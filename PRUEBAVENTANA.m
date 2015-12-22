% Principal pipeline 3 -CLAHE + SACAR FONDO
clc
clear
close all

a_fondo(1).met = 'mediana';
a_fondo(2).met = 'media';
a_fondo(3).met = 'gaussiano';
a_ruido(1).met = 'coherence_filter';
a_ruido(2).met = 'anisotropic_filter';

path = 'DataSet/aria_a_markups/'; %'DataSet/DRIVE/training/images/';
ext = '*.tif';
my_img = cargarImagenes(path,ext);

path ='DataSet/aria_a_markup_vessel/';
ext = '*.tif';
my_imgGT = cargarImagenes(path,ext);

size_my_img = length(my_img);
size_a_fondo = length(a_fondo);
size_a_ruido = length(a_ruido);
data_max=-1;

metodo = a_fondo(1).met;
for i=2:2 %size_my_img
    img = my_img(i).img;
    I=im2double(img);
    im=I(:,:,2); % Canal verde
    figure(i);
    img =adapthisteq(im);
    for v= 35:75
        img_sin_fondo = sacar_fondo(metodo,img,v);     
        GT= my_imgGT(i).img;
        GT=im2double(GT);
        GT= GT-0.5;
        [TPR, TNR, info] = vl_roc(GT, img_sin_fondo);
        hold on
        plot([v 0 ],[0 info.auc])
        if(info.auc>data_max && (info.auc-data_max)>1)
            data(i).auc=info.auc;
            data(i).vent=v;
            data_max=data(i).auc;
        end
    end
    data_max= -1;
    hold off
end
%%
for j=1:2
   hold on
   plot([data(j).vent 0], [0 data(j).auc]);
   
end
hold off