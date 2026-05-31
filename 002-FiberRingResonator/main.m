%% 光纤环形谐振腔滤波响应分析
clc;clear;close all;
%% 全局参数
n  = 1.465155; % 光纤有效折射率（与子函数一致）
c0 = 299792458; % 真空光速 (m/s)，（与子函数一致）
freqSweep = (0 : 1e2 : 2e7)'; % 通用频率向量 (Hz)
L_default = 50; % 默认腔长 (m)
k_default = 0.7; % 默认耦合比
colorList = lines(10); % 颜色方案
%% 单组参数下的滤波响应（k = 0.7, L = 50 m）
H_single = fiberRingFilterResponse(freqSweep, k_default, L_default);
figure;
plot(freqSweep, H_single, 'Color', '#0072BD', 'LineWidth', 1.5);
title('Fiber Ring Filter Response (k = 0.7, L = 50 m)');
axis([0 1.638e7 -23 0]); grid on;
xlabel('Frequency (Hz)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Response (dB)',  'FontName', 'Times New Roman', 'FontSize', 10);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
%% 不同耦合比的光纤环滤波响应（固定腔长 L = 50 m）
kVec = 0.1 : 0.1 : 0.9; % 扫描耦合比
nK = length(kVec);
figure;
hold on;
lgd1 = cell(1, nK);
for i = 1:nK
    H = fiberRingFilterResponse(freqSweep, kVec(i), L_default);
    plot(freqSweep, H, 'Color', colorList(i,:), 'LineWidth', 1.2);
    lgd1{i} = ['k = ' num2str(kVec(i), '%.1f')];
end
hold off;
title('Filter Response vs. Coupling Ratio (L = 50 m)');
axis([0 1.638e7 -23 0]); grid on;
xlabel('Frequency (Hz)',   'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Response (dB)',    'FontName', 'Times New Roman', 'FontSize', 10);
legend(lgd1, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 10);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'Box', 'on');
%% 不同腔长的光纤环滤波响应（固定耦合比 k = 0.7）
Lvec = 30 : 10 : 80; % 扫描腔长
nL = length(Lvec);
figure;
hold on;
lgd2 = cell(1, nL);
for i = 1:nL
    H = fiberRingFilterResponse(freqSweep, k_default, Lvec(i));
    plot(freqSweep, H, 'Color', colorList(i,:), 'LineWidth', 1.2);
    lgd2{i} = ['L = ' num2str(Lvec(i)) ' m'];
end
hold off;
title('Filter Response vs. Fiber Length (k = 0.7)');
axis([0 6.838e6 -23 0]); grid on;
xlabel('Frequency (Hz)',   'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Response (dB)',    'FontName', 'Times New Roman', 'FontSize', 10);
legend(lgd2, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 10);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10, 'Box', 'on');
%% 耦合比与抑制比的关系（抑制比 = max(H) - min(H)）
kRR = (0 : 0.01 : 1)'; % 细扫耦合比
RR_k = zeros(size(kRR));
for i = 1:length(kRR)
    H = fiberRingFilterResponse(freqSweep, kRR(i), L_default);
    RR_k(i) = max(H) - min(H); % 抑制比 (dB)
end
figure;
plot(kRR, RR_k, 'Color', '#0072BD', 'LineWidth', 1.5);
title('Rejection Ratio vs. Coupling Ratio (L = 50 m)');
axis([0 1 0 ceil(max(RR_k)/5)*5]); grid on;
xlabel('Coupling Ratio',  'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Rejection Ratio (dB)', 'FontName', 'Times New Roman', 'FontSize', 10);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
%% 耦合比与 3 dB 带宽的关系
couplingRatio = (0.26 : 0.01 : 0.92)'; % 耦合比扫描范围（避开临界退化区）
numPoints = length(couplingRatio);
bandwidth3dB = zeros(numPoints, 1);
freqFinescan = (0 : 1e2 : 2.047e6)'; % 精细频率扫描（保证 -3 dB 定位精度）
for idx = 1:numPoints
    k = couplingRatio(idx);
    H = fiberRingFilterResponse(freqFinescan, k, 50);
    [~, idx3dB] = min(abs(H - (max(H) - 3))); % 最接近 -3 dB 的频率点
    bandwidth3dB(idx) = freqFinescan(idx3dB) * 2; % 双边 3 dB 带宽
end
figure;
plot(couplingRatio, bandwidth3dB, 'Color', '#0072BD', 'LineWidth', 1.5);
title('3 dB Bandwidth vs. Coupling Ratio (L = 50 m)');
xlim([0 1]); ylim([0 4.5e6]); grid on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
xlabel('Coupling Ratio', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('3 dB Bandwidth (Hz)', 'FontName', 'Times New Roman', 'FontSize', 10);
%% 光纤长度与抑制比的关系
LRR  = (30 : 0.5 : 80)';
RR_L = zeros(size(LRR));
for i = 1:length(LRR)
    H = fiberRingFilterResponse(freqSweep, k_default, LRR(i));
    RR_L(i) = max(H) - min(H);
end
figure;
plot(LRR, RR_L, 'Color', '#0072BD', 'LineWidth', 1.5);
title('Rejection Ratio vs. Fiber Length (k = 0.7)');
xlim([30 80]); ylim([0 ceil(max(RR_L)/5)*5]); grid on;
xlabel('Fiber Length (m)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Rejection Ratio (dB)', 'FontName', 'Times New Roman', 'FontSize', 10);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
%% 光纤长度与 3 dB 带宽的关系
fiberLength = (30 : 0.5 : 80)'; % 腔长扫描范围
numPoints = length(fiberLength);
bandwidth3dB = zeros(numPoints, 1);
freqFull = (0 : 1e3 : 2e7)'; % 全局频率向量
for idx = 1:numPoints
    L = fiberLength(idx);
    % 截取半个 FSR 范围内的频率（相位 ≤ π，即 f ≤ c / (2nL)）
    halfFSR = c0 / (2 * n * L);
    freqTrunc = freqFull(freqFull <= halfFSR);
    % 调用子函数计算滤波响应
    H = fiberRingFilterResponse(freqTrunc, 0.7, L);
    % 找到最接近 -3 dB 的频率点
    [~, idx3dB] = min(abs(H - (max(H) - 3)));
    bandwidth3dB(idx) = freqTrunc(idx3dB) * 2;   % 双边 3 dB 带宽
end
figure;
plot(fiberLength, bandwidth3dB, 'Color', '#0072BD', 'LineWidth', 1.5);
title('3 dB Bandwidth vs. Fiber Length (k = 0.7)');
xlim([30 80]); ylim([0.5e6 2.5e6]); grid on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
xlabel('Fiber Length (m)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('3 dB Bandwidth (Hz)', 'FontName', 'Times New Roman', 'FontSize', 10);
