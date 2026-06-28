%% 基于 Sagnac 干涉仪的微波光子滤波器响应计算
function [lambda, S_normal, T_omega, Omega, H_Omega_normal] = Sagnac_H(B, l)
% 输入:
%   B - 保偏光纤快慢轴折射率差，标量
%   l - 保偏光纤长度 (m)，标量
% 输出:
%   lambda          - 波长向量 (m)
%   S_normal        - 归一化宽带光源光谱
%   T_omega         - Sagnac 干涉仪透射谱
%   Omega           - 微波频率向量 (GHz)
%   H_Omega_normal  - 归一化微波光子滤波器响应 (dB)
%% 物理常数
P_0 = 1;            % 光源功率 (a.u.)
c = 3e8;            % 真空光速 (m/s)
lambda_0 = 1550e-9; % 中心波长 (m)
omega_0 = 2 * pi * c / lambda_0;  % 中心角频率 (rad/s)
%% 宽带光源光谱（高斯型）
lambda = (1450e-9 : 0.01e-9 : 1650e-9)';
omega = 2 * pi * c ./ lambda;
delta_omega_3dB = 5e13;  % 3 dB 带宽 (rad/s)
delta_omega = delta_omega_3dB / (2 * sqrt(log(2)));  % 高斯标准差
S_omega = (P_0 / (sqrt(pi) * delta_omega)) .* exp(-((omega - omega_0) / delta_omega).^2);
S_normal = (S_omega - min(S_omega)) / (max(S_omega) - min(S_omega));
%% Sagnac 干涉仪透射谱
k = 0.5;        % 耦合比
theta = pi/2;   % 偏转角 (rad)
phi = pi * B * l ./ lambda;  % 相位因子
T_omega = (1 - 2*k)^2 + 4 * k * (1 - k) * (sin(theta))^2 .* (cos(phi)).^2;
%% 微波光子滤波器响应（FFT 法）
n_omega = length(omega);
d_omega_t = 1 / (omega(n_omega) - omega(1));  % 时间分辨率
n_f = (-n_omega/2 : 1 : n_omega/2 - 1)';
ft = n_f * d_omega_t;  % 时间向量 (s)
beta_2 = -27e-27;  % SMF 色散参数 (s^2/m)
L = 0.5808e3;      % SMF 长度 (m)
Omega = (ft * 1e-9) / (2 * pi * beta_2 * L);  % 微波频率 (GHz)
H_Omega = 10 * log10(abs(fftshift(fft(S_omega .* T_omega))));
H_Omega_normal = (H_Omega - min(H_Omega)) / (max(H_Omega) - min(H_Omega)) * 200 - 200;
end
