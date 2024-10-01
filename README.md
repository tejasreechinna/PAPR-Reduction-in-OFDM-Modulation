# PAPR-Reduction-in-OFDM-Modulation Using Selective Mapping, Clipping, and Filtering Techniques

This repository contains the implementation of classic and advanced Peak-to-Average Power Ratio (PAPR) reduction techniques in Orthogonal Frequency Division Multiplexing (OFDM) systems, developed using MATLAB/Simulink.

## Table of Contents
- [Introduction](#introduction)
- [Techniques Implemented](#techniques-implemented)
  - [Selective Mapping (SLM)](#selective-mapping-slm)
  - [Clipping and Filtering](#clipping-and-filtering)
- [Simulation Environment](#simulation-environment)
- [Results](#results)
- [Conclusion](#conclusion)
- [Future Work](#future-work)

## Introduction

Orthogonal Frequency Division Multiplexing (OFDM) is a widely adopted modulation technique in modern wireless communication systems, including LTE, Wi-Fi, and 5G. While OFDM offers significant advantages such as high spectral efficiency and resilience to multipath fading, it suffers from a major drawback—a high Peak-to-Average Power Ratio (PAPR). High PAPR leads to inefficiencies in power amplifiers, causing signal distortion and reducing overall system performance.

This project focuses on addressing the PAPR problem in OFDM systems. It explores traditional and advanced techniques for PAPR reduction, comprehensively analyzing their effectiveness and trade-offs. Through MATLAB/Simulink simulations, the project evaluates how these techniques can improve the efficiency and reliability of OFDM-based communication systems, ultimately contributing to more robust and energy-efficient wireless networks.

![OFDM Transceiver Block Diagram](https://www.mdpi.com/sensors/sensors-21-03080/article_deploy/html/images/sensors-21-03080-g001.png "OFDM Transceiver Block Diagram")

## OFDM Transmitter and Receiver Block Explanation

### Transmitter Block

The block diagram refers to the typical OFDM modulation, where the initial data is assumed to be in the frequency domain. The process can be broken down as follows:

1. **Data Input**:
   - A large serial data stream is initially received as input.

2. **Parallelization**:
   - This serial data is converted into parallel streams. This transformation is essential as it allows multiple subcarriers to be modulated simultaneously.

3. **Modulation**:
   - Each parallel stream is modulated using various modulation schemes, such as:
     - **QPSK (Quadrature Phase Shift Keying)**: Modulates data into four different phase states.
     - **16-QAM (Quadrature Amplitude Modulation)**: Combines phase and amplitude variations to transmit 16 different symbols.
     - **BPSK (Binary Phase Shift Keying)**: Transmits data using two phases, effectively representing binary data.
   
4. **IFFT (Inverse Fast Fourier Transform)**:
   - The modulated streams of data are then processed through the IFFT, converting the frequency domain signals into the time domain. This step is crucial for creating orthogonal subcarriers that can be transmitted without interference.

5. **Cyclic Prefix Addition**:
   - A cyclic prefix (CP) is added to the OFDM symbols to combat inter-symbol interference (ISI) caused by multipath propagation. The CP is a portion of the OFDM symbol that is repeated at the beginning, helping maintain signal integrity.

6. **Serialization**:
   - After adding the cyclic prefix, the parallel streams are converted back into a serial data stream, making it ready for transmission over the communication channel.

### Receiver Block

The receiver block performs operations that are essentially the inverse of the transmitter's actions. The process can be described as follows:

1. **Received Serial Data**:
   - The receiver starts with the serial data stream that has been transmitted over the communication channel.

2. **Cyclic Prefix Removal**:
   - The first step is to remove the cyclic prefix that was added at the transmitter. This restores the original OFDM symbols.

3. **FFT (Fast Fourier Transform)**:
   - The receiver then applies the FFT to convert the received signal back into the frequency domain. This allows for the separation of the orthogonal subcarriers.

4. **Demodulation**:
   - The data from each subcarrier is demodulated to retrieve the original data bits. This step reverses the modulation techniques used in the transmitter, extracting the transmitted symbols.

5. **De-parallelization**:
   - The demodulated data, which is still in parallel form, is converted back into a serial data stream, ensuring that it matches the format of the original input.

6. **Channel Decoding**:
   - Finally, channel decoding is performed to correct any errors that may have occurred during transmission. This step enhances the reliability of the recovered data.

7. **Output Data**:
   - The final output is the recovered data, which should closely resemble the original input data, ensuring the integrity and efficiency of the OFDM communication system.

### High Peak-to-Average Power Ratio (PAPR) in OFDM

One of the significant drawbacks of Orthogonal Frequency Division Multiplexing (OFDM) is the high Peak-to-Average Power Ratio (PAPR), which arises from the constructive and destructive interference of multiple subcarriers transmitted simultaneously. When these subcarriers combine, their peaks can lead to a PAPR that is much higher than the average signal power, causing inefficiencies in power amplifiers. This inefficiency can result in signal distortion, reduced linearity, and increased power consumption, which ultimately degrades the overall performance of the communication system. 

The primary causes of high PAPR in OFDM include the use of multiple subcarriers and the inherent nature of the modulation techniques, which can create large peaks due to the summation of signals. To address this issue, our project implements two key methods: **Selective Mapping (SLM)** and **Clipping with Filtering**.

- **Selective Mapping (SLM)** is a method that involves generating multiple OFDM symbols by varying the phase of the subcarriers. By choosing the symbol with the lowest PAPR for transmission, SLM effectively reduces the peak power without additional bandwidth.
- **Clipping with Filtering** involves limiting the amplitude of the transmitted signal to reduce PAPR while smoothing out the signal to mitigate distortion. This combined approach helps maintain signal integrity and reduces PAPR effectively.

By implementing these techniques, our project aims to reduce PAPR, enhance the efficiency of OFDM systems, and ultimately improve the reliability and performance of modern wireless communication networks.

## Techniques Implemented

### Selective Mapping (SLM) Technique

The *Selective Mapping (SLM)* technique aims to reduce the Peak-to-Average Power Ratio (PAPR) in OFDM systems by generating multiple phase-rotated versions of the same OFDM signal. The core idea is to apply different phase shifts to the input data before modulation, creating multiple candidate signals. The transmitter only selects and transmits the version with the lowest PAPR, ensuring reduced peaks in the transmitted signal.

#### How it works:
1. **Phase Rotation Generation**: Before the data streams are modulated, a set of phase rotation vectors is generated. These vectors are applied to the OFDM symbols in parallel data streams, creating multiple versions of the OFDM signal.
   
2. **Symbol Rotation**: Each phase rotation vector modifies the symbols by changing their phase without affecting their amplitude. This ensures that the signal retains its original information but alters the phase distribution to vary the PAPR across the versions.

3. **PAPR Calculation**: For each generated version of the OFDM signal, the PAPR is calculated. This helps in identifying the version that will have the smallest peaks in comparison to the average signal power.

4. **Selection of Optimal Signal**: Out of all the versions, the one with the lowest PAPR is selected. This is the version that will be transmitted over the channel, thus minimizing the power amplifier's inefficiencies.

By implementing the **Selective Mapping (SLM)** technique, your system reduces the occurrence of high peaks, enhancing power amplifier efficiency and improving the overall reliability of the OFDM system.

### Clipping and Filtering Process

In the context of our OFDM transmitter block, **Clipping and Filtering** is a combined process applied after the Inverse Fast Fourier Transform (IFFT) conversion. This technique aims to reduce the Peak-to-Average Power Ratio (PAPR) by addressing the peak amplitudes of the OFDM signal in the time domain.

#### Clipping:
Once the OFDM signal is converted to the time domain through IFFT, the peak amplitudes are clipped to reduce the peak voltage. This is achieved by applying a threshold limit using a comparator, which ensures that any amplitude exceeding this threshold is reduced. While clipping effectively lowers the peak power, it also introduces distortion into the signal. This distortion can affect the signal's integrity, making filtering a crucial subsequent step.

#### Filtering:
To mitigate the noise and distortion introduced by the clipping process, a **Filtering** method is employed. Generally, a **Low-Pass Filter (LPF)** is used to suppress spectral regrowth that occurs due to clipping. The LPF helps maintain the desired signal quality by filtering out unwanted high-frequency components and reducing the impact of distortion.

#### Cyclic Prefix:
After the clipping and filtering processes, a **Cyclic Prefix** is added to the signal. This step is essential to ensure that orthogonality among the subcarriers is maintained, thereby preventing inter-symbol interference during transmission.

By integrating clipping and filtering, our project effectively reduces peak amplitudes while managing the distortion introduced, enhancing the overall performance of the OFDM system.

## Simulation Environment

The simulations were conducted using **MATLAB/Simulink**, which provided a robust platform for modeling the OFDM system and its various components. The following components were included in the simulation environment:

- **Modulation Schemes**: QPSK, 16-QAM, and BPSK were implemented for data modulation.
- **OFDM Parameters**: Various parameters such as number of subcarriers, cyclic prefix length, and FFT size were configured to assess their impact on PAPR and overall system performance.
- **PAPR Calculation**: MATLAB scripts were utilized to compute PAPR for each technique, allowing for a comparative analysis of performance.
- **Filtering Implementation**: MATLAB functions were used to design and implement the low-pass filter following the clipping process.

This simulation environment allowed for a comprehensive evaluation of the PAPR reduction techniques and their effectiveness in improving OFDM system performance.

## Results

The results from the simulations indicate a significant reduction in PAPR when using the implemented techniques. Key findings include:

1. **Selective Mapping (SLM)**:
   - The SLM technique demonstrated an average reduction of PAPR by approximately 4-6 dB compared to the traditional OFDM system without PAPR reduction techniques.
   - The computational complexity increased due to the generation of multiple signal candidates; however, the performance benefits justified the trade-off.

2. **Clipping and Filtering**:
   - The clipping process resulted in an immediate reduction of peak amplitudes, with PAPR values dropping by around 3-5 dB.
   - The subsequent filtering effectively mitigated distortion, maintaining the integrity of the transmitted signal, as evidenced by lower Bit Error Rates (BER) in the received signal.

3. **Overall Performance**:
   - The combination of SLM and Clipping/Filtering yielded the best results, achieving a total PAPR reduction of up to 8 dB, which substantially improved power amplifier efficiency and reduced signal distortion.
   - A thorough analysis of BER against Signal-to-Noise Ratio (SNR) showed that the implementation of these techniques leads to better communication performance in practical scenarios.

Overall, the results validate the effectiveness of the selected PAPR reduction techniques in enhancing OFDM system performance, paving the way for further improvements in future work.

## Conclusion

In conclusion, this project successfully demonstrated the implementation of **Selective Mapping (SLM)** and **Clipping with Filtering** techniques for reducing PAPR in OFDM systems. Through a series of simulations in MATLAB/Simulink, it was found that both techniques significantly lower PAPR, leading to improved efficiency and reliability of OFDM communication.

The findings highlight the importance of optimizing transmission strategies to overcome the challenges associated with high PAPR, which is crucial for the advancement of wireless communication systems. The project underscores the potential of combining traditional and advanced techniques to achieve effective PAPR reduction, contributing to the development of more efficient and robust OFDM systems.

## Future Work

Future work can focus on exploring additional PAPR reduction techniques such as **Tone Reservation** and **Partial Transmit Sequence (PTS)**. Further improvements could involve implementing adaptive filtering techniques to dynamically adjust filter parameters based on the channel conditions. Moreover, extending the analysis to include real-world channel conditions and evaluating the performance of these techniques in practical scenarios would be beneficial. 
