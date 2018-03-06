function get_histogram(input_img)
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
            index = I(i, j);
            if index == 0
                continue;
            end
            num_pixels(index) = num_pixels(index) + 1;
        end
    end
    % ����Ҷȼ���ͼ���г��ֵĵ�Ƶ��
    prob_pixels = num_pixels./(m * n);
    % ��ӡԭͼ��ֱ��ͼ
    figure;
    subplot(1,2,1),imshow(I),title('ԭͼ');
    subplot(1,2,2);
    bar(prob_pixels, 0.3);
    title('�Ҷ�ֱ��ͼ');
    xlabel('�Ҷ�ֵ');
    ylabel('���صĸ����ܶ�');
 