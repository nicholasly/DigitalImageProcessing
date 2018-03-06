function homomorphic_filter(input_img, gammaH, gammaL, C, D0)
    % ��ȡ����ͼ���ȡͼ�����
    I = imread(input_img);
    % ��ȡͼ��ĳߴ�
    M = size(I, 1);  
    N = size(I, 2);
    P = floor(M / 2);
    Q = floor(N / 2);
    % ȡ����
    log_img = log(double(I) + 1);
    % ���и���Ҷ�任
    trans_img = fft2(log_img);
    % ̬ͬ�˲�
    filtered_img = zeros(M, N);
    for u = 1:M
        for v = 1:N
            filtered_img(u, v) = homomorphic_filter_function(u, v, P, Q, gammaH, gammaL, C, D0) * trans_img(u, v);
        end
    end
    % ����Ҷ���任ȡʵ����ָ����ԭ
    processes_img = real(exp(ifft2(filtered_img)));
    % ȡ�������ʾЧ��
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
    % ����˲�ǰ��ͼ��
    figure;
    subplot(1,2,1),imshow(I),title('̬ͬ�˲�ǰ');
    subplot(1,2,2),imshow(processes_img),title('̬ͬ�˲���');
    