clear

% generate our step function
points = 1000;
data(1:points/2) = zeros();
data((points/2)+1:points) = ones();

% defining smoothing factors
smoothing1 = 0.01;
smoothing2 = 0.05;
smoothing3 = 0.5;

% expo filter magic
data_fil(1:length(data),1:3) = zeros();
for k = 2:length(data)
    data_fil(k,1) = smoothing1 * data(k) + (1-smoothing1)*data_fil(k-1,1);
    data_fil(k,2) = smoothing2 * data(k) + (1-smoothing2)*data_fil(k-1,2);
    data_fil(k,3) = smoothing3 * data(k) + (1-smoothing3)*data_fil(k-1,3);
end

% plot stuff
p = plot(1:length(data),data,1:length(data),data_fil)
p(1).LineWidth = 1;
p(1).Color = '#99c2ff';
p(2).LineWidth = 1.5;
p(2).Color = '#EDB120';
p(3).LineWidth = 1.5;
p(3).Color = '#77AC30';
p(4).LineWidth = 1.5;
p(4).Color = 'k';
ax = gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
title('Generic Data to simulate Step Response of an Exponential Filter', 'FontSize', 20)
legend({'Raw','Filtered, \alpha = 0.01','Filtered, \alpha = 0.05','Filtered, \alpha = 0.5'},'Location','southeast', 'FontSize', 18)
axis tight