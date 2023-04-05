function [x_data y_data, time, amplitude, p_locs] = PeakSplit(data, label)

data_length = 0;
resample_num = 110;
p_locs = 0;

for i = 1:length(label)
    cleaned_data = nonzeros(rmmissing(data(:,i)));
    min_thres = 20;
    max_thres = 70;
    mean_thres = 70;
    idx_split = 10;
    for j = 1:idx_split
        threshold_idx(j) = round(j*length(cleaned_data)/idx_split);
        if(j == 1)
            min_threshold(j) = prctile(cleaned_data(1:threshold_idx(j)),min_thres);
            mean_threshold(j) = prctile(cleaned_data(1:threshold_idx(j)),mean_thres);
            max_threshold(j) = prctile(cleaned_data(1:threshold_idx(j)),max_thres);
        else
            min_threshold(j) = prctile(cleaned_data(1:threshold_idx(j)),min_thres);
            mean_threshold(j) = prctile(cleaned_data(1:threshold_idx(j)),mean_thres);
            max_threshold(j) = prctile(cleaned_data(threshold_idx(j-1)+1:threshold_idx(j)),max_thres);
        end
    end
        
    [pks, locs] = findpeaks(cleaned_data);
    
    % erase low peak
    count_pks = 1;
    count_mean = 1;    
    for j = 1 : length(pks)-1
        if(threshold_idx(count_mean) < locs(j))
            count_mean=count_mean+1;
        end
        
        if(pks(j) > max_threshold(count_mean))
            high_pks(count_pks) = pks(j);
            high_locs(count_pks) = locs(j);
            count_pks=count_pks+1;
        end
    end
    
    % sort same peak use high peak
    same_num=0;
    peak_num=1;
    count_mean=1;
    for j = 1 : length(high_pks)-1
        if(threshold_idx(count_mean) < high_locs(j))
            count_mean=count_mean+1;
        end
        
        if(mean(cleaned_data(high_locs(j):high_locs(j+1))) > mean_threshold(count_mean))
            same_num=same_num+1;
        else
            [sort_pks(peak_num) sort_locs(peak_num)] = max(high_pks(j-same_num:j));
            sort_locs(peak_num) = high_locs(sort_locs(peak_num)+j-same_num-1);
            same_num=0;
            peak_num=peak_num+1;
        end
        
        if(j == length(high_pks)-1)
            [sort_pks(peak_num) sort_locs(peak_num)] = max(high_pks(j+1-same_num:j+1));
            sort_locs(peak_num) = high_locs(sort_locs(peak_num)+j-same_num);
            same_num=0;
        end
    end
    
    % sort same peak use low peak
    same_num=0;
    peak_num=1;
    count_mean=1;
    for j = 1 : length(sort_pks)-1
        if(threshold_idx(count_mean) < sort_locs(j))
            count_mean=count_mean+1;
        end
        
        if(min(cleaned_data(sort_locs(j):sort_locs(j+1))) > min_threshold(count_mean))
            same_num=same_num+1;
        else
            [sort2_pks(peak_num) sort2_locs(peak_num)] = max(sort_pks(j-same_num:j));
            sort2_locs(peak_num) = sort_locs(sort2_locs(peak_num)+j-same_num-1);
            same_num=0;
            peak_num=peak_num+1;
        end
        
        if(j == length(sort_pks)-1 )
            [sort2_pks(peak_num) sort2_locs(peak_num)] = max(sort_pks(j-same_num+1:j+1));
            sort2_locs(peak_num) = sort_locs(sort2_locs(peak_num)+j-same_num);
            same_num=0;
        end
    end
    
    % sort sample use diff
    diff_locs = diff(sort2_locs);
    j = 1;
    while(j<length(diff_locs)-1)
        if(diff_locs(j) < (prctile(diff_locs,50)*0.8))
            if(diff_locs(j+1) < (prctile(diff_locs,50)*0.8))
                diff_locs(j) = diff_locs(j) + diff_locs(j+1);
                diff_locs(j+1) = [];
                sort2_locs(j+1) = [];
                sort2_pks(j+1) = [];
            end
        end
        j=j+1;
    end
    
    % sampling
    sample_len = 10;
    mean_diff = prctile(diff_locs+(sample_len*2),50);
    data_head = sort2_locs(1);
    data_tail = 1;
    for j = 2 : length(sort2_pks)-1
        data_head = data_head-sample_len;
        if(data_head < 1)
            data_head = 1;
        end
        data_tail= sort2_locs(j)+sample_len;
        if(data_tail > length(cleaned_data))
            data_tail = length(cleaned_data);
        end
        if(data_tail - data_head < mean_diff*1.4 && data_tail - data_head > mean_diff*0.6)
            tmp_data = cleaned_data(data_head:data_tail);
            xx = 1:(1/resample_num):length(tmp_data);
            x = 1:length(tmp_data);
            time(data_length+j-1) = data_tail - data_head+1;
            amplitude(data_length+j-1) = max(tmp_data) - min(tmp_data);
            x_data(:,data_length+j-1) = downsample(spline(x,tmp_data,xx),length(tmp_data)-1);
            x_data(:,data_length+j-1) = normalize(x_data(:,data_length+j-1)); % normalize
            y_data(data_length+j-1) = label(i);            
        else
            tiledlayout(3,1);
            nexttile
            plot(cleaned_data(:));
            title("total data");
            hold on
            plot(sort2_locs,sort2_pks,'o');
            hold off
            nexttile
            plot(diff(sort2_locs));
            title("diff");
            nexttile
            plot(tmp_data);
            data_length = data_length-1;
        end
%         tiledlayout(2,1);
%         nexttile
%         plot(x_data(:,data_length+j-1))
%         nexttile
%         plot(cleaned_data(data_head-5:data_tail+5));
        data_head = data_tail-sample_len;
    end
    
    tiledlayout(3,1);
    nexttile
    plot(cleaned_data(:));
    title("total data");
    hold on
    plot(sort2_locs,sort2_pks,'o');
    hold off
    nexttile
    plot(diff(sort2_locs));
    title("diff");
    nexttile
    plot(x_data(1:resample_num,data_length+7));
    title("split data");
    
    if(length(p_locs) == 1)
        p_locs(1:length(sort2_locs)) = sort2_locs;
    else
        p_locs(length(p_locs)+1:length(p_locs)+length(sort2_locs)) = sort2_locs;
    end
    data_length = length(x_data(1,:));
    clear data_mean data_mean_idx high_pks high_locs sort_pks sort_locs sort2_pks sort2_locs
end
x_data(resample_num+1,:,:) = [];