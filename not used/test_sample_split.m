function [x_train1, y_train1, x_test, y_test] = test_sample_split(sig_spline, test_size)

sample_split = 180;                             %   12s
sample_move = 90;                               %   6s
sample_label = length(sig_spline(1,:));         %   label 수
count_sample = 0;

for i = 1:sample_label
    % sample 수
    sample_num = floor(length(rmmissing(sig_spline(:,i)))/sample_move)-1;
    % 필요없는 데이터 제거
    clean_sig = sig_spline(1:(sample_num+1)*sample_move,i);
    
    for j = 1:sample_num
        count_sample=count_sample+1;
        x_train(1:sample_split,count_sample) = normalize(clean_sig(((j-1)*sample_move)+1:((j-1)*sample_move)+sample_split,1));
        y_train(1,count_sample) = i;
    end
end

rng('shuffle');
r1 = randperm(length(x_train(1,:)));

for i = 1 : length(r1)
   x_train1(:,i) = x_train(1:sample_split,r1(i));
   y_train1(1,i) = y_train(1,r1(i));
end

test_N = floor(test_size*length(r1));

% test & clear
for i = 1 : test_N
    x_test(1:sample_split,i) = x_train1(1:sample_split,i);
    y_test(1,i) = y_train1(1,i);
    x_train1(:,i) = [];
    y_train1(:,i) = [];
end
