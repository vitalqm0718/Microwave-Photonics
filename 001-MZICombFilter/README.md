# MZI 梳状滤波器 / MZI-Based Comb Filter

## 1. 原理概述 / Principle

马赫-曾德尔干涉仪 (Mach-Zehnder Interferometer, MZI) 可以将宽带光源滤波为梳状谱，在微波光子学中广泛应用于光载波生成、波长选择等场景。

A Mach-Zehnder Interferometer (MZI) can filter a broadband optical source into a comb spectrum. It is widely used in microwave photonics for optical carrier generation and wavelength selection.

### 核心公式 / Core Equations

**宽带光源光谱 (高斯型) / Broadband Source Spectrum (Gaussian):**

$$
S(\lambda) = \exp\left[-\left(\frac{\lambda - \lambda_0}{\delta\lambda}\right)^2\right]
$$

其中 $\delta\lambda = \frac{\Delta\lambda_{3\text{dB}}}{2\sqrt{\ln 2}}$，$\Delta\lambda_{3\text{dB}}$ 为 3 dB 带宽。

where $\delta\lambda = \frac{\Delta\lambda_{3\text{dB}}}{2\sqrt{\ln 2}}$, and $\Delta\lambda_{3\text{dB}}$ is the 3 dB bandwidth.

**MZI 透射谱 / MZI Transmission Spectrum:**

$$
T(\lambda) = \frac{1}{2}\left[1 + V \cdot \cos\left(2\pi \cdot \frac{\lambda - \lambda_0}{\text{FSR}}\right)\right]
$$

其中 $V$ 为干涉可见度，$\text{FSR}$ 为自由光谱范围。

where $V$ is the interference visibility and $\text{FSR}$ is the free spectral range.

**梳状滤波输出 / Comb Filter Output:**

$$
O(\lambda) = S(\lambda) \times T(\lambda)
$$

---

## 2. 仿真结果 / Simulation Results

> 上图：宽带高斯光源光谱 | 中图：MZI 干涉仪透射谱 | 下图：梳状滤波输出
>
> Top: Broadband Gaussian source spectrum | Middle: MZI transmission spectrum | Bottom: Comb filter output

<img width="3500" height="2625" alt="fig1" src="https://github.com/user-attachments/assets/4ce6c13c-38e2-4d07-80e7-4f1a9cc9b42c" />

---

*更多算法请返回 [MicrowavePhotonics 主页](../README.md).*
