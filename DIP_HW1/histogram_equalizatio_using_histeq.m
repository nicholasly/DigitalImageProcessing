I = imread('river.JPG');
J = histeq(I);
figure;
subplot(2,2,1),imshow(I),title('���⻯ǰ');
subplot(2,2,2),imhist(I,64),title('���⻯ǰ�ĻҶ�ֱ��ͼ');
subplot(2,2,3),imshow(J),title('���⻯��');
subplot(2,2,4),imhist(J,64),title('���⻯��ĻҶ�ֱ��ͼ')