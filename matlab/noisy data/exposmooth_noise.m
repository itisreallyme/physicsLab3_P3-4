clear
fid=fopen('monthly_global_temps.csv');
s=textscan(fid,'%s %s %f','Delimiter',',');
fclose(fid);
data = s{3};
y = zeros(length(data)/2);
y2 = zeros(length(data)/2);
x = zeros(length(data)/2);
for k = 1:length(data)
    if mod(k,2) == 0
        x(k/2) = k/2;
        y(k/2) = data(length(data)+1-k);
    end
end
for k = 1:length(data)
    if mod(k+1,2) == 0
        y2((k/2)+0.5) = data(length(data)+1-k);
    end
end

smoothing = 0.5;

y_s = zeros(length(y));
for i = 2:length(y)
    y_s(i) = smoothing * y(i-1) + (1-smoothing)*y(i);
end

y2_s = zeros(length(y2));
for i = 2:length(y2)
    y2_s(i) = smoothing * y2(i-1) + (1-smoothing)*y2(i);
end

plot(x,y,x,y_s)