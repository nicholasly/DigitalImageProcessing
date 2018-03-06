function histogram_equalization(input_img)
    % ��ȡ����ͼ���ȡͼ�����
    I = imread(input_img);
    % ��ȡͼ��ĳߴ�
    m = size(I,1);  
    n = size(I,2);
    % ����ǲ�ɫͼ����ת���ɻҶ�ͼ��
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    % ����ÿ���Ҷȼ����صĸ���
    num_pixels = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            index = I(i, j) + 1;
            num_pixels(index) = num_pixels(index) + 1;
        end
    end
    % ����Ҷȼ���ͼ���г��ֵĵ�Ƶ��
    prob_pixels = num_pixels./(m * n);
    % ����ͼ���ֱ��ͼ
    figure;
    subplot(2,4,1),imshow(I),title('���⻯ǰ��ͼ��');
    subplot(2,4,2);
    bar(prob_pixels, 0.4);
    title('���⻯ǰ�ĻҶ�ֱ��ͼ');
    xlabel('�Ҷ�ֵ');
    ylabel('���صĸ����ܶ�');
    subplot(2,4,3);
    imshow(I);
    title('���⻯ǰ��ͼ��');
    subplot(2,4,4);
    imhist(I);
    title('���⻯ǰ��imhist���ƵĻҶ�ֱ��ͼ');
    % ����Ҷ�ֵ���ۻ��ֲ�����Ȼ���γɾ��⻯��ʽ
    new_prob_indexes = zeros(1, 256);
    N = I;
    for i = 1:256
        for j = 1:i
            new_prob_indexes(i) = new_prob_indexes(i) + prob_pixels(j);
        end
        new_prob_indexes(i) =  new_prob_indexes(i) * 255;
    end
    new_prob_indexes = round(new_prob_indexes);
    % ��ͼ��ÿһ�����ص���о��⻯ӳ��
    for i = 1:m
        for j = 1:n
            temp = N(i, j) + 1;
            N(i, j) = new_prob_indexes(temp) - 1;
        end
    end
    % ����ÿ���Ҷȼ����صĸ���
    new_num_pixels = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            index = N(i, j) + 1;
            new_num_pixels(index) = new_num_pixels(index) + 1;
        end
    end
    % ����Ҷȼ���ͼ���г��ֵĵ�Ƶ��
    new_prob_pixels = new_num_pixels./(m * n);
    % ��ӡԭͼ��ֱ��ͼ
    subplot(2,4,5),imshow(N),title('��ǰ�㷨���⻯���ͼ��');
    subplot(2,4,6);
    bar(new_prob_pixels, 0.4);
    title('��ǰ�㷨���⻯��ĻҶ�ֱ��ͼ');
    xlabel('�Ҷ�ֵ');
    ylabel('���صĸ����ܶ�');
    subplot(2,4,7);
    V = histeq(I);
    imshow(V);
    title('��histeq()���⻯���ͼ��');
    subplot(2,4,8);
    imhist(V);
    title('��histeq()���⻯���imhist()���ƵĻҶ�ֱ��ͼ');
    