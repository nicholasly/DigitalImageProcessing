function accuracy_analysis()
    x = 50:1:100;
    y = [];
    for i = 50:1:100
        temp = [];
        for j = 1:1:100
            accuracy = Eigenfaces(i);
            temp = [temp, accuracy];
        end
        avg = mean(temp);
        y = [y, avg];
    end
    plot(x,y);
    title('����ʶ��׼ȷ��');
    xlabel('����ά��');
    ylabel('����׼ȷ�ʰٷֱ�');
    axis([50 100 0.50 1.00]); 