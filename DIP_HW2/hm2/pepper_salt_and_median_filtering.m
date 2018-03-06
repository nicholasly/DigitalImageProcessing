function pepper_salt_and_median_filtering(img1)
    I = imread(img1);
    [m,n] = size(I);
    t1 = uint8(mod(rand(m, n)* 10000,256));
    t2 = uint8(mod(rand(m, n)* 10000,256));
    psnoise_img = I;
    for i = 1:m
        for j = 1:n
            if t2(i, j) >= t1(i, j)
                if psnoise_img(i, j) > t1(i , j)
                    psnoise_img(i, j) = 255;
                elseif psnoise_img(i, j) < t2(i , j)
                    psnoise_img(i, j) = 0;
                end
            else
                if psnoise_img(i, j) > t2(i , j)
                    psnoise_img(i, j) = 255;
                elseif psnoise_img(i, j) < t1(i , j)
                    psnoise_img(i, j) = 0;
                end
            end
        end
    end
    nonoise_img = psnoise_img;
    for i = 1:m
        for j = 1:n
            neighbors = zeros(3,3);
            for p = -1:1
                for q = -1:1
                    if i + p >= 1 && j + q >= 1 && i + p <= m && j + q <= n
                        neighbors(p + 2,q + 2) = nonoise_img(i + p, j + q);
                    end
                end
            end
            neighbors = neighbors(:);
            nonoise_img(i, j) = median(neighbors);
        end
    end
    nonoise_img_medfilt2 = medfilt2(psnoise_img, [3, 3]);
    figure;
    subplot(2,2,1),imshow(I),title('Original');
    subplot(2,2,2),imshow(psnoise_img),title('Add Noise');
    subplot(2,2,3),imshow(nonoise_img),title('Remove Noise');
    subplot(2,2,4),imshow(nonoise_img_medfilt2),title('Remove Noise Using medfilt2');
    
    
    