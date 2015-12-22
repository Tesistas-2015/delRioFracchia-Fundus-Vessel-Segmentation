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


for i=1:1%size_my_img
    img = my_img(i).img;
    I=im2double(img);
    im=I(:,:,2); % Canal verde
    figure(i);
    img =adapthisteq(im);
    for f=1:size_a_fondo
        img_sin_fondo = sacar_fondo(a_fondo(f).met,img);
        GT= my_imgGT(i).img;
        GT=im2double(GT);
        GT= GT-0.5;
        [TPR, TNR, info] = vl_roc(GT, img_sin_fondo);
        hold on
        plot(1-TNR,TPR);
        if f==1
            auc1=info.auc;
        end
        if f==2
            auc2=info.auc;
        end

        legend(strcat('clahe-mediana','_auc: ',num2str(auc1)),... 
            strcat('clahe-media-','_auc: ',num2str(auc2)),...
            strcat('clahe-gaussiano','_auc: ',num2str(info.auc)));
    end
    hold off
end