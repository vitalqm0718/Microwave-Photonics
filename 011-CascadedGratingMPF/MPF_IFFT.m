%% 基于级联弱光纤布拉格光栅（WFBG）的 MPF 时频响应计算
function [f, H_omega, t, h] = MPF_IFFT(N, a_k, L)
% 输入:
%   N   - 光栅抽头数，标量
%   a_k - 各抽头幅度，N 维向量
%   L   - 各抽头位置 (m)，N 维向量
% 输出:
%   f       - 频率轴 (Hz)
%   H_omega - 频率响应
%   t       - 时间轴
%   h       - 时域响应（IFFT）
%% 物理常数
n = 1.4502;  % 光纤有效折射率
c = 3e8;     % 真空光速 (m/s)
%% 时延计算
tao_k = 2 * n * L / c;  % 各抽头往返时延 (s)
%% 频率响应
f = 0 : 1e4 : 10e9;  % 频率扫描范围 (Hz)
omega = 2 * pi * f;
H_omega = zeros(N, length(omega));
for k = 1:N
    H_omega(k, :) = a_k(k) .* exp(-1i .* omega .* tao_k(k));
end
H_omega = sum(H_omega, 1);
%% 时域响应（IFFT）
h = ifft(H_omega);
df = f(2) - f(1);
t = 0 : 1/df : (length(f) - 1) / df;
end
