function [data_time, data_stretch, data_press] = data_split(raw, stretch, press)

time = 1;

data_time = rmmissing(raw(:,time));
data_stretch = rmmissing(raw(:,stretch));
data_press = rmmissing(raw(:,press));
