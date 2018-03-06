I = imread('river.JPG');
J = histeq(I);
figure;
subplot(2,2,1),imshow(I),title('均衡化前');
subplot(2,2,2),imhist(I,64),title('均衡化前的灰度直方图');
subplot(2,2,3),imshow(J),title('均衡化后');
subplot(2,2,4),imhist(J,64),title('均衡化后的灰度直方图')