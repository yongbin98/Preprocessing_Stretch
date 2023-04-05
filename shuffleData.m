function [shuffleX_data, shuffleY_data, shuffle_time, shuffle_amplitude] = shuffleData(x_data, y_data, train_time, train_amplitude)

x_data_sample = 110;

rng('shuffle');
r1 = randperm(length(y_data(1,:)));

for i = 1 : length(r1)
   shuffleX_data(:,i) = x_data(1:x_data_sample,r1(i));
   shuffleY_data(1,i) = y_data(1,r1(i));
   shuffle_time(1,i) = train_time(1,r1(i));
   shuffle_amplitude(1,i) = train_amplitude(1,r1(i));
   %plot(x_data(1:x_data_sample,r1(i)))
end