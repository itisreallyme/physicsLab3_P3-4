clear

location = 'C:\Users\Hunter\Documents\HSRM\WISE20-21\Phys Praktikum 3\Versuche\4\messdaten\calib\';
% file = ['calib_null.txt'; 'calib_50mg.txt'; 'calib_500mg.txt'; 'calib_550mg.txt'; 'calib_5000mg.txt'; 'calib_5050mg.txt'; 'calib_5500mg.txt'; 'calib_5550mg.txt'];
fileinfo = dir(append(location,'*.txt'));
files = {fileinfo.name};
TimeVec = [];
RawVec = [];
FilteredVec = [];
filteredRaw = [];

for j = 1:length(files)
    data = importdata(append(location,files{j}));
    Time = data(:,1);
    raw = data(:,2);
    filtered = data(:,3);
%     Time = Time - min(Time);
    DeviationVec(j) = std(raw);
    MeanVec(j) = mean(raw);
    TimeVec = [TimeVec; Time];
    RawVec = [RawVec; raw];
    FilteredVec = [FilteredVec; filtered];
    raw = expoFilter(raw, 0.02);
    filteredRaw = [filteredRaw; raw];
end
TimeVec = 0:1:length(TimeVec)-1;
% deviation = std(raw);
% mean = mean(raw);

hold on
p(1) = plot(TimeVec, RawVec,'.-');
p(2) = plot(TimeVec, filteredRaw,'.-');
hold off
p(1).LineWidth = 0.2;
p(1).Color = '#99c2ff';
p(2).LineWidth = 1;
p(2).Color = 'k';
ax = gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
title('Raw vs. Filtered ADC Data, sets continuously attached w/o specific order', 'FontSize', 20)
xlabel('Measurement no.')
ylabel('Datapoints')
legend({'Raw','Filtered'},'Location','southeast', 'FontSize', 18)
axis tight