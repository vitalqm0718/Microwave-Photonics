%% 内反射 Fresnel 公式仿真（玻璃→空气）
clc; clear; close all;
%% 参数设置
n1 = 1.44;        % 入射介质折射率（玻璃）
n2 = 1.00;        % 透射介质折射率（空气）
n = n2 / n1;      % 相对折射率
theta = 0 : 0.01 : 90;       % 入射角 (°)
a = deg2rad(theta);            % 入射角 (rad)
%% Fresnel 公式计算
rs = (cos(a) - sqrt(n.^2 - sin(a).^2)) ./ (cos(a) + sqrt(n.^2 - sin(a).^2));
ts = (2 .* cos(a)) ./ (cos(a) + sqrt(n.^2 - sin(a).^2));
rp = (sqrt(n.^2 - sin(a).^2) - (n.^2) .* cos(a)) ./ ((n.^2) .* cos(a) + sqrt(n.^2 - sin(a).^2));
tp = (2 .* n .* cos(a)) ./ ((n.^2) .* cos(a) + sqrt(n.^2 - sin(a).^2));
bs = -angle(rs); bp = -angle(rp);
cs = -angle(ts); cp = -angle(tp);
angloutrs = rad2deg(bs); angloutrp = rad2deg(bp);
angloutts = rad2deg(cs); anglouttp = rad2deg(cp);
%% 图 1：反射系数幅度
figure;
plot(theta, abs(rp), 'b', theta, abs(rs), 'r--', 'LineWidth', 1.5);
title('Reflection Coefficient Magnitude (Internal)');
xlabel('Incident Angle (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude', 'FontName', 'Times New Roman', 'FontSize', 10);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('|r_p|', '|r_s|', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig1.jpg', '-djpeg', '-r600');
%% 图 2：反射系数相位
figure;
plot(theta, angloutrp, 'b', theta, angloutrs, 'r--', 'LineWidth', 1.5);
title('Reflection Coefficient Phase (Internal)');
xlabel('Incident Angle (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Phase (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('\angle r_p', '\angle r_s', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig2.jpg', '-djpeg', '-r600');
%% 图 3：反射系数
figure;
plot(theta, rp, 'b', theta, rs, 'r--', 'LineWidth', 1.5);
title('Reflection Coefficients (Internal)');
xlabel('Incident Angle (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Coefficient', 'FontName', 'Times New Roman', 'FontSize', 10);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('r_p', 'r_s', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig3.jpg', '-djpeg', '-r600');
%% 图 4：透射系数幅度
figure;
plot(theta, abs(tp), 'b', theta, abs(ts), 'r--', 'LineWidth', 1.5);
title('Transmission Coefficient Magnitude (Internal)');
xlabel('Incident Angle (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Magnitude', 'FontName', 'Times New Roman', 'FontSize', 10);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('|t_p|', '|t_s|', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig4.jpg', '-djpeg', '-r600');
%% 图 5：透射系数相位
figure;
plot(theta, anglouttp, 'b', theta, angloutts, 'r--', 'LineWidth', 1.5);
title('Transmission Coefficient Phase (Internal)');
xlabel('Incident Angle (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Phase (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('\angle t_p', '\angle t_s', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig5.jpg', '-djpeg', '-r600');
%% 图 6：透射系数
figure;
plot(theta, tp, 'b', theta, ts, 'r--', 'LineWidth', 1.5);
title('Transmission Coefficients (Internal)');
xlabel('Incident Angle (deg)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Coefficient', 'FontName', 'Times New Roman', 'FontSize', 10);
grid on; set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10); set(gca, 'LineWidth', 1);
legend('t_p', 't_s', 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
set(gcf, 'Renderer', 'OpenGL');
print(gcf, 'fig6.jpg', '-djpeg', '-r600');
