function [new_spline] = data_aug(sig_spline_strecth,sig_spline_press)

% 1
num = 1;
tmp2 = 0;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
for i = 0:2
    numi = 1;
    tmp1_len = length(nonzeros(sig_spline_strecth(:,(i*5)+numi)));
    tmp1 = nonzeros(sig_spline_strecth(1:tmp1_len-rem(length(nonzeros(sig_spline_strecth(:,(i*5)+numi))),180),(i*5)+numi));
    if(tmp2 == 0)
        tmp2 = tmp1;
    else
        tmp2 = vertcat(tmp1,tmp2);
    end
end
len = length(tmp2);
new_spline(1:len,1) = tmp2;

% 2
num = 2;
tmp2 = 0;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
for i = 1:3
    numi = (i*5)-3;
    tmp1_len = length(nonzeros(sig_spline_strecth(:,numi)));
    tmp1 = nonzeros(sig_spline_strecth(1:tmp1_len-rem(length(nonzeros(sig_spline_strecth(:,numi))),180),numi));
    if(tmp2 == 0)
        tmp2 = tmp1;
    else
        tmp2 = vertcat(tmp1,tmp2);
    end
    numi = (i*5)-2;
    tmp1_len = length(nonzeros(sig_spline_strecth(:,numi)));
    tmp1 = nonzeros(sig_spline_strecth(1:tmp1_len-rem(length(nonzeros(sig_spline_strecth(:,numi))),180),numi));
    tmp2 = vertcat(tmp1,tmp2);
    numi = (i*5)-1;
    tmp1_len = length(nonzeros(sig_spline_strecth(:,numi)));
    tmp1 = nonzeros(sig_spline_strecth(1:tmp1_len-rem(length(nonzeros(sig_spline_strecth(:,numi))),180),numi));
    tmp2 = vertcat(tmp1,tmp2);
    
end
len = length(tmp2);
new_spline(1:len,num) = tmp2;

% 3
num = 3;
tmp2 = 0;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
for i = 0:2
    numi = 5;
    tmp1_len = length(nonzeros(sig_spline_strecth(:,(i*5)+numi)));
    tmp1 = nonzeros(sig_spline_strecth(1:tmp1_len-rem(length(nonzeros(sig_spline_strecth(:,(i*5)+numi))),180),(i*5)+numi));
    if(tmp2 == 0)
        tmp2 = tmp1;
    else
        tmp2 = vertcat(tmp1,tmp2);
    end
end
len = length(tmp2);
new_spline(1:len,num) = tmp2;

% 4
% num = 4;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
% len = length(tmp2);
% new_spline(1:len,num) = tmp2;

% 5
num = 5;
tmp2 = 0;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
for i = 0:2
    numi = 1;
    tmp1_len = length(nonzeros(sig_spline_press(:,(i*5)+numi)));
    tmp1 = nonzeros(sig_spline_press(1:tmp1_len-rem(length(nonzeros(sig_spline_press(:,(i*5)+numi))),180),(i*5)+numi));
    if(tmp2 == 0)
        tmp2 = tmp1;
    else
        tmp2 = vertcat(tmp1,tmp2);
    end
end
len = length(tmp2);
new_spline(1:len,num) = tmp2;

% 6
num = 6;
tmp2 = 0;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
for i = 0:2
    numi = 2;
    tmp1_len = length(nonzeros(sig_spline_press(:,numi)));
    tmp1 = nonzeros(sig_spline_press(1:tmp1_len-rem(length(nonzeros(sig_spline_press(:,numi))),180),numi));
    if(tmp2 == 0)
        tmp2 = tmp1;
    else
        tmp2 = vertcat(tmp1,tmp2);
    end
    numi = 3;
    tmp1_len = length(nonzeros(sig_spline_press(:,numi)));
    tmp1 = nonzeros(sig_spline_press(1:tmp1_len-rem(length(nonzeros(sig_spline_press(:,numi))),180),numi));
    tmp2 = vertcat(tmp1,tmp2);
    numi = 4;
    tmp1_len = length(nonzeros(sig_spline_press(:,numi)));
    tmp1 = nonzeros(sig_spline_press(1:tmp1_len-rem(length(nonzeros(sig_spline_press(:,numi))),180),numi));
    tmp2 = vertcat(tmp1,tmp2);
end
len = length(tmp2);
new_spline(1:len,num) = tmp2;

% 7
num = 7;
tmp2 = 0;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
for i = 0:2
    numi = 5;
    tmp1_len = length(nonzeros(sig_spline_press(:,(i*5)+numi)));
    tmp1 = nonzeros(sig_spline_press(1:tmp1_len-rem(length(nonzeros(sig_spline_press(:,(i*5)+numi))),180),(i*5)+numi));
    if(tmp2 == 0)
        tmp2 = tmp1;
    else
        tmp2 = vertcat(tmp1,tmp2);
    end
end
len = length(tmp2);
new_spline(1:len,num) = tmp2;

% 8
% num = 8;
% tmp1_len = length(rmmissing(sig_spline(:,num)));
% tmp2 = rmmissing(sig_spline(1:tmp1_len-rem(length(nonzeros(sig_spline(:,num))),180),num));
% len = length(tmp2);
% new_spline(1:len,num) = tmp2;
