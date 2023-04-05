function [x_test1, y_test1] = only_test_sample_split(sig_spline)

sample_split = 180;                             %   12s
sample_move = 90;                               %   6s
sample_label = length(sig_spline(1,:));         %   label 수
count_sample = 0;

for i = 1:sample_label
    % sample 수
    sample_num = floor(length(nonzeros(sig_spline(:,i)))/sample_move)-1;
    % 필요없는 데이터 제거
    clean_sig = sig_spline(1:(sample_num+1)*sample_move,i);
    
    for j = 1:sample_num
        count_sample=count_sample+1;
        x_test(1:sample_split,count_sample) = normalize(clean_sig(((j-1)*sample_move)+1:((j-1)*sample_move)+sample_split,1));
        y_test(1,count_sample) = i;
    end
end

rng('shuffle');
r1 = randperm(length(x_test(1,:)));

for i = 1 : length(r1)
   x_test1(:,i) = x_test(1:sample_split,r1(i));
   y_test1(1,i) = y_test(1,r1(i));
end