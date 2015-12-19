% Principal
clc
clear
close all

a_fondo(1).met = 'mediana';
a_fondo(2).met = 'media';
a_fondo(3).met = 'gaussiano';
a_ruido(1).met = 'coherence_filter';
a_ruido(2).met = 'anisotropic_filter';

path ='DataSet/DRIVE/training/images/';
ext = '*.tif';
my_img = cargarImagenes(path,ext);

path ='DataSet/DRIVE/training/1st_manual/';
ext = '*.gif';
my_imgGT = cargarImagenes(path,ext);

size_my_img = length(my_img);
size_a_fondo = length(a_fondo);
size_a_ruido = length(a_ruido);

%leyendas = {'mediana + clahe + coherence', 'media + clahe + coherence', 'gaussiano + clahe + coherence',... 
 %   'mediana + clahe + anisotropica', 'mediana + clahe + anisotropica', 'mediana + clahe + anisotropica'}

for i=1:1 %size_my_img
    img = my_img(i).img;
    im=img(:,:,2); % Canal verde
    figure;
    leyendas=[];
    for f=1:size_a_fondo
        img_sin_fondo = sacar_fondo(a_fondo(f).met,im);
        img_sin_fondo =adapthisteq(img_sin_fondo);
        for r=1:size_a_ruido
            img_sin_ruido = sacar_ruido(a_ruido(r).met,img_sin_fondo);
            GT=my_imgGT(i).img;
            [TPR, TNR, info] = vl_roc(GT, img_sin_ruido);
            hold on
            plot(1-TNR,TPR);
            leyendas=[leyendas,sprintf('%s, %s -> AUC: %f',a_fondo(f).met,a_ruido(r).met,info.auc)];
        end
    end
    legend(leyendas);
    hold off
end
