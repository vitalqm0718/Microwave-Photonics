# MZI 梳状滤波器 (MZI-Based Comb Filter)

## 1. 原理概述 / Principle

马赫-曾德尔干涉仪 (Mach-Zehnder Interferometer, MZI) 可以将宽带光源滤波为梳状谱，在微波光子学中广泛应用于光载波生成、波长选择等场景。

A Mach-Zehnder Interferometer (MZI) can filter a broadband optical source into a comb spectrum, widely used in microwave photonics for carrier generation, wavelength selection, etc.

### 核心公式 / Core Equations

**宽带光源光谱 (高斯型)：**

$$
S(\lambda) = \exp\left[-\left(\frac{\lambda - \lambda_0}{\delta\lambda}\right)^2\right]
$$

其中 $\delta\lambda = \frac{\Delta\lambda_{3\text{dB}}}{2\sqrt{\ln 2}}$ 为高斯标准差。

**MZI 透射谱：**

$$
T(\lambda) = \frac{1}{2}\left[1 + V \cdot \cos\left(2\pi \cdot \frac{\lambda - \lambda_0}{\text{FSR}}\right)\right]
$$

其中 $V$ 为干涉可见度，$\text{FSR}$ 为自由光谱范围 (Free Spectral Range)。

**梳状滤波输出：**

$$
O(\lambda) = S(\lambda) \times T(\lambda)
$$

---

## 2. 关键参数 / Key Parameters

| 参数 | 符号 | 值 | 说明 |
|------|------|-----|------|
| 中心波长 | $\lambda_0$ | 1550 nm | C-band 典型值 |
| 3 dB 带宽 | $\Delta\lambda_{3\text{dB}}$ | 20 nm | 光源半高全宽 |
| 干涉可见度 | $V$ | 1 | 理想干涉情况 |
| 自由光谱范围 | $\text{FSR}$ | 0.8 nm | 梳状谱频率间隔 |

---

## 3. 仿真结果 / Results
<img width="3500" height="2625" alt="fig1" src="https://github.com/user-attachments/assets/4ce6c13c-38e2-4d07-80e7-4f1a9cc9b42c" />



