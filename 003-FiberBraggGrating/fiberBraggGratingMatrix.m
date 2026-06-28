%% 均匀光纤布拉格光栅 (FBG) 传输矩阵
function transferMatrix = fiberBraggGratingMatrix(wavelength, braggWavelength, ...
    couplingCoefficient, gratingLength, effectiveIndex)
% 基于耦合模理论，计算均匀 FBG 的 2×2 传输矩阵。
%        [ S_out(+) ]   [ s11  s12 ] [ S_in(+) ]
%        [          ] = [          ] [         ]
%        [ S_out(-) ]   [ s21  s22 ] [ S_in(-) ]
% 输入:
%   wavelength         - 当前波长 (m)，标量
%   braggWavelength    - 布拉格波长 (m)，标量，λ_B = 2·n_eff·Λ
%   couplingCoefficient- 交流耦合系数 (1/m)
%   gratingLength      - 光栅长度 (m)
%   effectiveIndex     - 有效折射率，标量
% 输出:
%   transferMatrix     - 2×2 传输矩阵
% 相位失配因子: δ = 2π·n_eff·(1/λ - 1/λ_B)
phaseDetuning = 2 * pi * effectiveIndex * (1 / wavelength - 1 / braggWavelength);
% 有效传播常数: γ = √(κ² - δ²)
if couplingCoefficient^2 >= phaseDetuning^2
    gamma = sqrt(couplingCoefficient^2 - phaseDetuning^2);        % 实数：布拉格反射带内
else
    gamma = 1i * sqrt(phaseDetuning^2 - couplingCoefficient^2);   % 虚数：带外
end
% 传输矩阵元素
s11 = cosh(gamma * gratingLength) - 1i * (phaseDetuning / gamma) * sinh(gamma * gratingLength);
s12 = -1i * (couplingCoefficient / gamma) * sinh(gamma * gratingLength);
s21 =  1i * (couplingCoefficient / gamma) * sinh(gamma * gratingLength);
s22 = cosh(gamma * gratingLength) + 1i * (phaseDetuning / gamma) * sinh(gamma * gratingLength);
transferMatrix = [s11, s12; s21, s22];
end
