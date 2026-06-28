%% 基于 Sagnac 干涉仪的微波光子滤波器仿真
clc; clear; close all;
%% 图 1：宽带光源功率谱
[lambda, S_normal, T_omega, Omega, H_Omega_normal] = Sagnac_H(0.0005, 0.5);
figure;
plot(lambda * 1e9, S_normal, 'b', 'LineWidth', 1.5);
title('Broadband Source Power Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1450 1650]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig1.jpg', '-djpeg', '-r600');
%% 图 2：Sagnac 干涉仪透射谱
figure;
plot(lambda * 1e9, T_omega, 'b', 'LineWidth', 1.5);
title('Sagnac Interferometer Transmission Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1450 1650]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig2.jpg', '-djpeg', '-r600');
%% 图 3：Sagnac 干涉仪梳状滤波
S_T_omega = S_normal .* T_omega;
figure;
hold on;
plot(lambda * 1e9, S_T_omega, 'b', 'LineWidth', 1.5);
plot(lambda * 1e9, S_normal, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
hold off;
title('Comb Filtering via Sagnac Interferometer');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1450 1650]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('Comb Output', 'Source Spectrum', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig3.jpg', '-djpeg', '-r600');
%% 图 4：微波光子滤波器滤波响应
figure;
plot(Omega, H_Omega_normal, 'b', 'LineWidth', 1.5);
title('MWP Filter Response (Sagnac-Based)');
xlabel('Frequency (GHz)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (dB)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 3]); ylim([-140 0]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig4.jpg', '-djpeg', '-r600');
%% 图 5：不同保偏光纤长度下的滤波响应
lVec = [0.5, 1.0, 1.5, 2.0, 2.5];
nL = length(lVec);
figure;
hold on;
colorList = lines(nL);
lgdCell = cell(1, nL);
for i = 1:nL
    [~, ~, ~, Omega, H] = Sagnac_H(0.0005, lVec(i));
    plot(Omega, H, 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdCell{i} = ['l = ' num2str(lVec(i), '%.1f') ' m'];
end
hold off;
title('Filter Response vs. PMF Length');
xlabel('Frequency (GHz)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (dB)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 10]); ylim([-160 0]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig5.jpg', '-djpeg', '-r600');
%% 图 6：不同快慢轴折射率差下的滤波响应
BVec = [0.00025, 0.0005, 0.00075, 0.001, 0.00125];
nB = length(BVec);
figure;
hold on;
colorList = lines(nB);
lgdCell = cell(1, nB);
for i = 1:nB
    [~, ~, ~, Omega, H] = Sagnac_H(BVec(i), 1);
    plot(Omega, H, 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdCell{i} = ['B = ' num2str(BVec(i), '%.5f')];
end
hold off;
title('Filter Response vs. Birefringence');
xlabel('Frequency (GHz)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (dB)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 10]); ylim([-160 0]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig6.jpg', '-djpeg', '-r600');
%% 图 7：保偏光纤长度与通带中心频率的关系
beta_2 = 25e-27;  % 色散参数 (s^2/m)
L_SMF = 25e3;     % 单模光纤长度 (m)
c = 3e8;          % 真空光速 (m/s)
l = (0 : 0.0001 : 2)';  % 保偏光纤长度 (m)
B = 0.001;        % 快慢轴折射率差
Omega_0 = B * l / (beta_2 * L_SMF * c) * 1e-9;
figure;
plot(l, Omega_0, 'b', 'LineWidth', 1.5);
title('Passband Center Frequency vs. PMF Length (B = 0.001)');
xlabel('PMF Length (m)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Center Frequency (GHz)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 2]); ylim([0 11]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig7.jpg', '-djpeg', '-r600');
%% 图 8：快慢轴折射率差与通带中心频率的关系
l = 1;            % 保偏光纤长度 (m)
B_scan = (0 : 0.0000001 : 0.002)';  % 折射率差扫描
Omega_0 = B_scan * l / (beta_2 * L_SMF * c) * 1e-9;
figure;
plot(B_scan, Omega_0, 'b', 'LineWidth', 1.5);
title('Passband Center Frequency vs. Birefringence (l = 1 m)');
xlabel('Birefringence', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Center Frequency (GHz)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 0.002]); ylim([0 11]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig8.jpg', '-djpeg', '-r600');
