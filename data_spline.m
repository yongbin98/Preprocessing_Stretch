function [new_spline] = data_spline(time ,data_stretch, data_press, fs)

% data spline
sig_column = length(data_stretch(1,:)) + length(data_press(1,:));
if length(data_stretch) > length(data_press)
    sig_row = length(data_stretch);
    sig_spline = zeros(sig_row,sig_column);
    sig_spline(:,1:length(data_stretch(1,:))) = data_stretch(:,1:length(data_stretch(1,:)));
    data_press((length(data_press)+1):sig_row,:) = nan;
    sig_spline(:,(length(data_stretch(1,:))+1):sig_column) = data_press(:,1:length(data_press(1,:)));
else
    sig_row = length(data_press);
    sig_spline = zeros(sig_row,sig_column);
    sig_spline(:,(length(data_stretch(1,:))+1):sig_column) = data_press(:,1:length(data_press(1,:)));
    data_stretch((length(data_stretch)+1):sig_row,:) = nan;
    sig_spline(:,1:length(data_stretch(1,:))) = data_stretch(:,1:length(data_stretch(1,:)));
end

Ld = length(sig_spline);
sig_time = time(1):1/fs:time(Ld);
new_spline = zeros(length(sig_time), sig_column);

for i = 1:sig_column
    Ld = length(rmmissing(sig_spline(:, i)));
    sig_time = time(1):1/fs:time(Ld);
    if length(sig_time) ~= length(new_spline)
        tmp = spline(time(1:Ld,1), sig_spline(1:Ld,i), sig_time);
        tmp = tmp.';
        tmp((Ld+1):length(new_spline),:) = nan;
        new_spline(:,i) = tmp;
    else
        new_spline(:,i) = spline(time(1:Ld,1), sig_spline(1:Ld,i), sig_time);
    end
end