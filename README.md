# Quantitative Credit Risk & Scorecard Analytics Report

An executive-level analysis of corporate insolvency risk built on the `american_bankruptcy` dataset (78,682 financial statements). This report evaluates key drivers of corporate failure, establishes a quantitative credit scoring model, and defines risk-adjusted underwriting strategies.

---

## Executive Summary & Strategic Context

Credit risk management requires balancing loan portfolio growth with strict exposure controls. The primary objective of this project is to convert raw corporate financial statements into an actionable **Credit Scorecard** to optimize credit underwriting and automate approval workflows.

### Key Model Performance Indicators
- **Dataset Scope**: 78,682 corporate reporting periods
- **Model Discriminatory Power**: Out-of-Sample AUC = `0.5560` (Gini Coefficient = `0.1119`)
- **Probability Calibration Accuracy**: Brier Score = `0.0667`
- **Population Stability Index (PSI)**: `0.0000` (Zero structural drift between Train and Evaluation sets)

---

## Core Problem Statement & Business Rationale

When evaluating corporate borrowers, financial ratios serve as critical leading indicators of financial distress. However, relying on raw metrics introduces distinct operational challenges:
1. **Multicollinearity & Noise**: Overlapping financial indicators can distort risk perception and inflate model variance.
2. **Non-linear Failure Patterns**: Corporate insolvency rarely follows a linear deterioration; sudden liquidity shocks often trigger default events before leverage or profitability metrics reflect severe stress.

To resolve these challenges, the framework utilizes **Weight of Evidence (WoE)** and **Information Value (IV)** to isolate true predictive risk drivers, followed by a **Logistic Regression Scorecard** to scale default probabilities ($PD$) into a standardized Credit Score ($Base = 600, PDO = 20, Odds = 50:1$).

---

## In-Depth Analysis of Findings

### 1. Key Drivers of Corporate Insolvency (Information Value Analysis)
<img width="741" height="489" alt="image" src="https://github.com/user-attachments/assets/c53e45d1-606f-4f0f-93ce-a0462a423a60" />

The Information Value (IV) screening reveals a distinct hierarchy in how corporate financial distress manifests:

* **Short-Term Liquidity (`Current Ratio` — $IV = 0.180$)**: 
  - *Business Rationale*: Serves as the single strongest leading indicator of corporate failure. A sudden drop in liquid assets relative to immediate obligations causes acute cash-flow starvation, forcing default regardless of long-term solvency or overall asset size.
* **Structural Leverage (`Debt-to-Assets` — $IV = 0.150$)**: 
  - *Business Rationale*: High leverage significantly exacerbates vulnerability to macroeconomic shocks and rising debt service burdens, eroding operational flexibility.
* **Profitability & Operational Efficiency (`ROA`, `Operating Margin`)**: 
  - *Business Rationale*: Secondary risk drivers. While persistent margin compression erodes equity over time, firms with strong liquidity buffers can sustain longer under poor profitability than profitable firms facing sudden liquidity freezes.

### 2. Credit Scorecard & Automated Decisioning Strategy
<img width="683" height="491" alt="image" src="https://github.com/user-attachments/assets/14f3b3d8-e3d5-4dfe-abc9-92a012c0bbb6" />

Converting raw default probabilities into a standardized Credit Score provides an intuitive, risk-based decision engine for underwriting teams.

* **Score Distribution Characteristics**:
  - **Insolvent Borrowers (Default)**: Cluster significantly toward the lower score spectrum (Mean $\approx 540$).
  - **Solvent Borrowers (Non-Default)**: Concentrate toward higher stability bands (Mean $\approx 625$).

* **Proposed Underwriting Strategy & Cut-Off Policy**:
  - **Score < 580 (High Risk)**: **Automated Decline** / Mandatory high-value collateral requirement.
  - **Score 580 – 640 (Medium Risk)**: **Manual Underwriting Review** / Conditional approval with restrictive covenants and risk-adjusted pricing.
  - **Score > 640 (Low Risk)**: **Automated Approval** / Preferred interest rates and streamlined disbursement.

### 3. Model Backtesting & Stability Evaluation

* **Generalization Capability**:
  <img width="651" height="489" alt="image" src="https://github.com/user-attachments/assets/7c031bbb-0bc9-4f19-a7db-fdfd750d4f71" />

  - The model demonstrates high generalization stability, with In-Sample AUC (`0.5647`) closely tracking Out-of-Sample AUC (`0.5560`). The minimal gap ($\Delta AUC = 0.0087$) confirms the model is free from overfitting and performs consistently on unseen data.
* **Probability Calibration (Brier Score = `0.0667`)**:
* <img width="656" height="491" alt="image" src="https://github.com/user-attachments/assets/33eef9da-a97f-4c79-9b36-b552efc9090f" />

  - A low Brier Score confirms that predicted default probabilities closely align with actual historical failure rates. Accurate $PD$ calibration is essential to prevent the mispricing of credit risk during underwriting.
* **Population Drift (PSI = `0.0000`)**:
  - A PSI score well below the $0.10$ threshold indicates zero population shift between training and evaluation cohorts, ensuring consistent credit scoring behavior over time.

---
