function accuracy = Eigenfaces(k)
    % k为特征维数
    random = randperm(10);
    train = random(1:7);
    test = random(8:10);
    % 读取人脸训练图像
    X = [];
    for i = 1:40
        for j = 1:7
            temp = imread(strcat('s',num2str(i),'\',num2str(train(j)),'.pgm'));
            temp = double(temp(:));
            X = [X, temp];
        end
    end
    N = size(X,2);
    % 计算训练图像均值和差值
    xmean = mean(X,2);
    for i = 1:N
        X(:,i) = X(:,i) - xmean;
    end
    L = X'* X;
    % 计算协方差矩阵
    [V, latent, explained] = pcacov(L);
    % 特征脸
    W = X * V;
    W = W(:,1:k);
    % 训练样本在新坐标基下的表达矩阵
    reference = W' * X;
    % 读取人脸测试图像
    Y = [];
    for i = 1:40
        for j = 1:3
            temp = imread(strcat('s',num2str(i),'\',num2str(test(j)),'.pgm'));
            temp = double(temp(:));
            Y = [Y, temp];
        end
    end
    M = size(Y,2);
    %计算测试图像均值和差值
    ymean = mean(Y,2);
    for i = 1:M
        Y(:,i) = Y(:,i) - ymean;
    end
    object = W'* Y;
    % 2范数最小匹配寻找和测试图片最相近的训练图像
    correctnum = 0;
    for i = 1:M
        distance = 999999999999;
        for j = 1:N
            % 2范数最小匹配
            temp = norm(object(:,i) - reference(:,j), 2);
            if (distance > temp)
                aim = j;
                distance = temp;
            end
        end
        % 如果测试图像与选定训练图像在同一文件夹则正确数加1
        if ceil(i/3) == ceil(aim/7)
            correctnum = correctnum + 1;
        end
    end
    % 正确率
    accuracy = correctnum / M;
    