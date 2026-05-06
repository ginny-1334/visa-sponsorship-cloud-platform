-- perm-clean-job:
SELECT
    case_number,
    application_type,
    decision_date,
    YEAR(CAST(decision_date AS DATE)) AS filing_year,
    case_status,

    REGEXP_REPLACE(
        UPPER(TRIM(employer_name)),
        '[^A-Z0-9 ]',
        ''
    ) AS employer_name,

    TRIM(employer_address_1) AS employer_address_1,
    NULL AS employer_address_2,
    TRIM(employer_city) AS employer_city,

    CASE
        WHEN employer_state IS NULL OR TRIM(employer_state) = '' THEN NULL
        WHEN LENGTH(TRIM(employer_state)) = 2 THEN UPPER(TRIM(employer_state))
        WHEN LOWER(TRIM(employer_state)) = 'alabama' THEN 'AL'
        WHEN LOWER(TRIM(employer_state)) = 'alaska' THEN 'AK'
        WHEN LOWER(TRIM(employer_state)) = 'arizona' THEN 'AZ'
        WHEN LOWER(TRIM(employer_state)) = 'arkansas' THEN 'AR'
        WHEN LOWER(TRIM(employer_state)) = 'california' THEN 'CA'
        WHEN LOWER(TRIM(employer_state)) = 'colorado' THEN 'CO'
        WHEN LOWER(TRIM(employer_state)) = 'connecticut' THEN 'CT'
        WHEN LOWER(TRIM(employer_state)) = 'delaware' THEN 'DE'
        WHEN LOWER(TRIM(employer_state)) = 'florida' THEN 'FL'
        WHEN LOWER(TRIM(employer_state)) = 'georgia' THEN 'GA'
        WHEN LOWER(TRIM(employer_state)) = 'hawaii' THEN 'HI'
        WHEN LOWER(TRIM(employer_state)) = 'idaho' THEN 'ID'
        WHEN LOWER(TRIM(employer_state)) = 'illinois' THEN 'IL'
        WHEN LOWER(TRIM(employer_state)) = 'indiana' THEN 'IN'
        WHEN LOWER(TRIM(employer_state)) = 'iowa' THEN 'IA'
        WHEN LOWER(TRIM(employer_state)) = 'kansas' THEN 'KS'
        WHEN LOWER(TRIM(employer_state)) = 'kentucky' THEN 'KY'
        WHEN LOWER(TRIM(employer_state)) = 'louisiana' THEN 'LA'
        WHEN LOWER(TRIM(employer_state)) = 'maine' THEN 'ME'
        WHEN LOWER(TRIM(employer_state)) = 'maryland' THEN 'MD'
        WHEN LOWER(TRIM(employer_state)) = 'massachusetts' THEN 'MA'
        WHEN LOWER(TRIM(employer_state)) = 'michigan' THEN 'MI'
        WHEN LOWER(TRIM(employer_state)) = 'minnesota' THEN 'MN'
        WHEN LOWER(TRIM(employer_state)) = 'mississippi' THEN 'MS'
        WHEN LOWER(TRIM(employer_state)) = 'missouri' THEN 'MO'
        WHEN LOWER(TRIM(employer_state)) = 'montana' THEN 'MT'
        WHEN LOWER(TRIM(employer_state)) = 'nebraska' THEN 'NE'
        WHEN LOWER(TRIM(employer_state)) = 'nevada' THEN 'NV'
        WHEN LOWER(TRIM(employer_state)) = 'new hampshire' THEN 'NH'
        WHEN LOWER(TRIM(employer_state)) = 'new jersey' THEN 'NJ'
        WHEN LOWER(TRIM(employer_state)) = 'new mexico' THEN 'NM'
        WHEN LOWER(TRIM(employer_state)) = 'new york' THEN 'NY'
        WHEN LOWER(TRIM(employer_state)) = 'north carolina' THEN 'NC'
        WHEN LOWER(TRIM(employer_state)) = 'north dakota' THEN 'ND'
        WHEN LOWER(TRIM(employer_state)) = 'ohio' THEN 'OH'
        WHEN LOWER(TRIM(employer_state)) = 'oklahoma' THEN 'OK'
        WHEN LOWER(TRIM(employer_state)) = 'oregon' THEN 'OR'
        WHEN LOWER(TRIM(employer_state)) = 'pennsylvania' THEN 'PA'
        WHEN LOWER(TRIM(employer_state)) = 'rhode island' THEN 'RI'
        WHEN LOWER(TRIM(employer_state)) = 'south carolina' THEN 'SC'
        WHEN LOWER(TRIM(employer_state)) = 'south dakota' THEN 'SD'
        WHEN LOWER(TRIM(employer_state)) = 'tennessee' THEN 'TN'
        WHEN LOWER(TRIM(employer_state)) = 'texas' THEN 'TX'
        WHEN LOWER(TRIM(employer_state)) = 'utah' THEN 'UT'
        WHEN LOWER(TRIM(employer_state)) = 'vermont' THEN 'VT'
        WHEN LOWER(TRIM(employer_state)) = 'virginia' THEN 'VA'
        WHEN LOWER(TRIM(employer_state)) = 'washington' THEN 'WA'
        WHEN LOWER(TRIM(employer_state)) = 'west virginia' THEN 'WV'
        WHEN LOWER(TRIM(employer_state)) = 'wisconsin' THEN 'WI'
        WHEN LOWER(TRIM(employer_state)) = 'wyoming' THEN 'WY'
        WHEN LOWER(TRIM(employer_state)) = 'district of columbia' THEN 'DC'
        ELSE UPPER(SUBSTRING(TRIM(employer_state), 1, 2))
    END AS employer_state,

    LPAD(REGEXP_REPLACE(CAST(employer_postal_code AS STRING), '\\.0$', ''), 5, '0') AS employer_postal_code,

    REGEXP_REPLACE(CAST(naics_code AS STRING), '\\.0$', '') AS naics_code,
    TRIM(naics_title) AS naics_title,
    TRIM(us_economic_sector) AS us_economic_sector,
    soc_code,
    UPPER(TRIM(job_title)) AS job_title,
    pw_level,
    CAST(pw_amount AS DECIMAL(14,2)) AS pw_amount,
    pw_unit_of_pay,
    CAST(wage_offer_from AS DECIMAL(14,2)) AS wage_offer_from,
    CAST(wage_offer_to AS DECIMAL(14,2)) AS wage_offer_to,
    wage_offer_unit_of_pay,
    TRIM(work_city) AS work_city,

    CASE
        WHEN work_state IS NULL OR TRIM(work_state) = '' THEN NULL
        WHEN LENGTH(TRIM(work_state)) = 2 THEN UPPER(TRIM(work_state))
        WHEN LOWER(TRIM(work_state)) = 'alabama' THEN 'AL'
        WHEN LOWER(TRIM(work_state)) = 'alaska' THEN 'AK'
        WHEN LOWER(TRIM(work_state)) = 'arizona' THEN 'AZ'
        WHEN LOWER(TRIM(work_state)) = 'arkansas' THEN 'AR'
        WHEN LOWER(TRIM(work_state)) = 'california' THEN 'CA'
        WHEN LOWER(TRIM(work_state)) = 'colorado' THEN 'CO'
        WHEN LOWER(TRIM(work_state)) = 'connecticut' THEN 'CT'
        WHEN LOWER(TRIM(work_state)) = 'delaware' THEN 'DE'
        WHEN LOWER(TRIM(work_state)) = 'florida' THEN 'FL'
        WHEN LOWER(TRIM(work_state)) = 'georgia' THEN 'GA'
        WHEN LOWER(TRIM(work_state)) = 'hawaii' THEN 'HI'
        WHEN LOWER(TRIM(work_state)) = 'idaho' THEN 'ID'
        WHEN LOWER(TRIM(work_state)) = 'illinois' THEN 'IL'
        WHEN LOWER(TRIM(work_state)) = 'indiana' THEN 'IN'
        WHEN LOWER(TRIM(work_state)) = 'iowa' THEN 'IA'
        WHEN LOWER(TRIM(work_state)) = 'kansas' THEN 'KS'
        WHEN LOWER(TRIM(work_state)) = 'kentucky' THEN 'KY'
        WHEN LOWER(TRIM(work_state)) = 'louisiana' THEN 'LA'
        WHEN LOWER(TRIM(work_state)) = 'maine' THEN 'ME'
        WHEN LOWER(TRIM(work_state)) = 'maryland' THEN 'MD'
        WHEN LOWER(TRIM(work_state)) = 'massachusetts' THEN 'MA'
        WHEN LOWER(TRIM(work_state)) = 'michigan' THEN 'MI'
        WHEN LOWER(TRIM(work_state)) = 'minnesota' THEN 'MN'
        WHEN LOWER(TRIM(work_state)) = 'mississippi' THEN 'MS'
        WHEN LOWER(TRIM(work_state)) = 'missouri' THEN 'MO'
        WHEN LOWER(TRIM(work_state)) = 'montana' THEN 'MT'
        WHEN LOWER(TRIM(work_state)) = 'nebraska' THEN 'NE'
        WHEN LOWER(TRIM(work_state)) = 'nevada' THEN 'NV'
        WHEN LOWER(TRIM(work_state)) = 'new hampshire' THEN 'NH'
        WHEN LOWER(TRIM(work_state)) = 'new jersey' THEN 'NJ'
        WHEN LOWER(TRIM(work_state)) = 'new mexico' THEN 'NM'
        WHEN LOWER(TRIM(work_state)) = 'new york' THEN 'NY'
        WHEN LOWER(TRIM(work_state)) = 'north carolina' THEN 'NC'
        WHEN LOWER(TRIM(work_state)) = 'north dakota' THEN 'ND'
        WHEN LOWER(TRIM(work_state)) = 'ohio' THEN 'OH'
        WHEN LOWER(TRIM(work_state)) = 'oklahoma' THEN 'OK'
        WHEN LOWER(TRIM(work_state)) = 'oregon' THEN 'OR'
        WHEN LOWER(TRIM(work_state)) = 'pennsylvania' THEN 'PA'
        WHEN LOWER(TRIM(work_state)) = 'rhode island' THEN 'RI'
        WHEN LOWER(TRIM(work_state)) = 'south carolina' THEN 'SC'
        WHEN LOWER(TRIM(work_state)) = 'south dakota' THEN 'SD'
        WHEN LOWER(TRIM(work_state)) = 'tennessee' THEN 'TN'
        WHEN LOWER(TRIM(work_state)) = 'texas' THEN 'TX'
        WHEN LOWER(TRIM(work_state)) = 'utah' THEN 'UT'
        WHEN LOWER(TRIM(work_state)) = 'vermont' THEN 'VT'
        WHEN LOWER(TRIM(work_state)) = 'virginia' THEN 'VA'
        WHEN LOWER(TRIM(work_state)) = 'washington' THEN 'WA'
        WHEN LOWER(TRIM(work_state)) = 'west virginia' THEN 'WV'
        WHEN LOWER(TRIM(work_state)) = 'wisconsin' THEN 'WI'
        WHEN LOWER(TRIM(work_state)) = 'wyoming' THEN 'WY'
        WHEN LOWER(TRIM(work_state)) = 'district of columbia' THEN 'DC'
        ELSE UPPER(SUBSTRING(TRIM(work_state), 1, 2))
    END AS work_state,

    TRIM(country_of_citizenship) AS country_of_citizenship,
    class_of_admission,
    'PERM' AS visa_type

FROM input

-- h1b-clean-job:
SELECT
    fiscal_year,

    -- Employer name: trim + uppercase + remove punctuation
    REGEXP_REPLACE(
        UPPER(TRIM(employer_name)),
        '[^A-Z0-9 ]',
        ''
    ) AS employer_name,

    tax_id,
    industry_naics_code,

    TRIM(employer_city) AS employer_city,

    -- State normalization (all states + DC)
    CASE
        WHEN employer_state IS NULL OR TRIM(employer_state) = '' THEN NULL
        WHEN LENGTH(TRIM(employer_state)) = 2 THEN UPPER(TRIM(employer_state))

        WHEN LOWER(TRIM(employer_state)) = 'alabama' THEN 'AL'
        WHEN LOWER(TRIM(employer_state)) = 'alaska' THEN 'AK'
        WHEN LOWER(TRIM(employer_state)) = 'arizona' THEN 'AZ'
        WHEN LOWER(TRIM(employer_state)) = 'arkansas' THEN 'AR'
        WHEN LOWER(TRIM(employer_state)) = 'california' THEN 'CA'
        WHEN LOWER(TRIM(employer_state)) = 'colorado' THEN 'CO'
        WHEN LOWER(TRIM(employer_state)) = 'connecticut' THEN 'CT'
        WHEN LOWER(TRIM(employer_state)) = 'delaware' THEN 'DE'
        WHEN LOWER(TRIM(employer_state)) = 'florida' THEN 'FL'
        WHEN LOWER(TRIM(employer_state)) = 'georgia' THEN 'GA'
        WHEN LOWER(TRIM(employer_state)) = 'hawaii' THEN 'HI'
        WHEN LOWER(TRIM(employer_state)) = 'idaho' THEN 'ID'
        WHEN LOWER(TRIM(employer_state)) = 'illinois' THEN 'IL'
        WHEN LOWER(TRIM(employer_state)) = 'indiana' THEN 'IN'
        WHEN LOWER(TRIM(employer_state)) = 'iowa' THEN 'IA'
        WHEN LOWER(TRIM(employer_state)) = 'kansas' THEN 'KS'
        WHEN LOWER(TRIM(employer_state)) = 'kentucky' THEN 'KY'
        WHEN LOWER(TRIM(employer_state)) = 'louisiana' THEN 'LA'
        WHEN LOWER(TRIM(employer_state)) = 'maine' THEN 'ME'
        WHEN LOWER(TRIM(employer_state)) = 'maryland' THEN 'MD'
        WHEN LOWER(TRIM(employer_state)) = 'massachusetts' THEN 'MA'
        WHEN LOWER(TRIM(employer_state)) = 'michigan' THEN 'MI'
        WHEN LOWER(TRIM(employer_state)) = 'minnesota' THEN 'MN'
        WHEN LOWER(TRIM(employer_state)) = 'mississippi' THEN 'MS'
        WHEN LOWER(TRIM(employer_state)) = 'missouri' THEN 'MO'
        WHEN LOWER(TRIM(employer_state)) = 'montana' THEN 'MT'
        WHEN LOWER(TRIM(employer_state)) = 'nebraska' THEN 'NE'
        WHEN LOWER(TRIM(employer_state)) = 'nevada' THEN 'NV'
        WHEN LOWER(TRIM(employer_state)) = 'new hampshire' THEN 'NH'
        WHEN LOWER(TRIM(employer_state)) = 'new jersey' THEN 'NJ'
        WHEN LOWER(TRIM(employer_state)) = 'new mexico' THEN 'NM'
        WHEN LOWER(TRIM(employer_state)) = 'new york' THEN 'NY'
        WHEN LOWER(TRIM(employer_state)) = 'north carolina' THEN 'NC'
        WHEN LOWER(TRIM(employer_state)) = 'north dakota' THEN 'ND'
        WHEN LOWER(TRIM(employer_state)) = 'ohio' THEN 'OH'
        WHEN LOWER(TRIM(employer_state)) = 'oklahoma' THEN 'OK'
        WHEN LOWER(TRIM(employer_state)) = 'oregon' THEN 'OR'
        WHEN LOWER(TRIM(employer_state)) = 'pennsylvania' THEN 'PA'
        WHEN LOWER(TRIM(employer_state)) = 'rhode island' THEN 'RI'
        WHEN LOWER(TRIM(employer_state)) = 'south carolina' THEN 'SC'
        WHEN LOWER(TRIM(employer_state)) = 'south dakota' THEN 'SD'
        WHEN LOWER(TRIM(employer_state)) = 'tennessee' THEN 'TN'
        WHEN LOWER(TRIM(employer_state)) = 'texas' THEN 'TX'
        WHEN LOWER(TRIM(employer_state)) = 'utah' THEN 'UT'
        WHEN LOWER(TRIM(employer_state)) = 'vermont' THEN 'VT'
        WHEN LOWER(TRIM(employer_state)) = 'virginia' THEN 'VA'
        WHEN LOWER(TRIM(employer_state)) = 'washington' THEN 'WA'
        WHEN LOWER(TRIM(employer_state)) = 'west virginia' THEN 'WV'
        WHEN LOWER(TRIM(employer_state)) = 'wisconsin' THEN 'WI'
        WHEN LOWER(TRIM(employer_state)) = 'wyoming' THEN 'WY'
        WHEN LOWER(TRIM(employer_state)) = 'district of columbia' THEN 'DC'

        ELSE UPPER(SUBSTRING(TRIM(employer_state), 1, 2))
    END AS employer_state,

    -- ZIP cleanup
    LPAD(
        REGEXP_REPLACE(CAST(employer_zip_code AS STRING), '\\.0$', ''),
        5,
        '0'
    ) AS employer_zip_code,

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

    'H-1B' AS visa_type

FROM input
