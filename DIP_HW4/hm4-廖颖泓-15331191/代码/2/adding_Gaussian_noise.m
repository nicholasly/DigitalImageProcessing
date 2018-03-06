function output_img = adding_Gaussian_noise(input_img, a, v)
    % ¶ÁÈ¡ÊäÈëÍ¼Ïñ»ñÈ¡Í¼Ïñ¾ØÕó
    I = input_img;
    % »ñÈ¡Í¼ÏñµÄ³ß´ç
    [m,n] = size(I);
    % ¼ÆËãÔëÉù¾ØÕó
    n_gaussian = a + sqrt(v) .* randn(m,n);
    %Ìí¼ÓÔëÉù
    output_img = uint8(double(I) + n_gaussian);
    % ´òÓ¡Í¼Ïñ
    figure;
    subplot(1,2,1),imshow(I),title('Ìí¼ÓÔëÉùÇ°Í¼Ïñ');
    subplot(1,2,2),imshow(output_img),title('Ìí¼ÓÔëÉùºóÍ¼Ïñ');
    