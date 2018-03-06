function Butterworth_highpass_filter(input_img, D0)
    % ��ȡ����ͼ���ȡͼ�����
    I = imread(input_img);
    % ��ȡͼ��ĳߴ�
    M = size(I, 1);  
    N = size(I, 2);
    P = 2 * M;
    Q = 2 * N;
    % ���ͼ��
    padded_img = zeros(P, Q);
    for i = 1:M
        for j = 1:N
            padded_img(i, j) = I(i, j);
        end
    end
    padded_img = im2uint8(mat2gray(padded_img));
    % ���ı任
    middled_img = zeros(P, Q);
    for x = 1:P
        for y = 1:Q
            middled_img(x, y) = (-1) ^ (x + y) * padded_img(x, y);
        end
    end
    middled_img = im2uint8(mat2gray(middled_img));
    % ����Ҷ�任
    trans_img = fft2(middled_img);
    % ��ͨ�˲�
    filtered_img = zeros(P, Q);
    for u = 1:P
        for v = 1:Q
            filtered_img(u, v) = highpass_filter_function(u, v, P, Q, D0) * trans_img(u, v);
        end
    end
    % ����Ҷ���任ȡʵ��
    processes_img = real(ifft2(filtered_img));
    % �����ı任
    for x = 1:P
        for y = 1:Q
            processes_img(x, y) =  processes_img(x, y) * ((-1) ^ (x + y));
        end
    end
    processes_img = im2uint8(mat2gray(processes_img));
    % ��ȡͼ��
    extracted_img = processes_img(1:M, 1:N);
    % ����˲�ǰ��ͼ��
    figure;
    subplot(1,2,1),imshow(I),title('Ƶ���˲�ǰ');
    subplot(1,2,2),imshow(extracted_img),title('Ƶ���˲���');
    