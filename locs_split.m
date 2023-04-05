function [x_data, y_data] = locs_split(data, locs, label,resample_num)

sample_len = 10;

for i = 1:length(label)
    cleaned_data = nonzeros(rmmissing(data(:,i)));
    count = 0;
    locs_tail = 0;
    
    j = 1;
    while(j < length(locs))
        locs_head = locs_tail+1;        
        if(locs(j) > locs(j+1) || j == length(locs)-1)
            if(j == length(locs)-1)
                locs_tail = j+1;
            else
                locs_tail = j;
            end
            count=count+1;
            if (i == count)
                j = length(locs)-1;
            end
        end
        j=j+1;
    end
    
    for j = locs_head:locs_tail-1
        locs(j) = locs(j)-sample_len;
        if(locs(j) < 1)
            locs(j) = 1;
        end
        locs(j+1) = locs(j+1)+sample_len;
        if(locs(j+1) > length(cleaned_data))
            locs(j+1) = length(cleaned_data);
        end
        
        tmp_data = cleaned_data(locs(j):locs(j+1));
        xx = 1:((length(tmp_data)-1)/(resample_num-1)):length(tmp_data);
        x = 1:length(tmp_data);        
        x_data(:,j) = spline(x,tmp_data,xx);
        x_data(:,j) = normalize(x_data(:,j)); % normalize
        time(j) = locs(j+1) - locs(j)+21;
        amplitude(j) = max(tmp_data) - min(tmp_data);
        y_data(j) = label(i);
        locs(j+1) = locs(j+1)-sample_len;        
    end
    
end
x_data(resample_num+1,:) = time;
x_data(resample_num+2,:) = amplitude;
x_data(:,find(y_data == 0)) = [];
y_data(find(y_data == 0)) = [];