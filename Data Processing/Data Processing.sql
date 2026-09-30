CREATE OR REPLACE VIEW vw_financial_ratios AS
SELECT 
    company_name,
    year,
    status_label,
    CASE WHEN LOWER(status_label) = 'failed' THEN 1 ELSE 0 END AS is_default,
    ROUND(CAST("X1" / NULLIF("X12", 0) AS numeric), 4) AS current_ratio,
    ROUND(CAST(("X1" - "X5") / NULLIF("X12", 0) AS numeric), 4) AS quick_ratio,
    ROUND(CAST("X17" / NULLIF("X12", 0) AS numeric), 4) AS cash_ratio,
    ROUND(CAST("X12" / NULLIF("X11", 0) AS numeric), 4) AS debt_to_assets,
    ROUND(CAST("X15" / NULLIF("X11", 0) AS numeric), 4) AS working_capital_to_assets,
    ROUND(CAST("X6" / NULLIF("X11", 0) AS numeric), 4) AS roa,
    ROUND(CAST("X6" / NULLIF("X11" - "X12", 0) AS numeric), 4) AS roe_approx,
    ROUND(CAST("X18" / NULLIF("X9", 0) AS numeric), 4) AS operating_margin,
    ROUND(CAST("X16" / NULLIF("X9", 0) AS numeric), 4) AS gross_margin,
    ROUND(CAST("X9" / NULLIF("X11", 0) AS numeric), 4) AS asset_turnover,
    ROUND(CAST("X8" / NULLIF("X11", 0) AS numeric), 4) AS retained_earnings_to_assets

FROM american_bankruptcy;