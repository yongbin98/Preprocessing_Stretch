function [YPred] = cnn_model_train(x_train, y_train, x_test)

rng('shuffle');
r1 = randperm(length(x_train(1,:)));
K_fold = floor(length(r1)/5);

[x1_train y1_train x1_valid y1_valid] = valid_test_split(x_train, y_train, r1(1:K_fold));

test_len = length(x_test(1,:));
x_test = reshape(x_test,[1,100,1,test_len]);

% layer
layers = [
    imageInputLayer([1 100 1])
    convolution2dLayer([1 3],16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    averagePooling2dLayer([1 2],'Stride',2)
    convolution2dLayer([1 3],32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    averagePooling2dLayer([1 2],'Stride',2)
    dropoutLayer(0.2)
    fullyConnectedLayer(128)
    reluLayer
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer
];

% options
options = trainingOptions('adam');
options.MiniBatchSize = 64;
options.MaxEpochs = 30;
options.InitialLearnRate = 1e-3;
options.LearnRateSchedule = 'piecewise';
options.LearnRateDropFactor = 0.1;
options.LearnRateDropPeriod = 20;
options.Shuffle = 'every-epoch';
options.Verbose = false;
options.Plots = 'training-progress';
options.ValidationData = {x1_valid,y1_valid};
options.ValidationFrequency = 30;
options.ValidationPatience = 5;

% % train
% modelfile = 'best_model.h5';
% net = importKerasNetwork(modelfile);
net = trainNetwork(x1_train,y1_train,layers,options);
for i = 1:4
    [x1_train y1_train x1_valid y1_valid] = valid_test_split(x_train, y_train, r1((i*K_fold+1):K_fold*i+K_fold));
    options.ValidationData = {x1_valid,y1_valid};
    net = trainNetwork(x1_train,y1_train,net.Layers,options);
end

% result
YPred = predict(net,x_test);