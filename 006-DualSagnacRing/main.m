%% 双 Sagnac 环透射谱与反射谱仿真
clc; clear; close all;
%% 全局参数
lambda = 1450 : 0.01 : 1650;  % 波长范围 (nm)
k_1 = 0.5;  theta_1 = pi/2;  B_1 = 0.0005;  l_1 = 1e9;   % Sagnac 环 1
k_2 = 0.5;  theta_2 = pi/2;  B_2 = 0.0005;  l_2 = 2e9;   % Sagnac 环 2
%% 单环透射谱与反射谱
T_1 = (1 - 2*k_1)^2 + 4*k_1*(1 - k_1) * (sin(theta_1))^2 .* (cos(pi * B_1 * l_1 ./ lambda)).^2;
T_2 = (1 - 2*k_2)^2 + 4*k_2*(1 - k_2) * (sin(theta_2))^2 .* (cos(pi * B_2 * l_2 ./ lambda)).^2;
R_1 = 4*k_1*(1 - k_1) * (1 - (sin(theta_1))^2 .* (cos(pi * B_1 * l_1 ./ lambda)).^2);
R_2 = 4*k_2*(1 - k_2) * (1 - (sin(theta_2))^2 .* (cos(pi * B_2 * l_2 ./ lambda)).^2);
%% 双环并联组合
T = 0.25 * T_1 + 0.25 * T_2;  % 双环透射谱
R = 0.25 * R_1 + 0.25 * R_2;  % 双环反射谱
%% 图 1：单 Sagnac 环（l = 1 m）透射谱
figure;
plot(lambda, T_1, 'b', 'LineWidth', 1.5);
title('Single Sagnac Transmission Spectrum (l = 1 m)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig1.jpg', '-djpeg', '-r600');
%% 图 2：单 Sagnac 环（l = 2 m）透射谱
figure;
plot(lambda, T_2, 'r', 'LineWidth', 1.5);
title('Single Sagnac Transmission Spectrum (l = 2 m)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig2.jpg', '-djpeg', '-r600');
%% 图 3：双 Sagnac 环并联透射谱
figure;
plot(lambda, T, 'k', 'LineWidth', 1.5);
title('Dual Sagnac Ring Transmission Spectrum (Vernier Effect)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0.1 0.5]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig3.jpg', '-djpeg', '-r600');
%% 图 4：单 Sagnac 环（l = 1 m）反射谱
figure;
plot(lambda, R_1, 'b', 'LineWidth', 1.5);
title('Single Sagnac Reflection Spectrum (l = 1 m)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig4.jpg', '-djpeg', '-r600');
%% 图 5：单 Sagnac 环（l = 2 m）反射谱
figure;
plot(lambda, R_2, 'r', 'LineWidth', 1.5);
title('Single Sagnac Reflection Spectrum (l = 2 m)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig5.jpg', '-djpeg', '-r600');
%% 图 6：双 Sagnac 环并联反射谱
figure;
plot(lambda, R, 'k', 'LineWidth', 1.5);
title('Dual Sagnac Ring Reflection Spectrum (Vernier Effect)');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 0.4]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig6.jpg', '-djpeg', '-r600');
