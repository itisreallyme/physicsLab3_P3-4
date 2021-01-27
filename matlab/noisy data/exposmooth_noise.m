clear
T = readtable('monthly_csv.csv');
T.Source = categorical(T.Source);
gcag_rows = T.Source=='GCAG';
gistemp_rows = T.Source=='GISTEMP';
temps = {'Date','TempC'};
gcag = T(gcag_rows,temps);
gistemp = T(gistemp_rows,temps);

smoothing = 0.05;

gcag_fil(1:length(gcag.TempC)) = zeros();
gcag_fil(1) = gcag.TempC(1);
for i = 2:length(gcag.TempC)
    gcag_fil(i) = smoothing * gcag.TempC(i) + (1-smoothing)*gcag_fil(i-1);
end

gistemp_fil(1:length(gistemp.TempC)) = zeros();
gistemp_fil(1) = gistemp.TempC(1);
for i = 2:length(gistemp.TempC)
    gistemp_fil(i) = smoothing * gistemp.TempC(i) + (1-smoothing)*gistemp_fil(i-1);
end

% plot(gcag.Date,gcag.TempC,gcag.Date,gcag_fil)
plot(gistemp.Date,gistemp.TempC,gistemp.Date,gistemp_fil)
title('Mean global temperature 1880-2016')
xlabel('Years')
ylabel('Mean Temperature / °C')
legend({'raw','filtered'},'Location','southeast')
axis tight