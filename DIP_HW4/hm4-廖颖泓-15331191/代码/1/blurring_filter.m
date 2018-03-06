function [output_img, H] = blurring_filter(input_img, a, b, T)
    % 读取输入图像获取图像矩阵
    I = input_img;
    % 获取图像的尺寸
    [m,n] = size(I);
    % 计算偏离量矩阵
    [v,u] = meshgrid(1:n,1:m);
    u = u - floor(m / 2);
    v = v - floor(n / 2);
    % 进行运动模糊
    Fp = fftshift(fft2(I));
    G = filter_function(u, v, a, b, T) .* Fp;
    output_img = uint8(real(ifft2(ifftshift(G))));
    LA = fftshift(fft2(output_img));
    H = LA ./ double(Fp);
    % 打印图像
    figure;
    subplot(1,2,1),imshow(I),title('运动模糊前图像');
    subplot(1,2,2),imshow(output_img),title('运动模糊后图像');
