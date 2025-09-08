# 🎯 Course Overview

This repository contains comprehensive laboratory work for the Digital Signal Processing course (Academic Year 2022), covering fundamental to advanced DSP concepts through hands-on MATLAB implementation. Each assignment builds upon previous knowledge, progressing from basic sampling theory to advanced filter design techniques.

## Assignment 01: Sampling, Quantization & Encoding
**Focus:** Foundation of digital signal processing

- **Signal Analysis:** Multi-frequency sinusoids (20R, 60R, 120R Hz where R=55)
- **Sampling Study:** Different sampling frequencies and reconstruction quality
- **Quantization:** 3-8 bit uniform quantization with theoretical vs experimental SQNR
- **Compression:** μ-law and A-law companding for voice signals
- **Key Results:** SQNR improvement of ~6dB per additional bit, compression benefits for voice

## Assignment 02A: Signal Operations & Transformations
**Focus:** Discrete-time signal manipulation

- **Signal Operations:** Addition, subtraction, time-scaling, time-shifting
- **Voice Processing:** Decimation effects on audio signals (s₁(n/2), s₂(n/3))
- **Symmetry Analysis:** Odd/even decomposition of signals
- **Audio Evaluation:** Subjective quality assessment of processed voice signals
- **Signals Used:** Step, ramp, impulse functions and recorded voice samples

## Assignment 02B: Convolution & LCCDE
**Focus:** System analysis through difference equations

- **Convolution Analysis:** Triangular signal convolution with peak P = (5 + Last Digit of ID)
- **Complex Operations:** Multi-stage convolution, time-reversal effects
- **LCCDE Solutions:** Manual implementation using loops, system function derivation
- **Stability Analysis:** Coefficient variation effects on system stability
- **System Response:** Impulse, step, and custom input responses for stability assessment

## Assignment 02C: Correlation Analysis
**Focus:** Signal correlation and similarity analysis

- **Cross-Correlation:** Computing correlation between different signals
- **Auto-Correlation:** Self-similarity analysis of signals
- **Time Delay Estimation:** Finding delays between correlated signals
- **Matched Filtering:** Correlation-based signal detection techniques
- **Noise Analysis:** Correlation properties in presence of noise
- **Pattern Recognition:** Using correlation for signal identification and matching

## Assignment 03: Z-Transform Applications
**Focus:** Advanced system analysis and design

- **System Functions:** Four different H(z) transfer functions analysis
- **Stability Assessment:** Pole-zero analysis, unstable system identification
- **System Combinations:** Series, parallel, and delayed system configurations
- **Butterworth Filter:** 4th-order LPF analysis with various cosine inputs
- **Schür-Cohn Test:** Custom MATLAB function for stability testing
- **Causality Study:** Relationship between causality and stability

## Assignment 04: Frequency Domain Analysis
**Focus:** Advanced frequency domain techniques

- **Filter Classification:** Pole-zero analysis for filter type identification
- **Parseval's Theorem:** Mathematical verification with custom signal examples
- **DFT Optimization:** Finding minimum DFT points for frequency resolution
- **PSD Analysis:** Voice signal corruption with colored noise (car, office, fan, traffic)
- **FDM System:** Complete frequency division multiplexing implementation
- **Signal Processing:** 5kHz and 10kHz carriers, 30-40kHz sampling, noise addition

## Assignment 05: FIR Filter Design
**Focus:** Advanced filter design techniques

- **Window Functions:** Comparative analysis of main lobe width and side lobe levels (M=25)
- **Frequency Resolution:** Multi-frequency signal analysis with different windows
- **Kaiser Filter Design:** LPF, BPF, HPF design with ripple constraints (δₚ, 5δₛ < 0.03)
- **Filter Optimization:** Window length < 50 constraint with frequency extraction
- **Signal Extraction:** Three-frequency sinusoid separation and analysis

**Educational Purpose Only:** This repository contains completed coursework for EEE 312 at BUET (2022) by Tasmin Khan (ID: 1906055).

**Disclaimer:** Author assumes no responsibility for academic misconduct by others. Use responsibly and maintain academic integrity.
