%% 光纤环形谐振腔滤波响应
function transmission_dB = fiberRingFilterResponse(frequency, couplingRatio, ringLength)
% 输入:
%   frequency     - 光频率 (Hz)，向量
%   couplingRatio - 耦合系数 k，标量，范围 (0, 1)
%   ringLength    - 环形腔长度 (m)，标量
% 输出:
%   transmission_dB - 传输响应 (dB)，与 frequency 等长
%% 物理常数
refractiveIndex = 1.465155; % 光纤有效折射率
speedOfLight    = 299792458; % 真空光速 (m/s)
%% 相位积累
phaseShift = (2 * pi * refractiveIndex * frequency * ringLength) / speedOfLight;
phaseFactor = exp(-1i * phaseShift);
%% 传递函数(环形谐振腔单端口输出)
numerator   = 1 - couplingRatio + (2 * couplingRatio - 1) * phaseFactor;
denominator = 1 - (1 - couplingRatio) * phaseFactor;
transferFunction = numerator ./ denominator;
%% 转换为 dB
transmission_dB = 20 * log10(abs(transferFunction));
end
