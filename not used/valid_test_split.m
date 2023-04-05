function [x1_train, y1_train, x1_valid, y1_valid] = valid_test_split(x_train, y_train, r1)

train_count = 1;
valid_count = 1;

for i = 1 : length(x_train(1,:))
    if isempty(find(i==r1(:)))
        % r1에 없는 값
        x1_train(:,train_count) = x_train(:,i);
        y1_train(:,train_count) = y_train(:,i);
        train_count = train_count+1;
    else
        % r1 값이 있음
        x1_valid(:,valid_count) = x_train(:,i);
        y1_valid(:,valid_count) = y_train(:,i);
        valid_count = valid_count+1;
    end
end

train_len = length(y1_train(1,:));
valid_len = length(y1_valid(1,:));

% sample split 12s sample move 6s
x1_train = reshape(x1_train,[1,100,1,train_len]);         
%y_train = reshape(y_train,[1,1,1,train_len]);
x1_valid = reshape(x1_valid,[1,100,1,valid_len]);
%y_valid = reshape(y_valid,[1,1,1,valid_len]);

% one hot
y1_valid = categorical(y1_valid,1:max(y1_valid)).';
y1_train = categorical(y1_train,1:max(y1_train)).';