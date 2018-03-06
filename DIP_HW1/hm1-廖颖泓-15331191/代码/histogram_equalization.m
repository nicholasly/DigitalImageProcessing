function histogram_equalization(input_img)
    % 读取输入图像获取图像矩阵
    I = imread(input_img);
    % 获取图像的尺寸
    m = size(I,1);  
    n = size(I,2);
    % 如果是彩色图像将其转换成灰度图像
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    % 计算每个灰度级像素的个数
    num_pixels = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            index = I(i, j) + 1;
            num_pixels(index) = num_pixels(index) + 1;
        end
    end
    % 计算灰度级在图像中出现的的频率
    prob_pixels = num_pixels./(m * n);
    % 绘制图像和直方图
    figure;
    subplot(2,4,1),imshow(I),title('均衡化前的图像');
    subplot(2,4,2);
    bar(prob_pixels, 0.4);
    title('均衡化前的灰度直方图');
    xlabel('灰度值');
    ylabel('像素的概率密度');
    subplot(2,4,3);
    imshow(I);
    title('均衡化前的图像');
    subplot(2,4,4);
    imhist(I);
    title('均衡化前的imhist绘制的灰度直方图');
    % 计算灰度值的累积分布函数然后形成均衡化公式
    new_prob_indexes = zeros(1, 256);
    N = I;
    for i = 1:256
        for j = 1:i
            new_prob_indexes(i) = new_prob_indexes(i) + prob_pixels(j);
        end
        new_prob_indexes(i) =  new_prob_indexes(i) * 255;
    end
    new_prob_indexes = round(new_prob_indexes);
    % 对图像每一个像素点进行均衡化映射
    for i = 1:m
        for j = 1:n
            temp = N(i, j) + 1;
            N(i, j) = new_prob_indexes(temp) - 1;
        end
    end
    % 计算每个灰度级像素的个数
    new_num_pixels = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            index = N(i, j) + 1;
            new_num_pixels(index) = new_num_pixels(index) + 1;
        end
    end
    % 计算灰度级在图像中出现的的频率
    new_prob_pixels = new_num_pixels./(m * n);
    % 打印原图和直方图
    subplot(2,4,5),imshow(N),title('当前算法均衡化后的图像');
    subplot(2,4,6);
    bar(new_prob_pixels, 0.4);
    title('当前算法均衡化后的灰度直方图');
    xlabel('灰度值');
    ylabel('像素的概率密度');
    subplot(2,4,7);
    V = histeq(I);
    imshow(V);
    title('用histeq()均衡化后的图像');
    subplot(2,4,8);
    imhist(V);
    title('用histeq()均衡化后的imhist()绘制的灰度直方图');
    