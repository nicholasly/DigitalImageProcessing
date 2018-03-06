function output_img = dithering_and_matching(input_img1, input_img2)
    % 读取输入图像获取图像矩阵
    I = imread(input_img1);
    % 如果是彩色图像将其转换成灰度图像
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    m = size(I, 1);
    n = size(I, 2);
    output_img = I;
    for x = 1:m
        for y = 1:n
            oldpixel = output_img(x,y);
            if oldpixel >= 128
                output_img(x,y) = 255;
            else
                output_img(x,y) = 0;
            end
            newpixel = round(output_img(x,y));
            output_img(x,y) = newpixel;
            quant_error = oldpixel - newpixel;
            if x + 1 <= m
                output_img(x + 1,y) = output_img(x + 1,y) + quant_error * (1 / 8);
            end
            if x + 2 <= m
                output_img(x + 2,y) = output_img(x + 2,y) + quant_error * (1 / 8);
            end
            if x + 2 <= m && y + 1 <= n
                output_img(x + 2,y + 1) = output_img(x + 2,y + 1) + quant_error * (1 / 8);
            end
            if x <= m && y + 1 <= n
                output_img(x,y + 1) = output_img(x,y + 1) + quant_error * (1 / 8);
            end
            if x <= m && y + 2 <= n
                output_img(x,y + 2) = output_img(x,y + 2) + quant_error * (1 / 8);
            end
            if x + 1 <= m && y + 1 <= n
                output_img(x + 1,y + 1) = output_img(x + 1,y + 1) + quant_error * (1 / 8);
            end
            if x + 2 <= m && y + 1 <= n
                output_img(x + 2,y + 1) = output_img(x + 2,y + 1) + quant_error * (1 / 8);
            end
            if x + 1 <= m && y + 1 <= n
                output_img(x + 1,y + 1) = output_img(x + 1,y + 1) + quant_error * (1 / 8);
            end
            if x + 1 <= m && y - 1 >= 1
            	output_img(x + 1,y - 1) = output_img(x + 1,y - 1) + quant_error * (3 / 16);
            end
        end
    end
    output_img = uint8(output_img);
    % 读取输入图像获取图像矩阵
    I1 = output_img;
    I2 = imread(input_img2);
    % 获取图像的尺寸
    m1 = size(I1,1);  
    n1 = size(I1,2);
    m2 = size(I2,1);  
    n2 = size(I2,2);
    % 如果是彩色图像将其转换成灰度图像
    if ndims(I1) == 3
        I1 = rgb2gray(I1);
    end
    if ndims(I2) == 3
        I2 = rgb2gray(I2);
    end
    % 计算每个灰度级像素的个数
    num_pixels_img1 = zeros(1, 256);
    num_pixels_img2 = zeros(1, 256);
    for i = 1:m1
        for j = 1:n1
            index = I1(i, j) + 1;
            num_pixels_img1(index) = num_pixels_img1(index) + 1;
        end
    end
    for i = 1:m2
        for j = 1:n2
            index = I2(i, j) + 1;
            num_pixels_img2(index) = num_pixels_img2(index) + 1;
        end
    end
    % 计算灰度级在图像中出现的的频率
    prob_pixels_img1 = num_pixels_img1./(m1 * n1);
    prob_pixels_img2 = num_pixels_img2./(m2 * n2);
    figure;
    subplot(2,3,1);
    bar(prob_pixels_img1, 0.4);
    title('EightAM的灰度直方图');
    xlabel('灰度值');
    ylabel('像素的概率密度');
    subplot(2,3,2);
    imshow(I1);
    title('均衡化前的EightAM');
    subplot(2,3,3);
    imhist(I2);
    bar(prob_pixels_img2, 0.4);
    title('LENA的灰度直方图');
    xlabel('灰度值');
    ylabel('像素的概率密度');
    % 均衡化
    new_prob_indexes_img1 = zeros(1, 256);
    for i = 1:256
        for j = 1:i
            new_prob_indexes_img1(i) = new_prob_indexes_img1(i) + prob_pixels_img1(j);
        end
        new_prob_indexes_img1(i) =  new_prob_indexes_img1(i) * 255;
    end
    new_prob_indexes_img1 = round(new_prob_indexes_img1);
    new_prob_indexes_img2 = zeros(1, 256);
    for i = 1:256
        for j = 1:i
            new_prob_indexes_img2(i) = new_prob_indexes_img2(i) + prob_pixels_img2(j);
        end
        new_prob_indexes_img2(i) =  new_prob_indexes_img2(i) * 255;
    end
    new_prob_indexes_img2 = round(new_prob_indexes_img2);
    % 找到映射关系
    mapping = ones(1, 256);
    for i = 1:256
        for j = 1:256
            if new_prob_indexes_img2(j) == new_prob_indexes_img1(i)
                mapping(i) = j;
                break;
            end
        end
    end
    % 进行直方图匹配
    N = I1;
    for i = 1:m1
        for j = 1:n1
            temp = N(i, j) + 1;
            N(i, j) = mapping(temp) - 1;
        end
    end
    new_num_pixels = zeros(1, 256);
    for i = 1:m1
        for j = 1:n1
            index = N(i, j) + 1;
            new_num_pixels(index) = new_num_pixels(index) + 1;
        end
    end
    % 计算灰度级在图像中出现的的频率
    new_prob_pixels = new_num_pixels./(m1 * n1);
    % 打印原图和直方图
    subplot(2,3,4),imshow(N),title('均衡化后');
    subplot(2,3,5);
    bar(new_prob_pixels, 0.4);
    title('直方图匹配后的灰度直方图');
    xlabel('灰度值');
    ylabel('像素的概率密度');
    subplot(2,3,6),imshow(I);