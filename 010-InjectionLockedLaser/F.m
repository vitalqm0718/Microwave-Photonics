 %% 光注入半导体激光器速率方程（归一化模型）
 function [f1, P1, t, y2, f3, P3, n_, y4] = F(input1, input2, input3)
 % 输入:
 %   input1 - 失谐频率 f_i (Hz)，标量
 %   input2 - 光注入强度 xi，标量
 %   input3 - 初值 [a_r0; a_i0; n_0]，3x1 向量
 % 输出:
 %   f1 - 光谱频率轴 (Hz)
 %   P1 - 光谱功率 (dB)
 %   t  - 时间向量 (s)
 %   y2 - 时序强度 |a|^2 (a.u.)
 %   f3 - 电谱频率轴 (Hz)
 %   P3 - 电谱功率 (dB)
 %   n_ - 归一化载流子密度偏差
 %   y4 - 场振幅 |a| (a.u.)
 %% 速率方程（归一化光注入半导体激光器模型）
 function dy = rate_eq(t, y)
 gamma_c = 5.36e11;   % 腔体衰变速率
 gamma_s = 5.96e9;    % 自发辐射速率
 gamma_n = 7.53e9;    % 差分载流子弛豫速率
 gamma_p = 1.91e10;   % 非线性载流子弛豫速率
 b = 3.2;             % 线宽增强因子
 J_ = 1.222;          % 归一化偏置电流
 f_i = input1;        % 失谐频率 (Hz)
 xi = input2;         % 光注入强度
 dy = [0.5*(y(1)+b*y(2))*((gamma_n*gamma_c*y(3))/(gamma_s*J_)-gamma_p*(y(1)^2+y(2)^2-1)) + xi*gamma_c*cos(2*pi*f_i*t);
       0.5*(-b*y(1)+y(2))*((gamma_n*gamma_c*y(3))/(gamma_s*J_)-gamma_p*(y(1)^2+y(2)^2-1)) - xi*gamma_c*sin(2*pi*f_i*t);
       -y(3)*(gamma_s+gamma_n*(y(1)^2+y(2)^2)) - gamma_s*J_*(y(1)^2+y(2)^2-1) + (gamma_s*gamma_p*J_*(y(1)^2+y(2)^2-1)*(y(1)^2+y(2)^2))/gamma_c];
 end
 %% ODE 求解
 tspan = 0 : 0.25e-12 : 0.1e-6;
 y0 = input3;
 [t, y] = ode45(@rate_eq, tspan, y0);
 a_r = y(:, 1);
 a_i = y(:, 2);
 n_ = y(:, 3);
 a = a_r + 1i * a_i;
 %% 光谱计算
 fs = 1 / (0.25e-12);
 Fs = fs;
 N = length(a);
 Y1 = fft(a);
 Y2 = fftshift(Y1);
 B1 = 10 * log10(abs(Y2));
 f1 = (-N/2 : 1 : N/2 - 1) * Fs / N;
 P1 = 10 * log10(B1.^2);
 %% 时序
 y2 = abs(a).^2;
 %% 电谱计算
 Y3 = fft(y2);
 Y4 = fftshift(Y3);
 B3 = 10 * log10(abs(Y4));
 f3 = (-N/2 : 1 : N/2 - 1) * Fs / N;
 P3 = 10 * log10(B3.^2);
 %% 相图
 y4 = abs(a);
 end
