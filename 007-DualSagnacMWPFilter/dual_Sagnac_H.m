%% 双 Sagnac 环微波光子滤波器响应计算
function [lambda, S_normal, T, Omega, H_Omega_normal] = dual_Sagnac_H(B_1, l_1, B_2, l_2)
% 输入:
%   B_1 - 环 1 保偏光纤快慢轴折射率差，标量
%   l_1 - 环 1 保偏光纤长度 (m)，标量
%   B_2 - 环 2 保偏光纤快慢轴折射率差，标量
%   l_2 - 环 2 保偏光纤长度 (m)，标量
% 输出:
%   lambda          - 波长向量 (m)
%   S_normal        - 归一化宽带光源光谱
%   T               - 双 Sagnac 干涉仪透射谱
%   Omega           - 微波频率向量 (GHz)
%   H_Omega_normal  - 归一化微波光子滤波器响应 (dB)
%% 物理常数
P_0 = 1;            % 光源功率 (a.u.)
c = 3e8;            % 真空光速 (m/s)
lambda_0 = 1550e-9; % 中心波长 (m)
omega_0 = 2 * pi * c / lambda_0;  % 中心角频率 (rad/s)
delta_omega_3dB = 5e13;  % 3 dB 带宽 (rad/s)
delta_omega = delta_omega_3dB / (2 * sqrt(log(2)));  % 高斯标准差
%% Sagnac 环参数
k_1 = 0.5;  theta_1 = pi/2;  % 环 1 耦合比、偏转角
k_2 = 0.5;  theta_2 = pi/2;  % 环 2 耦合比、偏转角
%% 宽带光源光谱（高斯型）
lambda = (1450e-9 : 0.01e-9 : 1650e-9)';
omega = 2 * pi * c ./ lambda;
S_omega = (P_0 / (sqrt(pi) * delta_omega)) .* exp(-((omega - omega_0) / delta_omega).^2);
S_normal = (S_omega - min(S_omega)) / (max(S_omega) - min(S_omega));
%% 双 Sagnac 干涉仪透射谱
T_1 = (1 - 2*k_1)^2 + 4 * k_1 * (1 - k_1) * (sin(theta_1))^2 .* (cos(pi * B_1 * l_1 ./ lambda)).^2;
T_2 = (1 - 2*k_2)^2 + 4 * k_2 * (1 - k_2) * (sin(theta_2))^2 .* (cos(pi * B_2 * l_2 ./ lambda)).^2;
T = 0.25 * T_1 + 0.25 * T_2;  % 双环并联透射谱
%% 微波光子滤波器响应（FFT 法）
n_omega = length(omega);
d_omega_t = 1 / (omega(n_omega) - omega(1));
n_f = (-n_omega/2 : 1 : n_omega/2 - 1)';
ft = n_f * d_omega_t;
beta_2 = -27e-27;  % SMF 色散参数 (s^2/m)
L = 0.5808e3;      % SMF 长度 (m)
Omega = (ft * 1e-9) / (2 * pi * beta_2 * L);  % 微波频率 (GHz)
H_Omega = 10 * log10(abs(fftshift(fft(S_omega .* T))));
H_Omega_normal = (H_Omega - min(H_Omega)) / (max(H_Omega) - min(H_Omega)) * 200 - 200;
end
