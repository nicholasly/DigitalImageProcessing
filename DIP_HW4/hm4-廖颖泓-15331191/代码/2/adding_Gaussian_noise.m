function output_img = adding_Gaussian_noise(input_img, a, v)
    % ��ȡ����ͼ���ȡͼ�����
    I = input_img;
    % ��ȡͼ��ĳߴ�
    [m,n] = size(I);
    % ������������
    n_gaussian = a + sqrt(v) .* randn(m,n);
    %�������
    output_img = uint8(double(I) + n_gaussian);
    % ��ӡͼ��
    figure;
    subplot(1,2,1),imshow(I),title('�������ǰͼ��');
    subplot(1,2,2),imshow(output_img),title('���������ͼ��');
    