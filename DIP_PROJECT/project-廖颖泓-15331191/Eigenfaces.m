function accuracy = Eigenfaces(k)
    % kΪ����ά��
    random = randperm(10);
    train = random(1:7);
    test = random(8:10);
    % ��ȡ����ѵ��ͼ��
    X = [];
    for i = 1:40
        for j = 1:7
            temp = imread(strcat('s',num2str(i),'\',num2str(train(j)),'.pgm'));
            temp = double(temp(:));
            X = [X, temp];
        end
    end
    N = size(X,2);
    % ����ѵ��ͼ���ֵ�Ͳ�ֵ
    xmean = mean(X,2);
    for i = 1:N
        X(:,i) = X(:,i) - xmean;
    end
    L = X'* X;
    % ����Э�������
    [V, latent, explained] = pcacov(L);
    % ������
    W = X * V;
    W = W(:,1:k);
    % ѵ����������������µı�����
    reference = W' * X;
    % ��ȡ��������ͼ��
    Y = [];
    for i = 1:40
        for j = 1:3
            temp = imread(strcat('s',num2str(i),'\',num2str(test(j)),'.pgm'));
            temp = double(temp(:));
            Y = [Y, temp];
        end
    end
    M = size(Y,2);
    %�������ͼ���ֵ�Ͳ�ֵ
    ymean = mean(Y,2);
    for i = 1:M
        Y(:,i) = Y(:,i) - ymean;
    end
    object = W'* Y;
    % 2������Сƥ��Ѱ�ҺͲ���ͼƬ�������ѵ��ͼ��
    correctnum = 0;
    for i = 1:M
        distance = 999999999999;
        for j = 1:N
            % 2������Сƥ��
            temp = norm(object(:,i) - reference(:,j), 2);
            if (distance > temp)
                aim = j;
                distance = temp;
            end
        end
        % �������ͼ����ѡ��ѵ��ͼ����ͬһ�ļ�������ȷ����1
        if ceil(i/3) == ceil(aim/7)
            correctnum = correctnum + 1;
        end
    end
    % ��ȷ��
    accuracy = correctnum / M;
    