%% 光纤布拉格光栅 (FBG) 反射谱与透射谱仿真
clc; clear; close all;
%% 全局参数
nEff_default = 1.45; % 有效折射率
lambdaBragg = 1550e-9; % 中心布拉格波长 (m)
L_default = 5e-3; % 默认光栅长度 (m)
kappa_L_default = 2; % 默认 κ·L 值
kappa_default = kappa_L_default / L_default; % 默认耦合系数 (1/m)
%% 图 1：单组参数下的反射谱与透射谱
numWavelength = 500;
lambda = 1e-9 * linspace(1549, 1551, numWavelength)'; % 波长扫描范围
reflectivity = zeros(numWavelength, 1);
transmissivity = zeros(numWavelength, 1);
for i = 1:numWavelength
    T = fiberBraggGratingMatrix(lambda(i), lambdaBragg, kappa_default, L_default, nEff_default);
    r = T(2,1) / T(1,1);                       % 反射系数（电场）
    reflectivity(i) = abs(r)^2;                % 反射率（光强）
    transmissivity(i) = 1 - reflectivity(i);   % 透射率（无损）
end
%% 绘制反射谱
figure;
plot(lambda * 1e9, reflectivity, 'r', 'LineWidth', 1.5);
title('FBG Reflection Spectrum');
xlim([1549.5 1550.5]); ylim([0 1]); grid on;set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);set(gca, 'LineWidth', 1);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
%% 绘制透射谱
figure;
plot(lambda * 1e9, transmissivity, 'b', 'LineWidth', 1.5);
title('FBG Transmission Spectrum');
xlim([1549.5 1550.5]); ylim([0 1]); grid on;set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);set(gca, 'LineWidth', 1);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Transmissivity', 'FontName', 'Times New Roman', 'FontSize', 10);
%% 图 2：不同光栅周期下的反射谱
gratingPeriods = [534.3, 534.5, 534.7] * 1e-9;       % 光栅周期 (m)
braggWavelengths = 2 * nEff_default * gratingPeriods; % 对应布拉格波长
numGratings = length(gratingPeriods);
L2 = 10e-3;  kappa2 = 2 / L2;
numLambda = 1000;
lambda2 = 1e-9 * linspace(1548, 1553, numLambda)';
R_period = zeros(numLambda, numGratings);
for g = 1:numGratings
    for i = 1:numLambda
        T = fiberBraggGratingMatrix(lambda2(i), braggWavelengths(g), kappa2, L2, nEff_default);
        r = T(2,1) / T(1,1);
        R_period(i, g) = abs(r)^2;
    end
end
figure;
hold on;
colorList = lines(numGratings);
lgdCell = cell(1, numGratings);
for g = 1:numGratings
    plot(lambda2 * 1e9, R_period(:, g), 'Color', colorList(g,:), 'LineWidth', 1.5);
    lgdCell{g} = ['\Lambda = ' num2str(gratingPeriods(g) * 1e9, '%.1f') ' nm'];
end
hold off;
title('Reflection Spectrum vs. Grating Period');
xlim([1549 1553]); ylim([0 1]); grid on;set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);set(gca, 'LineWidth', 1);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
%% 图 3：不同耦合系数下的反射谱
kappa_L_vals = [1, 2, 4]; % κ·L 值
kappaVals = kappa_L_vals / L2; % 耦合系数 (1/m)
numKappa = length(kappaVals);
R_kappa = zeros(numLambda, numKappa);
for kIdx = 1:numKappa
    for i = 1:numLambda
        T = fiberBraggGratingMatrix(lambda2(i), lambdaBragg, kappaVals(kIdx), L2, nEff_default);
        r = T(2,1) / T(1,1);
        R_kappa(i, kIdx) = abs(r)^2;
    end
end
figure;
hold on;
for kIdx = 1:numKappa
    plot(lambda2 * 1e9, R_kappa(:, kIdx), 'Color', colorList(kIdx,:), 'LineWidth', 1.5);
    lgdCell{kIdx} = ['\kappa = ' num2str(kappaVals(kIdx) * 1e-3, '%.1f') ' mm^{-1}'];
end
hold off;
title('Reflection Spectrum vs. Coupling Coefficient');
xlim([1549.5 1551]); ylim([0 1]); grid on;set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);set(gca, 'LineWidth', 1);
xlabel('Wavelength (nm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
legend(lgdCell, 'Location', 'best', 'FontName', 'Times New Roman', 'FontSize', 9);
%% 图 4：不同光栅长度下，峰值反射率与耦合系数的关系
% 公式: R_max = tanh²(κ·L)
lengths = [2, 4, 10] * 1e-3; % 光栅长度 (m)
numLen = length(lengths);
numK = 1001;
kappaSweep = linspace(0, 2000, numK); % 耦合系数扫描 (1/m)
Rmax_vs_kappa = zeros(numLen, numK);
for i = 1:numLen
    Rmax_vs_kappa(i, :) = tanh(kappaSweep * lengths(i)).^2;
end
figure;
hold on;
lgdLen = cell(1, numLen);
for i = 1:numLen
    plot(kappaSweep * 1e-3, Rmax_vs_kappa(i, :), 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdLen{i} = ['L = ' num2str(lengths(i) * 1e3) ' mm'];
end
hold off;
title('Peak Reflectivity vs. Coupling Coefficient');
xlim([0 2]); ylim([0 1]); grid on;set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);set(gca, 'LineWidth', 1);
xlabel('Coupling Coefficient (mm^{-1})', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Peak Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
legend(lgdLen, 'Location', 'southeast', 'FontName', 'Times New Roman', 'FontSize', 9);
%% 图 5：不同耦合系数下，峰值反射率与光栅长度的关系
% 公式: R_max = tanh²(κ·L)
kappaConst = [0.1, 0.2, 0.3] * 1e3;                   % 固定耦合系数 (1/m)
numKapFix = length(kappaConst);
numL = 1001;
lengthSweep = linspace(0, 20e-3, numL);                % 光栅长度扫描 (m)
Rmax_vs_length = zeros(numKapFix, numL);
for i = 1:numKapFix
    Rmax_vs_length(i, :) = tanh(kappaConst(i) * lengthSweep).^2;
end
figure;
hold on;
lgdKap = cell(1, numKapFix);
for i = 1:numKapFix
    plot(lengthSweep * 1e3, Rmax_vs_length(i, :), 'Color', colorList(i,:), 'LineWidth', 1.5);
    lgdKap{i} = ['\kappa = ' num2str(kappaConst(i) * 1e-3, '%.1f') ' mm^{-1}'];
end
hold off;
title('Peak Reflectivity vs. Grating Length');
xlim([0 20]); ylim([0 1]); grid on;set(gca, 'box', 'on');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);set(gca, 'LineWidth', 1);
xlabel('Grating Length (mm)', 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('Peak Reflectivity', 'FontName', 'Times New Roman', 'FontSize', 10);
legend(lgdKap, 'Location', 'southeast', 'FontName', 'Times New Roman', 'FontSize', 9);
