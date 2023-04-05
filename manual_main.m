clear all; close all; clc;

%% save resample data
load("Result\sig_locs");

resample = 150;
[x_data1, y_data1] = locs_split(sig_spline, locs1, [1 2 3 4 5 6 7 8],resample);
[x_data2, y_data2] = locs_split(sig_spline_stretch, locs2, [1 2 2 2 3 1 2 2 2 3 1 2 2 2 3],resample);
[x_data3, y_data3] = locs_split(sig_spline_press, locs3, [5 6 6 6 7 5 6 6 6 7 5 6 6 6 7],resample);

x_data = horzcat(x_data1,x_data2,x_data3);
y_data = horzcat(y_data1,y_data2,y_data3);

clearvars -except x_data y_data resample
x_data = x_data.';
y_data = y_data.';
save("Result\stretch_press_data_" + num2str(resample), 'x_data','y_data');


%% save figure
saveRootPath = 'Figure\';
if ~exist(saveRootPath)
    mkdir(saveRootPath);
end

for i = 1:8
   figT = figure;
   plot(x_data(find(y_data == i,1),1:160));
   xlim([1 160]);
   set(gca, 'xtick', [], 'ytick', []);  
%    ax = gca;
%    set(ax.YAxis, 'visible', 'off');
%    set(ax.XAxis, 'visible', 'off');
%    if(i < 4)
%        title(['Stretching ',num2str(10*i),'%'],'Fontsize',22,'Fontname','Times New Roman');
%    else
%        title(['Pressing ',num2str((i-3)/2),'N'],'Fontsize',22,'Fontname','Times New Roman');
%    end
%    ylabel('Normalized current','Fontsize',22,'Fontname','Times New Roman');
%    xlabel('Time (s)','Fontsize',22,'Fontname','Times New Roman');
   saveas(figT,['Figure\','plot',num2str(9),'.png'])
end

% for i = 1:10
%     figT = figure;
%     plot(sig_spline(locs1(7)-10:locs1(7+1)+10,1));
%     hold on
%     plot(11,sig_spline(locs1(7),1),'o');
%     plot(locs1(8)-locs1(7)+11,sig_spline(locs1(8),1),'o');
%     hold off
% 
%     set(gca, 'xtick', [], 'ytick', []);  
%     % set(gca, 'box', 'off');
%     % ax = gca;
%     % set(ax.YAxis, 'visible', 'off');
%     % set(ax.XAxis, 'visible', 'off');
%     xlim([1 locs1(i+1)-locs1(i)+21]);
%     saveas(figT,['Figure\','plot',num2str(i+4),'.png'])
% end