%% 基于 MZI 的光纤激光器仿真
clc; clear; close all;
%% 固定参数
n = 1.45;
% 光纤的折射率
delta_n = 1e-6;
% 光纤的双折射系数
n_x = n + delta_n / 2;
% x 方向的折射率
n_y = n - delta_n / 2;
% y 方向的折射率
lambda = linspace(1540e-9, 1560e-9, 10001);
% 波长范围 1540-1560 nm，10001 个点
theta = 0.25 * pi;
% 固定的相位角度
%% 可调参数
alpha = [0.5, 0.65, 1.35, 1.5] * pi;
% 角度参数
delta_lambda = [0.4e-9, 0.8e-9, 3e-9, 1e-9, 0.6e-9, 0.2e-9];
% 透射谱周期
%% MZI 透射谱计算
delta_L = lambda.^2 ./ (n * delta_lambda(2));
% 臂长差
phi_x = 2 * pi * n_x .* delta_L ./ lambda;
% x 方向相位
phi_y = 2 * pi * n_y .* delta_L ./ lambda;
% y 方向相位
Transmission_Spectrum = 0.5 * (1 - cos(alpha(1) + theta) .* cos(theta) .* cos(phi_x) - sin(alpha(1) + theta) .* sin(theta) .* cos(phi_y));
% 干涉后的透射谱
Transmission_Spectrum = (Transmission_Spectrum - min(Transmission_Spectrum)) ./ (max(Transmission_Spectrum) - min(Transmission_Spectrum));
% 归一化
%% 图 1：MZI 透射谱
figure;
plot(lambda * 1e9, Transmission_Spectrum, 'b', 'LineWidth', 0.5);
title('MZI Transmission Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Normalized Transmission (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540, 1560]); ylim([0, 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig1.jpg', '-djpeg', '-r600');
%% 图 2：不同 alpha 下的 MZI 透射谱（周期 0.8 nm）
figure;
colorList = lines(4);
for i = 1:length(alpha)
    delta_L = lambda.^2 ./ (n * delta_lambda(2));
    phi_x = 2 * pi * n_x .* delta_L ./ lambda;
    phi_y = 2 * pi * n_y .* delta_L ./ lambda;
    Transmission_Spectrum1 = 0.5 * (1 - cos(alpha(i) + theta) .* cos(theta) .* cos(phi_x) - sin(alpha(i) + theta) .* sin(theta) .* cos(phi_y));
    Transmission_Spectrum1 = (Transmission_Spectrum1 - min(Transmission_Spectrum1)) ./ (max(Transmission_Spectrum1) - min(Transmission_Spectrum1));
    plot(lambda * 1e9, Transmission_Spectrum1, 'Color', colorList(i, :), 'LineWidth', 0.5);
    hold on;
end
hold off;
title('MZI Transmission Spectrum with \Delta\lambda = 0.8 nm');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Normalized Transmission (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1549, 1551]); ylim([0, 1]);
legend('\alpha = 0.5\pi', '\alpha = 0.65\pi', '\alpha = 1.35\pi', '\alpha = 1.5\pi', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig2.jpg', '-djpeg', '-r600');
%% 图 3：不同 alpha 下的 MZI 透射谱（周期 0.4 nm）
figure;
colorList = lines(4);
for i = 1:length(alpha)
    delta_L = lambda.^2 ./ (n * delta_lambda(1));
    phi_x = 2 * pi * n_x .* delta_L ./ lambda;
    phi_y = 2 * pi * n_y .* delta_L ./ lambda;
    Transmission_Spectrum2 = 0.5 * (1 - cos(alpha(i) + theta) .* cos(theta) .* cos(phi_x) - sin(alpha(i) + theta) .* sin(theta) .* cos(phi_y));
    Transmission_Spectrum2 = (Transmission_Spectrum2 - min(Transmission_Spectrum2)) ./ (max(Transmission_Spectrum2) - min(Transmission_Spectrum2));
    plot(lambda * 1e9, Transmission_Spectrum2, 'Color', colorList(i, :), 'LineWidth', 0.5);
    hold on;
end
hold off;
title('MZI Transmission Spectrum with \Delta\lambda = 0.4 nm');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Normalized Transmission (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1549, 1551]); ylim([0, 1]);
legend('\alpha = 0.5\pi', '\alpha = 0.65\pi', '\alpha = 1.35\pi', '\alpha = 1.5\pi', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig3.jpg', '-djpeg', '-r600');
%% 图 4：不同周期下的 MZI 透射谱对比
figure;
for i = 1:(length(delta_lambda) - 2)
    delta_L = lambda.^2 ./ (n * delta_lambda(i + 2));
    phi_x = 2 * pi * n_x .* delta_L ./ lambda;
    phi_y = 2 * pi * n_y .* delta_L ./ lambda;
    Transmission_Spectrum3 = 0.5 * (1 - cos(alpha(1) + theta) .* cos(theta) .* cos(phi_x) - sin(alpha(1) + theta) .* sin(theta) .* cos(phi_y));
    Transmission_Spectrum3 = (Transmission_Spectrum3 - min(Transmission_Spectrum3)) ./ (max(Transmission_Spectrum3) - min(Transmission_Spectrum3));
    subplot(4, 1, i);
    plot(lambda * 1e9, Transmission_Spectrum3, 'b', 'LineWidth', 0.5);
    title(['$\Delta\lambda = ', num2str(delta_lambda(i + 2) * 1e9), ' \ \mathrm{nm}$'], 'Interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 10);
    xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
    ylabel('Normalized Transmission', 'FontName', 'Times New Roman', 'FontSize', 10);
    xlim([1555, 1560]); ylim([0, 1]);
    grid on; set(gca, 'box', 'on');
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
end
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig4.jpg', '-djpeg', '-r600');
%% 宽谱光源（泵浦 EDF 产生的 ASE 光谱）
Power = 0.68e-7;
% 功率（W）
Center_Wavelength = 1550e-9;
% 中心波长（m）
Bandwidth = 8e-9;
% 带宽（m）
Power_Spectrum = Power .* exp(-((lambda - Center_Wavelength).^2) / (2 * Bandwidth^2));
% 高斯型宽谱光源功率谱
Power_Spectrum_dBm = 10 * log10(Power_Spectrum * 1e3);
% 转换为 dBm 单位
%% 图 5：宽谱光源光谱（W）
figure;
plot(lambda * 1e9, Power_Spectrum, 'b', 'LineWidth', 0.5);
title('ASE Broadband Spectrum (W)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Power (W)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540, 1560]); ylim([min(Power_Spectrum), Power]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig5.jpg', '-djpeg', '-r600');
%% 图 6：宽谱光源光谱（dBm）
figure;
plot(lambda * 1e9, Power_Spectrum_dBm, 'b', 'LineWidth', 0.5);
title('ASE Broadband Spectrum (dBm)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Power (dBm)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540, 1560]); ylim([-65, -35]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig6.jpg', '-djpeg', '-r600');
%% 激光腔增益循环
Output = zeros(1, length(lambda));
% 初始化输出光谱
Number_of_cycles = 50;
% 增益循环次数
for roundtrip = 1:Number_of_cycles
    pass = sprintf('Roundtrip = %d', roundtrip);
    disp(pass);
    % 宽谱光源经 MZI 梳状滤波
    Comb_Filter_Spectrum = Power_Spectrum .* Transmission_Spectrum;
    % 累计输出 10% 功率
    Output = Output + Comb_Filter_Spectrum .* 0.1;
    % 剩余 90% 继续进入激光腔
    Residual = Comb_Filter_Spectrum .* 0.9;
    gamma = 0.3;
    % 增益系数
    L_EDF = 2;
    % EDF 长度（m）
    G = gamma * L_EDF * 0.3;
    % 增益（dB）
    Residual = Residual .* 10.^(G ./ 10);
    % 放大残余光
    Power_Spectrum = Residual;
    % 放大后的光替代宽谱光源
end
%% 图 7：梳状滤波光谱
Comb_Filter_Spectrum_dBm = 10 * log10(Output * 1e3);
figure;
plot(lambda * 1e9, Comb_Filter_Spectrum_dBm, 'b', 'LineWidth', 0.5);
title('Comb Filter Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Power (dBm)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540, 1560]); ylim([-65, -35]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig7.jpg', '-djpeg', '-r600');
%% 图 8：激光器最终输出光谱
Output_dBm = 10 * log10(Output * 1e3);
figure;
plot(lambda * 1e9, Output_dBm, 'b', 'LineWidth', 0.5);
title('Laser Output Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Power (dBm)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540, 1560]); ylim([-65, -35]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig8.jpg', '-djpeg', '-r600');
disp('仿真完成');
