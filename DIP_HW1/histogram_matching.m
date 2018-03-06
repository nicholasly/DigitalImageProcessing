function histogram_matching(input_img1, input_img2)
    % ��ȡ����ͼ���ȡͼ�����
    I1 = imread(input_img1);
    I2 = imread(input_img2);
    % ��ȡͼ��ĳߴ�
    m1 = size(I1,1);  
    n1 = size(I1,2);
    m2 = size(I2,1);  
    n2 = size(I2,2);
    % ����ǲ�ɫͼ����ת���ɻҶ�ͼ��
    if ndims(I1) == 3
        I1 = rgb2gray(I1);
    end
    if ndims(I2) == 3
        I2 = rgb2gray(I2);
    end
    % ����ÿ���Ҷȼ����صĸ���
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
    % ����Ҷȼ���ͼ���г��ֵĵ�Ƶ��
    prob_pixels_img1 = num_pixels_img1./(m1 * n1);
    prob_pixels_img2 = num_pixels_img2./(m2 * n2);
    figure;
    subplot(2,3,1);
    bar(prob_pixels_img1, 0.4);
    title('EightAM�ĻҶ�ֱ��ͼ');
    xlabel('�Ҷ�ֵ');
    ylabel('���صĸ����ܶ�');
    subplot(2,3,2);
    imshow(I1);
    title('���⻯ǰ��EightAM');
    subplot(2,3,3);
    imhist(I2);
    bar(prob_pixels_img2, 0.4);
    title('LENA�ĻҶ�ֱ��ͼ');
    xlabel('�Ҷ�ֵ');
    ylabel('���صĸ����ܶ�');
    % ���⻯
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
    % �ҵ�ӳ���ϵ
    mapping = ones(1, 256);
    for i = 1:255
        for j = 1:255
            if new_prob_indexes_img2(j) == new_prob_indexes_img1(i)
                mapping(i) = j;
                break;
            end
        end
    end
    % ����ֱ��ͼƥ��
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
    % ����Ҷȼ���ͼ���г��ֵĵ�Ƶ��
    new_prob_pixels = new_num_pixels./(m1 * n1);
    % ��ӡԭͼ��ֱ��ͼ
    subplot(2,3,4),imshow(N),title('���⻯��');
    subplot(2,3,5);
    bar(new_prob_pixels, 0.4);
    title('ֱ��ͼƥ���ĻҶ�ֱ��ͼ');
    xlabel('�Ҷ�ֵ');
    ylabel('���صĸ����ܶ�');
    
    
    