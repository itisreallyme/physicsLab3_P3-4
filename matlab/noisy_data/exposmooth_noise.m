clear
% call csv import and clear unnecessary rows and columns
generated_table_import;
GLB([1,2],:) = [];
GLB(:,[14:19]) = [];

% initialize line vectors to hold the time stamps and temperatures
gistime(1:height(GLB)*(width(GLB)-1)) = zeros();
gistemp(1:height(GLB)*(width(GLB)-1)) = zeros();

% do some math to convert the first columns numeric data to more convinient
% datetime format
k = 0;
for row = 1:height(GLB)
    for col = 2:width(GLB)
        k = k + 1;
        gistime(k) = GLB.Year(row)*10000+(col-1)*100+1;
        gistemp(k) = GLB.(col)(row);
    end
end
gistime = datetime(gistime,'ConvertFrom','yyyyMMdd','Format','yyyy-MM-dd');

% apply exp filter to the temperature data
smoothing = 0.01;

gistemp_fil(1:length(gistemp)) = zeros();
gistemp_fil(1) = gistemp(1);
for k = 2:length(gistemp)
    gistemp_fil(k) = smoothing * gistemp(k) + (1-smoothing)*gistemp_fil(k-1);
end

% plotting
p = plot(gistime,gistemp,gistime,gistemp_fil);
p(1).LineWidth = 0.2;
p(1).Color = '#99c2ff';
p(2).LineWidth = 1;
p(2).Color = 'k';
ax = gca;
ax.XAxis.FontSize = 18;
ax.YAxis.FontSize = 18;
title('Mean global temperature 1880-2020 (GISTEMP)', 'FontSize', 20)
xlabel('Monthly')
ylabel('Mean Temperature / °C')
legend({'Raw','Filtered, \alpha = 0.01'},'Location','southeast', 'FontSize', 18)
axis tight