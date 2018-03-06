function get_histogram(input_img)
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
            index = I(i, j);
            if index == 0
                continue;
            end
            num_pixels(index) = num_pixels(index) + 1;
        end
    end
    % 计算灰度级在图像中出现的的频率
    prob_pixels = num_pixels./(m * n);
    % 打印原图和直方图
    figure;
    subplot(1,2,1),imshow(I),title('原图');
    subplot(1,2,2);
    bar(prob_pixels, 0.3);
    title('灰度直方图');
    xlabel('灰度值');
    ylabel('像素的概率密度');
 