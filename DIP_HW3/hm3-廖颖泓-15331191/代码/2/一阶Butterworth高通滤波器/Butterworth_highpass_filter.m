function Butterworth_highpass_filter(input_img, D0)
    % 读取输入图像获取图像矩阵
    I = imread(input_img);
    % 获取图像的尺寸
    M = size(I, 1);  
    N = size(I, 2);
    P = 2 * M;
    Q = 2 * N;
    % 填充图像
    padded_img = zeros(P, Q);
    for i = 1:M
        for j = 1:N
            padded_img(i, j) = I(i, j);
        end
    end
    padded_img = im2uint8(mat2gray(padded_img));
    % 中心变换
    middled_img = zeros(P, Q);
    for x = 1:P
        for y = 1:Q
            middled_img(x, y) = (-1) ^ (x + y) * padded_img(x, y);
        end
    end
    middled_img = im2uint8(mat2gray(middled_img));
    % 傅里叶变换
    trans_img = fft2(middled_img);
    % 高通滤波
    filtered_img = zeros(P, Q);
    for u = 1:P
        for v = 1:Q
            filtered_img(u, v) = highpass_filter_function(u, v, P, Q, D0) * trans_img(u, v);
        end
    end
    % 傅里叶反变换取实部
    processes_img = real(ifft2(filtered_img));
    % 反中心变换
    for x = 1:P
        for y = 1:Q
            processes_img(x, y) =  processes_img(x, y) * ((-1) ^ (x + y));
        end
    end
    processes_img = im2uint8(mat2gray(processes_img));
    % 截取图像
    extracted_img = processes_img(1:M, 1:N);
    % 输出滤波前后图像
    figure;
    subplot(1,2,1),imshow(I),title('频域滤波前');
    subplot(1,2,2),imshow(extracted_img),title('频域滤波后');
    