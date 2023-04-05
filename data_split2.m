function [data_time, data_split] = data_split2(raw, time, stretch_press)

data_time = raw(:,time);
data_split = rmmissing(raw(:,stretch_press));

