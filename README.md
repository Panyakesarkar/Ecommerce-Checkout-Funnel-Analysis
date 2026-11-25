# Ecommerce-Checkout-Funnel-Analysis
# E-Commerce Checkout Funnel & Revenue Leakage Case Study

## Project Overview
An end-to-end Business Analysis case study analyzing 2,500 customer sessions to identify checkout drop-offs, quantify revenue leakage by device and payment method, and propose functional solutions via a structured Business Requirements Document (BRD).

## Key Findings (From 2,500 Sessions)
- **Funnel Conversion:** 2,500 Product Views → 1,719 Add-to-Carts (68.8%) → 1,230 Checkouts Initiated (71.6%) → 919 Completed Orders (74.7% payment completion; 36.8% overall conversion).
- **Primary Bottleneck:** Mobile Web checkout conversion lags behind Native Apps due to payment gateway timeouts and OTP friction.
- **Top Drop-Off Drivers:** Payment Gateway Timeouts (42%) and OTP Delays (28%) account for 70% of checkout failures.
- **Projected Impact:** Implementing 1-tap UPI Intent deep-linking and smart payment retry routing is projected to recover 18%–22% of abandoned checkout GMV.

## Files in This Repository
- `Ecommerce_Checkout_Funnel_BRD_v2.docx` — Business Requirements Document (Problem Statement, Root Cause Analysis, As-Is vs. To-Be Process Flow, User Stories & KPIs).
- `checkout_funnel_analysis_v2.sql` — SQL queries using CTEs, `CASE WHEN`, and Window Functions (`RANK() OVER`, `SUM() OVER`).
- `ecommerce_checkout_funnel_v2.csv` — Session-level checkout funnel dataset (2,500 records).
