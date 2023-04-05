function [new_spline] = data_spline2(time ,data_split, fs)

% data spline
Ld = length(data_split);
sig_time = time(1):1/fs:time(Ld);
new_spline = spline(time(1:Ld,1), data_split(1:Ld,1), sig_time).';
