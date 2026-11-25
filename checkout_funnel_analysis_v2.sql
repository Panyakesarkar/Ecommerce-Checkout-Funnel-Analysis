-- ============================================================================
-- PROJECT: E-Commerce Checkout Funnel & Revenue Leakage Analysis
-- AUTHOR: Pranav Kesarkar | Role: Business Analyst Portfolio
-- ============================================================================

-- 1. Overall Funnel Conversion & Stage-Wise Drop-Off
SELECT
    COUNT(*) AS total_sessions,
    SUM(Added_To_Cart) AS cart_sessions,
    ROUND(SUM(Added_To_Cart) * 100.0 / COUNT(*), 2) AS view_to_cart_pct,
    SUM(Initiated_Checkout) AS checkout_sessions,
    ROUND(SUM(Initiated_Checkout) * 100.0 / NULLIF(SUM(Added_To_Cart), 0), 2) AS cart_to_checkout_pct,
    SUM(Order_Completed) AS completed_orders,
    ROUND(SUM(Order_Completed) * 100.0 / NULLIF(SUM(Initiated_Checkout), 0), 2) AS checkout_to_order_pct,
    ROUND(SUM(Order_Completed) * 100.0 / COUNT(*), 2) AS overall_conversion_pct
FROM ecommerce_checkout_funnel;

-- 2. Revenue Leakage by Device Type & Payment Method (Root Cause Analysis)
SELECT
    Device_Type,
    Payment_Method,
    SUM(Initiated_Checkout) AS checkouts_started,
    SUM(Order_Completed) AS orders_won,
    SUM(Initiated_Checkout - Order_Completed) AS abandoned_checkouts,
    ROUND(SUM(CASE WHEN Initiated_Checkout = 1 AND Order_Completed = 0 THEN Cart_Value_INR ELSE 0 END), 2) AS leaked_revenue_inr,
    ROUND(SUM(Order_Completed) * 100.0 / NULLIF(SUM(Initiated_Checkout), 0), 2) AS payment_success_rate
FROM ecommerce_checkout_funnel
WHERE Initiated_Checkout = 1
GROUP BY Device_Type, Payment_Method
ORDER BY leaked_revenue_inr DESC;

-- 3. Top Drop-Off Reasons Ranked via Window Functions
WITH FailureSummary AS (
    SELECT
        Dropoff_Reason,
        COUNT(*) AS failed_sessions,
        SUM(Cart_Value_INR) AS lost_gmv_inr
    FROM ecommerce_checkout_funnel
    WHERE Initiated_Checkout = 1 AND Order_Completed = 0
    GROUP BY Dropoff_Reason
)
SELECT
    Dropoff_Reason,
    failed_sessions,
    ROUND(lost_gmv_inr, 2) AS lost_gmv_inr,
    ROUND(failed_sessions * 100.0 / SUM(failed_sessions) OVER (), 2) AS share_of_dropoffs_pct,
    RANK() OVER (ORDER BY lost_gmv_inr DESC) AS revenue_impact_rank
FROM FailureSummary;
