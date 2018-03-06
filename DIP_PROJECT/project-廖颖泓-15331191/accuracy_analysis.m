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
    title('人脸识别准确率');
    xlabel('特征维数');
    ylabel('测试准确率百分比');
    axis([50 100 0.50 1.00]); 