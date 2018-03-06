function output_img = Wiener_filtering(input_img, original_img, H, K)
    % 读取输入图像获取图像矩阵
    I = input_img;
    % 获取图像的尺寸
    [m, n] = size(I);
    % 进行傅里叶变换
    F0 = fftshift(fft2(I));
    F = fftshift(fft2(original_img));
    % 进行维纳滤波
    for u = 1:m
        for v = 1:n  
            H0(u, v) = (abs(H(u,v)))^2;
            H1(u, v) = H0(u,v) / (H(u,v) * (H0(u,v) + K));  
            F2(u, v) = H1(u,v) * F0(u,v);
        end
    end
    output_img = uint8(abs(ifft2(ifftshift(F2))));
     % 打印图像
    figure;
    subplot(1,2,1),imshow(I),title('维纳滤波前图像');
    subplot(1,2,2),imshow(output_img),title('维纳滤波后图像');

 