# 光纤环形谐振腔 / Fiber Ring Resonator

## 1. 原理概述 / Principle

光纤环形谐振腔由一个定向耦合器和一段光纤环组成。光信号通过耦合器进入环形腔后循环传输，多圈干涉形成周期性滤波响应，广泛应用于微波光子学中的滤波器、传感器和延时线等场景。

A fiber ring resonator consists of a directional coupler and a fiber loop. The optical signal circulates inside the ring and interferes after multiple round-trips, producing a periodic filter response. It is widely used in microwave photonics for filters, sensors, and delay lines.

### 核心公式 / Core Equations

**环形谐振腔传输函数 / Ring Resonator Transfer Function:**

$$
H(f) = \frac{1 - k + (2k - 1) \cdot e^{-j\phi(f)}}{1 - (1 - k) \cdot e^{-j\phi(f)}}
$$

其中 $k$ 为耦合比, $\phi(f) = \dfrac{2\pi n L}{c} f$ 为单圈相移。

where $k$ is the coupling ratio, and $\phi(f) = \dfrac{2\pi n L}{c} f$ is the single-round-trip phase shift.

**传输响应 (dB) / Transmission Response (dB):**

$$
T(f) = 20 \cdot \log_{10}\big|H(f)\big|
$$

**自由光谱范围 / Free Spectral Range (FSR):**

$$
\text{FSR} = \frac{c}{nL}
$$

**抑制比 / Rejection Ratio:**

$$
\text{RR} = \max\big(T(f)\big) - \min\big(T(f)\big) \quad (\text{dB})
$$

---

## 2. 关键参数 / Key Parameters

| 参数 / Parameter | 符号 / Symbol | 典型值 / Value | 说明 / Description |
|------|------|------|------|
| 光纤有效折射率 | $n$ | 1.465155 | Effective refractive index of fiber |
| 真空光速 | $c$ | 2.99792458×10⁸ m/s | Speed of light in vacuum |
| 耦合比 | $k$ | 0.1 ~ 0.9 | Coupling ratio (power splitting ratio) |
| 环形腔长度 | $L$ | 30 ~ 80 m | Ring cavity length |

---

## 3. 仿真结果 / Simulation Results

> 所有仿真基于光纤有效折射率 n = 1.465155，真空光速 c = 299792458 m/s。
>
> All simulations use n = 1.465155 and c = 299792458 m/s.

### 3.1 单组参数下的滤波响应 / Single-Parameter Filter Response

> k = 0.7, L = 50 m

<img width="3500" height="2625" alt="fig1" src="https://github.com/user-attachments/assets/14277b0b-f0ba-4c06-9503-b19152c98a99" />

### 3.2 不同耦合比下的滤波响应 / Filter Response vs. Coupling Ratio

> L = 50 m, k = 0.1 : 0.1 : 0.9

<img width="3500" height="2625" alt="fig2" src="https://github.com/user-attachments/assets/38ee679b-59c6-48ce-bcab-639988fddf3a" />

### 3.3 不同腔长下的滤波响应 / Filter Response vs. Fiber Length

> k = 0.7, L = 30 : 10 : 80 m

<img width="3500" height="2625" alt="fig3" src="https://github.com/user-attachments/assets/ba5e0692-0cf9-4f9c-b404-2b29b06e87f3" />

### 3.4 耦合比与抑制比的关系 / Rejection Ratio vs. Coupling Ratio

> L = 50 m, k = 0 : 0.01 : 1

<img width="3500" height="2625" alt="fig4" src="https://github.com/user-attachments/assets/5fe9988e-5fe5-437c-bc7d-6e155339e013" />

### 3.5 耦合比与 3 dB 带宽的关系 / 3 dB Bandwidth vs. Coupling Ratio

> L = 50 m, k = 0.26 : 0.01 : 0.92

<img width="3500" height="2625" alt="fig5" src="https://github.com/user-attachments/assets/1c7eaf43-04a4-405c-8f6a-9d9f666dc740" />

### 3.6 光纤长度与抑制比的关系 / Rejection Ratio vs. Fiber Length

> k = 0.7, L = 30 : 0.5 : 80 m

<img width="3500" height="2625" alt="fig6" src="https://github.com/user-attachments/assets/ef378860-a934-4e06-937b-d46ef6451ac9" />

### 3.7 光纤长度与 3 dB 带宽的关系 / 3 dB Bandwidth vs. Fiber Length

> k = 0.7, L = 30 : 0.5 : 80 m

<img width="3500" height="2625" alt="fig7" src="https://github.com/user-attachments/assets/be104bd1-e661-4b71-adc4-a6aba81bb45d" />

---

*更多算法请返回 [MicrowavePhotonics 主页](../README.md).*
