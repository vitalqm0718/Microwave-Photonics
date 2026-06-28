%% 双 Sagnac 环微波光子滤波器仿真
clc; clear; close all;
%% 图 1：宽带光源功率谱
[lambda, S_normal, T, Omega, H_Omega_normal] = dual_Sagnac_H(0.0005, 0.5, 0.0005, 1);
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
%% 图 2：双 Sagnac 干涉仪透射谱
figure;
plot(lambda * 1e9, T, 'k', 'LineWidth', 1.5);
title('Dual Sagnac Interferometer Transmission Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1450 1650]); ylim([0.1 0.5]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig2.jpg', '-djpeg', '-r600');
%% 图 3：双 Sagnac 干涉仪梳状滤波
S_T_omega = S_normal .* T;
figure;
hold on;
plot(lambda * 1e9, S_T_omega, 'b', 'LineWidth', 1.5);
plot(lambda * 1e9, S_normal * 0.5, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
hold off;
title('Comb Filtering via Dual Sagnac Interferometer');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (a.u.)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1450 1650]); ylim([0 0.5]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('Comb Output', '0.5 \times Source Spectrum', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig3.jpg', '-djpeg', '-r600');
%% 图 4：双 Sagnac 微波光子滤波器滤波响应
figure;
plot(Omega, H_Omega_normal, 'b', 'LineWidth', 1.5);
title('MWP Filter Response (Dual Sagnac-Based)');
xlabel('Frequency (GHz)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude (dB)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 6]); ylim([-150 0]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig4.jpg', '-djpeg', '-r600');
