function [output_img, H] = blurring_filter(input_img, a, b, T)
    % ��ȡ����ͼ���ȡͼ�����
    I = input_img;
    % ��ȡͼ��ĳߴ�
    [m,n] = size(I);
    % ����ƫ��������
    [v,u] = meshgrid(1:n,1:m);
    u = u - floor(m / 2);
    v = v - floor(n / 2);
    % �����˶�ģ��
    Fp = fftshift(fft2(I));
    G = filter_function(u, v, a, b, T) .* Fp;
    output_img = uint8(real(ifft2(ifftshift(G))));
    LA = fftshift(fft2(output_img));
    H = LA ./ double(Fp);
    % ��ӡͼ��
    figure;
    subplot(1,2,1),imshow(I),title('�˶�ģ��ǰͼ��');
    subplot(1,2,2),imshow(output_img),title('�˶�ģ����ͼ��');
