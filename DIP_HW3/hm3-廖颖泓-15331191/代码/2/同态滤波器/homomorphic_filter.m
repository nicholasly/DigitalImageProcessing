function homomorphic_filter(input_img, gammaH, gammaL, C, D0)
    % 读取输入图像获取图像矩阵
    I = imread(input_img);
    % 获取图像的尺寸
    M = size(I, 1);  
    N = size(I, 2);
    P = floor(M / 2);
    Q = floor(N / 2);
    % 取对数
    log_img = log(double(I) + 1);
    % 进行傅里叶变换
    trans_img = fft2(log_img);
    % 同态滤波
    filtered_img = zeros(M, N);
    for u = 1:M
        for v = 1:N
            filtered_img(u, v) = homomorphic_filter_function(u, v, P, Q, gammaH, gammaL, C, D0) * trans_img(u, v);
        end
    end
    % 傅里叶反变换取实部并指数还原
    processes_img = real(exp(ifft2(filtered_img)));
    % 取得最好显示效果
    max = 0;
    min = 255;
    for i = 1:M
        for j = 1:N
            if processes_img(i, j) > max
                max = processes_img(i, j);
            end
            if processes_img(i, j) < min
                min = processes_img(i, j);
            end
        end
    end
    range = max - min;
    for i = 1:M
        for j = 1:N
            processes_img(i, j) = 255 * (processes_img(i, j) - min) / range;
        end
    end
    processes_img = im2uint8(mat2gray(processes_img));
    % 输出滤波前后图像
    figure;
    subplot(1,2,1),imshow(I),title('同态滤波前');
    subplot(1,2,2),imshow(processes_img),title('同态滤波后');
    