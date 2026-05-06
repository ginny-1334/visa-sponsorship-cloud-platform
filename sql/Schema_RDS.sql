CREATE TABLE IF NOT EXISTS h1b_sponsors (
    id BIGSERIAL PRIMARY KEY,
    fiscal_year INT,
    employer_name TEXT,
    tax_id TEXT,
    industry_naics_code TEXT,
    employer_city TEXT,
    employer_state VARCHAR(10),
    employer_zip_code TEXT,
    new_employment_approval BIGINT,
    new_employment_denial BIGINT,
    continuation_approval BIGINT,
    continuation_denial BIGINT,
    change_same_employer_approval BIGINT,
    change_same_employer_denial BIGINT,
    new_concurrent_approval BIGINT,
    new_concurrent_denial BIGINT,
    change_employer_approval BIGINT,
    change_employer_denial BIGINT,
    amended_approval BIGINT,
    amended_denial BIGINT,
    visa_type TEXT DEFAULT 'H-1B',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS perm_records (
    id BIGSERIAL PRIMARY KEY,
    case_number TEXT,
    application_type TEXT,
    decision_date DATE,
    filing_year INT,
    case_status TEXT,
    employer_name TEXT,
    employer_address_1 TEXT,
    employer_address_2 TEXT,
    employer_city TEXT,
    employer_state VARCHAR(10),
    employer_postal_code TEXT,
    naics_code TEXT,
    naics_title TEXT,
    us_economic_sector TEXT,
    soc_code TEXT,
    job_title TEXT,
    pw_level TEXT,
    pw_amount NUMERIC(14,2),
    pw_unit_of_pay TEXT,
    wage_offer_from NUMERIC(14,2),
    wage_offer_to NUMERIC(14,2),
    wage_offer_unit_of_pay TEXT,
    work_city TEXT,
    work_state VARCHAR(10),
    country_of_citizenship TEXT,
    class_of_admission TEXT,
    visa_type TEXT DEFAULT 'PERM',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_h1b_employer_name
    ON h1b_sponsors (employer_name);

CREATE INDEX IF NOT EXISTS idx_h1b_employer_name_lower
    ON h1b_sponsors (LOWER(employer_name));

CREATE INDEX IF NOT EXISTS idx_h1b_state
    ON h1b_sponsors (employer_state);

CREATE INDEX IF NOT EXISTS idx_h1b_year
    ON h1b_sponsors (fiscal_year);

CREATE INDEX IF NOT EXISTS idx_h1b_visa_type
    ON h1b_sponsors (visa_type);

CREATE INDEX IF NOT EXISTS idx_perm_employer_name
    ON perm_records (employer_name);

CREATE INDEX IF NOT EXISTS idx_perm_employer_name_lower
    ON perm_records (LOWER(employer_name));

CREATE INDEX IF NOT EXISTS idx_perm_state
    ON perm_records (employer_state);

CREATE INDEX IF NOT EXISTS idx_perm_year
    ON perm_records (filing_year);

CREATE INDEX IF NOT EXISTS idx_perm_job_title
    ON perm_records (job_title);

CREATE INDEX IF NOT EXISTS idx_perm_visa_type
    ON perm_records (visa_type);

CREATE OR REPLACE VIEW unified_view AS
SELECT
    'H1B' AS source_table,
    id,
    employer_name,
    employer_city,
    employer_state AS state,
    fiscal_year AS year,
    NULL::TEXT AS job_title,
    visa_type,
    industry_naics_code AS industry_or_sector,
    NULL::TEXT AS case_status,
    new_employment_approval,
    new_employment_denial,
    continuation_approval,
    continuation_denial,
    change_same_employer_approval,
    change_same_employer_denial,
    new_concurrent_approval,
    new_concurrent_denial,
    change_employer_approval,
    change_employer_denial,
    amended_approval,
    amended_denial,
    NULL::NUMERIC(14,2) AS wage_offer_from,
    NULL::NUMERIC(14,2) AS wage_offer_to,
    NULL::TEXT AS work_city,
    NULL::VARCHAR(10) AS work_state
FROM h1b_sponsors

UNION ALL

SELECT
    'PERM' AS source_table,
    id,
    employer_name,
    employer_city,
    employer_state AS state,
    filing_year AS year,
    job_title,
    visa_type,
    us_economic_sector AS industry_or_sector,
    case_status,
    NULL::BIGINT AS new_employment_approval,
    NULL::BIGINT AS new_employment_denial,
    NULL::BIGINT AS continuation_approval,
    NULL::BIGINT AS continuation_denial,
    NULL::BIGINT AS change_same_employer_approval,
    NULL::BIGINT AS change_same_employer_denial,
    NULL::BIGINT AS new_concurrent_approval,
    NULL::BIGINT AS new_concurrent_denial,
    NULL::BIGINT AS change_employer_approval,
    NULL::BIGINT AS change_employer_denial,
    NULL::BIGINT AS amended_approval,
    NULL::BIGINT AS amended_denial,
    wage_offer_from,
    wage_offer_to,
    work_city,
    work_state
FROM perm_records;