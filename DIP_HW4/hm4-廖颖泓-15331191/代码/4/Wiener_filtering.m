function output_img = Wiener_filtering(input_img, original_img, H, K)
    % ��ȡ����ͼ���ȡͼ�����
    I = input_img;
    % ��ȡͼ��ĳߴ�
    [m, n] = size(I);
    % ���и���Ҷ�任
    F0 = fftshift(fft2(I));
    F = fftshift(fft2(original_img));
    % ����ά���˲�
    for u = 1:m
        for v = 1:n  
            H0(u, v) = (abs(H(u,v)))^2;
            H1(u, v) = H0(u,v) / (H(u,v) * (H0(u,v) + K));  
            F2(u, v) = H1(u,v) * F0(u,v);
        end
    end
    output_img = uint8(abs(ifft2(ifftshift(F2))));
     % ��ӡͼ��
    figure;
    subplot(1,2,1),imshow(I),title('ά���˲�ǰͼ��');
    subplot(1,2,2),imshow(output_img),title('ά���˲���ͼ��');

 