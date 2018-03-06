function output_img = inverse_filtering(input_img, H)
    % ��ȡ����ͼ���ȡͼ�����
    I = input_img;
    % �������˲�
    G = fftshift(fft2(I));
    F = G ./ H;
    output_img = uint8(abs(ifft2(fftshift(F))));
    % ��ӡͼ��
    figure;
    subplot(1,2,1),imshow(I),title('���˲�ǰͼ��');
    subplot(1,2,2),imshow(output_img),title('���˲���ͼ��');
    
