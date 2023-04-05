clear all; close all; clc;

%% reorganize dataset
dataPath = 'Data\';
savePath = 'Result\';

if ~exist(savePath)
    mkdir(savePath);
end

raw_train_data = readmatrix([dataPath, 'Raw data.xlsx']);
raw_press_data = readmatrix([dataPath, 'various pressing data.csv']);
raw_stretch_data = readmatrix([daaPath, 'various stretching data.csv']);

% Row data
[stim_category, data_stretch, data_press] = data_split(raw_train_data, 2:4, 6:10);
[sig_spline] = data_spline(stim_category, data_stretch, data_press, 15);
[x_data, y_data, data_time, data_amplitude, locs1] = PeakSplit(sig_spline, [1 2 3 4 5 6 7 8]);
clear data_stretch data_press stim_category raw_train_data

% 추가 stretch
stim_category = [1 1 1 1 1 8 8 8 8 8 15 15 15 15 15];
data_column = [2:6 9:13 16:20];
sig_spline_stretch = zeros(length(raw_stretch_data),15);
for i = 1:15
    [data_time1, data_split_1] = data_split2(raw_stretch_data, stim_category(i), data_column(i));
    len = length(data_spline2(data_time1, data_split_1, 15));
    sig_spline_stretch(1:len,i) = data_spline2(data_time1, data_split_1, 15);
end

% 추가 press
stim_category = [1 1 1 1 1 8 8 8 8 8 15 15 15 15 15];
data_column = [2:6 9:13 16:20];
sig_spline_press = zeros(length(raw_press_data),15);
for i = 1:15
    [data_time1, data_split_1] = data_split2(raw_press_data, stim_category(i), data_column(i));
    len = length(data_spline2(data_time1, data_split_1, 15));
    sig_spline_press(1:len,i) = data_spline2(data_time1, data_split_1, 15);
end
clear stim_category data_column len data_time1 data_split_1 i raw_press_data raw_stretch_data

% merge all data
[x_data1, y_data1, data1_time, data1_amplitude, locs2] = PeakSplit(sig_spline_stretch,[1 2 2 2 3 1 2 2 2 3 1 2 2 2 3]);
[x_data2, y_data2, data2_time, data2_amplitude, locs3] = PeakSplit(sig_spline_press,[5 6 6 6 7 5 6 6 6 7 5 6 6 6 7]);
x_data = horzcat(x_data, x_data1,x_data2);
y_data = horzcat(y_data, y_data1,y_data2);
data_time= horzcat(data_time, data1_time, data2_time);
data_amplitude = horzcat(data_amplitude, data1_amplitude, data2_amplitude);
clear x_data1 x_data2 y_data1 y_data2 data1_time data2_time data1_amplitude data2_amplitude

% augmentation in matlab
[x_train, x_test, y_train, y_test, train_time, train_amplitude, test_time, test_amplitude] = data_split_stratify(x_data, y_data, data_time, data_amplitude, [1 2 3 4 5 6 7 8]);
[x_train, x_valid, y_train, y_valid, train_time, train_amplitude, valid_time, valid_amplitude] = data_split_stratify(x_train, y_train, train_time, train_amplitude, [1 2 3 4 5 6 7 8]);

[x_train, y_train, train_time, train_amplitude] = data_increase(x_train, y_train, train_time, train_amplitude, [1 2 3 4 5 6 7 8]);
[x_train, y_train, train_time, train_amplitude] = shuffleData(x_train, y_train, train_time, train_amplitude);
clear data1_amplitude data1_time data2_amplitude data2_time first_amplitude first_time second_amplitude second_time

x_data = x_data.';
data_amplitude = data_amplitude.';
data_time = data_time.';
x_data = horzcat(x_data,data_time,data_amplitude);
y_data = y_data.';
clear data_amplitude data_time

test_amplitude = test_amplitude.';
test_time = test_time.';
train_amplitude = train_amplitude.';
train_time = train_time.';
valid_amplitude = valid_amplitude.';
valid_time = valid_time.';
x_train = x_train.';
x_test = x_test.';
x_valid = x_valid.';
y_train = y_train.';
y_test = y_test.';
y_valid = y_valid.';

save("Result\stretch_press_data");
save("Result\sig_locs",'locs1','locs2','locs3','sig_spline','sig_spline_press','sig_spline_stretch');

%% temp DNN in matlab
% [result] = cnn_model_train(x_train, y_train, x_test);
% 
% for i = 1:length(result)
%     [summary(i,1) summary(i,2)] = max(result(i,:));
%     summary(i,3) = y_test(1,i);
% end
% 
% accuracy = 100 - (length(find(summary(:,2) ~= summary(:,3)))/numel(summary(:,3)))*100;
% 
% summary = readmatrix(['Result.csv']);
% summary=summary+1
% C = zeros(8,8);
% for i = 1:length(summary)
%     C(summary(i,3), summary(i,2)) = C(summary(i,3), summary(i,2))+1;
% end
% 
% error_index = find(summary(:,2) ~= summary(:,3));
% error = result(error_index,:);
% error(:,9) = summary(error_index,2);
% error(:,10) = summary(error_index,3);
