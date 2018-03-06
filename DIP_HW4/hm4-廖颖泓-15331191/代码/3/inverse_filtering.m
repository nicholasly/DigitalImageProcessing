function output_img = inverse_filtering(input_img, H)
    % ¶ÁÈ¡ÊäÈëÍ¼Ïñ»ñÈ¡Í¼Ïñ¾ØÕó
    I = input_img;
    % ½øĞĞÄæÂË²¨
    G = fftshift(fft2(I));
    F = G ./ H;
    output_img = uint8(abs(ifft2(fftshift(F))));
    % ´òÓ¡Í¼Ïñ
    figure;
    subplot(1,2,1),imshow(I),title('ÄæÂË²¨Ç°Í¼Ïñ');
    subplot(1,2,2),imshow(output_img),title('ÄæÂË²¨ºóÍ¼Ïñ');
    
