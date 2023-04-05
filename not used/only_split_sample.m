function [x_train, y_train, x_test, y_test] = only_split_sample(x_data, y_data)

x_test = x_data(:,round(8*length(y_data)/10):length(y_data));
y_test = y_data(:,round(8*length(y_data)/10):length(y_data));
x_data(:,round(8*length(y_data)/10):length(y_data)) = [];
y_data(:,round(8*length(y_data)/10):length(y_data)) = [];
x_train = x_data;
y_train = y_data;
