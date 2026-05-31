%% MZI 梳状滤波器仿真
clc; clear; close all;
%% 参数设置
lambda_0 = 1550; % 中心波长(nm)
lambda = 1450 : 0.01 : 1650; % 波长范围(nm)
delta_lambda_3dB = 20; % 3dB带宽(nm)
delta_lambda = delta_lambda_3dB / (2 * sqrt(log(2))); % 高斯标准差
V = 1; % 干涉可见度
FSR = 0.8; % 自由光谱范围(nm)
%% 宽带光源光谱(高斯型)
sourceSpectrum = exp(-((lambda - lambda_0) / delta_lambda).^2);
sourceSpectrum = sourceSpectrum / max(sourceSpectrum); % 归一化
%% MZ干涉仪透射谱
mziTransmittance = 0.5 * (1 + V * cos(2 * pi * (lambda - lambda_0) / FSR));
%% 梳状滤波输出
combOutput = sourceSpectrum .* mziTransmittance;
%% 绘图
figure;
% 宽带光源光谱
subplot(3,1,1);
plot(lambda, sourceSpectrum, 'b', 'LineWidth', 0.8);
xlim([1520, 1580]); ylim([0, 1]);grid on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 9);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 9);
ylabel('Magnitude (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 9);
title('Broadband Optical Source Spectrum', 'FontWeight', 'normal');
% MZ干涉仪透射谱
subplot(3,1,2);
plot(lambda, mziTransmittance, 'b', 'LineWidth', 0.8);
xlim([1540, 1560]); ylim([0, 1]);grid on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 9);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 9);
ylabel('Transmittance (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 9);
title('MZI Transmission Spectrum', 'FontWeight', 'normal');
% 梳状滤波输出
subplot(3,1,3);
plot(lambda, combOutput, 'b', 'LineWidth', 0.5);
xlim([1520, 1580]); ylim([0, 1]);grid on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 9);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 9);
ylabel('Magnitude (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 9);
title('Comb Filter Output (Source × MZI)', 'FontWeight', 'normal');
