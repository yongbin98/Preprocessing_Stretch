function [x_train, x_test, y_train, y_test, train_time, train_amplitude, test_time, test_amplitude] = data_split_stratify(x_data, y_data, data_time, data_amplitude, label)

% sort data
[y_data, I] = sort(y_data);
x_data = x_data(:,I);
data_time = data_time(:,I);
data_amplitude = data_amplitude(:,I);

% stratify split
test_count = 0;
train_count = 0;
rng('shuffle');
for i = 1:length(label)
    test_num = randperm(find(y_data == label(i),1,'last') - find(y_data == label(i),1)+1,round(length(find(y_data == label(i)))*0.2)) + find(y_data == label(i),1)-1;
    size_test = 1;
    size_train = 1;
    for j = find(y_data == label(i),1):find(y_data == label(i),1,'last')
        if find(j == test_num)
            x_test(:,size_test+test_count) = x_data(:,j);
            y_test(:,size_test+test_count) = y_data(1,j);
            test_time(:,size_test+test_count) = data_time(1,j);
            test_amplitude(:,size_test+test_count) = data_amplitude(1,j);
            size_test = size_test+1;
        else
            x_train(:,size_train+train_count) = x_data(:,j);
            y_train(:,size_train+train_count) = y_data(1,j);
            train_time(:,size_train+train_count) = data_time(1,j);
            train_amplitude(:,size_train+train_count) = data_amplitude(1,j);
            size_train = size_train+1;
        end
    end
    train_count = train_count+length(find(y_data == label(i)))-length(test_num);
    test_count = test_count+length(test_num);
end