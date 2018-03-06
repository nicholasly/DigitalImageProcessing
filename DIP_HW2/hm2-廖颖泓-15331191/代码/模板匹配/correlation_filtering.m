function [correlated_img] = correlation_filtering(img1, img2)
    scene = imread(img1);
    template = imread(img2);
    m = size(scene, 1);  
    n = size(scene, 2);
    x = size(template, 1);  
    y = size(template, 2);
    scene = im2double(scene);
    template = im2double(template);
    correlated_img = scene;
    for i = 1:m
        for j = 1:n
            correlated_img(i,j) = 0;
            for p = 1:x
                for q = 1:y
                    a = round(i + p - (x - 1)/2 - 1);
                    b = round(j + q - (y - 1)/2 - 1);
                    if  a >= 1 && b >= 1 && a <= m && b <= n 
                        correlated_img(i, j) = correlated_img(i, j) + template(p, q) * scene(a, b);
                    end             
                end
            end
        end
    end
    correlated_img = im2uint8(mat2gray(correlated_img));
    figure;
    subplot(1,2,1),imshow(scene),title('Original');
    subplot(1,2,2),imshow(correlated_img),title('Correlated'),axis on,xlabel x, ylabel y
    figure,surf(correlated_img),axis tight
