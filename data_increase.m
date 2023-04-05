function [sorted_x sorted_y, sorted_time, sorted_amplitude] = data_increase(xdata, ydata, data_time, data_amplitude, data_num)

resample_num = 110;

% sort data
[sorted_y, I] = sort(ydata);
sorted_x = xdata(:,I);
sorted_time = data_time(:,I);
sorted_amplitude = data_amplitude(:,I);

% find max length label
max = data_num(1);
max_length = length(find(ydata == data_num(1)));
for i = 2:length(data_num)
   if(length(find(ydata == max)) < length(find(ydata == data_num(i))))
       max = data_num(i);
       max_length = length(find(ydata == data_num(i)));
   end
end


% increase data
rng('shuffle');
for i = 1:length(data_num)
    increase_num = max_length - length(find(ydata == data_num(i)));
    rand_num = randi([-5 5],1,increase_num);
    x_num = randi([find(sorted_y == data_num(i),1) find(sorted_y == data_num(i),1,'last')], 1, increase_num);
    for j = 1:increase_num
        for z = 1:resample_num
            if(z+rand_num(j) > resample_num)
                new_xdata(z) = sorted_x(z+rand_num(j)-resample_num,x_num(j));
            elseif(z+rand_num(j) <= 0)
                new_xdata(z) = sorted_x(z+rand_num(j)+resample_num,x_num(j));
            else
                new_xdata(z) = sorted_x(z+rand_num(j),x_num(j));
            end
        end
        sorted_x(:,length(sorted_x(1,:))+1) = new_xdata;
        sorted_y(1,length(sorted_y)+1) = data_num(i);
        sorted_time(1,length(sorted_time)+1) = data_time(x_num(j));        
        sorted_amplitude(1,length(sorted_amplitude)+1) = data_amplitude(x_num(j));
    end
end