%% 单 Sagnac 环透射谱与反射谱仿真
clc; clear; close all;
%% 全局参数
lambda = 1450 : 0.01 : 1650;  % 波长范围 (nm)
B_default = 0.0005;  % 默认快慢轴折射率差
k_default = 0.5;     % 默认耦合比
l_default = 1e9;     % 默认保偏光纤长度 (nm)
theta_default = pi/2; % 默认偏转角 (rad)
%% 透射谱匿名函数
Transmission = @(k, B, l, theta) (1 - 2*k).^2 + 4*k.*(1 - k).* (sin(theta)).^2 .* (cos(pi * B * l ./ lambda)).^2;
%% 图 1：透射谱
T = Transmission(k_default, B_default, l_default, theta_default);
figure;
plot(lambda, T, 'b', 'LineWidth', 1.5);
title('Sagnac Ring Transmission Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig1.jpg', '-djpeg', '-r600');
%% 图 2：反射谱
R = 4 * k_default * (1 - k_default) * (1 - (sin(theta_default))^2 .* (cos(pi * B_default * l_default ./ lambda)).^2);
figure;
plot(lambda, R, 'r', 'LineWidth', 1.5);
title('Sagnac Ring Reflection Spectrum');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig2.jpg', '-djpeg', '-r600');
%% 图 3：不同耦合比下的透射谱
kVec = [0.1, 0.3, 0.5, 0.7, 0.9];
lineStyles = {'-', '-', '-', '--', '--'};
nK = length(kVec);
figure;
hold on;
colorList = lines(nK);
lgdCell = cell(1, nK);
for i = 1:nK
    T_i = Transmission(kVec(i), B_default, l_default, theta_default);
    plot(lambda, T_i, 'Color', colorList(i,:), 'LineWidth', 1.5, 'LineStyle', lineStyles{i});
    lgdCell{i} = ['k = ' num2str(kVec(i), '%.1f')];
end
hold off;
title('Transmission Spectrum vs. Coupling Ratio');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig3.jpg', '-djpeg', '-r600');
%% 图 4：耦合比与抑制比的关系
kRR = (0 : 0.01 : 1)';
RR_k = zeros(length(kRR), 1);
for i = 1:length(kRR)
    T = Transmission(kRR(i), B_default, l_default, theta_default);
    RR_k(i) = max(T) - min(T);
end
figure;
plot(kRR, RR_k, 'b', 'LineWidth', 1.5);
title('Rejection Ratio vs. Coupling Ratio');
xlabel('Coupling Ratio', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Rejection Ratio', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 1]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig4.jpg', '-djpeg', '-r600');
%% 图 5：不同光纤长度下的透射谱
lVec = [0.5, 1.0, 1.5] * 1e9;  % 保偏光纤长度 (nm)
nL = length(lVec);
figure;
hold on;
colorList = lines(nL);
lgdCell = cell(1, nL);
for i = 1:nL
    T_i = Transmission(k_default, B_default, lVec(i), theta_default);
    plot(lambda, T_i, 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdCell{i} = ['L = ' num2str(lVec(i) * 1e-9, '%.1f') ' m'];
end
hold off;
title('Transmission Spectrum vs. Fiber Length');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig5.jpg', '-djpeg', '-r600');
%% 图 6：光纤长度与透射谱周期的关系
lambda_0 = 1550;  % 中心波长 (nm)
l_scan = (0 : 0.01 : 2)';  % 保偏光纤长度 (m)
delta_lambda = (lambda_0^2) ./ (B_default * l_scan * 1e9);
figure;
plot(l_scan, delta_lambda, 'b', 'LineWidth', 1.5);
title('Transmission Period vs. Fiber Length');
xlabel('Fiber Length (m)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmission Period (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 2]); ylim([0 50]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig6.jpg', '-djpeg', '-r600');
%% 图 7：不同快慢轴折射率差下的透射谱
BVec = [0.00025, 0.0005, 0.00075];
nB = length(BVec);
figure;
hold on;
colorList = lines(nB);
lgdCell = cell(1, nB);
for i = 1:nB
    T_i = Transmission(k_default, BVec(i), l_default, theta_default);
    plot(lambda, T_i, 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdCell{i} = ['B = ' num2str(BVec(i), '%.5f')];
end
hold off;
title('Transmission Spectrum vs. Birefringence');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig7.jpg', '-djpeg', '-r600');
%% 图 8：快慢轴折射率差与透射谱周期的关系
lambda_0 = 1550;  % 中心波长 (nm)
l_const = 1;  % 保偏光纤长度 (m)
B_scan = (0 : 0.00001 : 0.001)';  % 折射率差扫描
delta_lambda = (lambda_0^2) ./ (B_scan * l_const * 1e9);
figure;
plot(B_scan, delta_lambda, 'b', 'LineWidth', 1.5);
title('Transmission Period vs. Birefringence');
xlabel('Birefringence', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmission Period (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 0.001]); ylim([0 50]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig8.jpg', '-djpeg', '-r600');
%% 图 9：不同偏转角下的透射谱
thetaVec = [pi/6, pi/4, pi/3, pi/2];  % 30°, 45°, 60°, 90°
nTheta = length(thetaVec);
figure;
hold on;
colorList = lines(nTheta);
lgdCell = cell(1, nTheta);
for i = 1:nTheta
    T_i = Transmission(k_default, B_default, l_default, thetaVec(i));
    plot(lambda, T_i, 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdCell{i} = ['\theta = ' num2str(thetaVec(i) * 180/pi, '%.0f') '\circ'];
end
hold off;
title('Transmission Spectrum vs. Rotation Angle');
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmittance', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([1540 1560]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig9.jpg', '-djpeg', '-r600');
%% 图 10：偏转角与抑制比的关系
theta_scan = (0 : pi/180 : pi)';  % 偏转角扫描 (0 ~ 180°)
RR_theta = zeros(length(theta_scan), 1);
for i = 1:length(theta_scan)
    T = Transmission(k_default, B_default, l_default, theta_scan(i));
    RR_theta(i) = max(T) - min(T);
end
figure;
plot(theta_scan, RR_theta, 'b', 'LineWidth', 1.5);
title('Rejection Ratio vs. Rotation Angle');
xlabel('Rotation Angle (rad)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Rejection Ratio', 'FontName', 'Times New Roman', 'FontSize', 10);
xlim([0 pi]); ylim([0 1]);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig10.jpg', '-djpeg', '-r600');





