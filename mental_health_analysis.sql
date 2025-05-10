-- PROJECT - Mental Health Trends Analysis

-- This project explores how mental health varies by gender, age, workplace wellness programs,
-- and location. It looks at how family history affects seeking help and the impact of mental health on work life.

-- Creating the Database 
CREATE DATABASE mental_health_db;
USE mental_health_db;

-- Creating & Retrieving the table 
SELECT * from mental_health;

-- Few Insights on Mental Health issues:

-- Distribution of Reported Mental Health Issues by Gender
SELECT 
    Gender,
    COUNT(*) AS total_count,
    SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) AS reported_mental_health_issues,
    ROUND(SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage
FROM mental_health
GROUP BY Gender
ORDER BY total_count DESC;


-- Mental Health Impact Across Different Age Groups 
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    COUNT(*) AS total_respondents,
    SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) AS mental_health_affected,
    ROUND(SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage_affected
FROM mental_health
GROUP BY age_group
ORDER BY age_group;

-- Workplace Wellness Programs on Seeking Mental Health Help
SELECT 
    wellness_program AS has_wellness_program,
    seek_help AS sought_mental_health_help,
    COUNT(*) AS count
FROM mental_health
GROUP BY wellness_program, seek_help
ORDER BY wellness_program, seek_help;

-- Comparison of Mental Health Reports in Tech vs Non-Tech Companies
SELECT 
    tech_company AS works_at_tech_company,
    COUNT(*) AS employee_count,
    SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) AS reported_mental_health_issues,
    SUM(CASE WHEN seek_help = 'Yes' THEN 1 ELSE 0 END) AS sought_help
FROM mental_health
GROUP BY tech_company;

-- Countries with the Highest Number of Reported Mental Health Consequences
SELECT 
    Country,
    COUNT(*) AS total_respondents,
    SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) AS mental_health_issues
FROM mental_health
GROUP BY Country 
ORDER BY mental_health_issues DESC
LIMIT 5;

-- Correlation Between Family History of Mental Illness and Treatment Seeking
SELECT 
    family_history AS family_mental_health_history,
    treatment AS received_treatment,
    COUNT(*) AS count
FROM mental_health
GROUP BY family_history, treatment
ORDER BY family_history, treatment;

-- Gender-Based Comparison of Mental and Physical Health Consequences
SELECT 
    Gender,
    COUNT(*) AS total_count,
    SUM(CASE WHEN mental_health_consequence = 'Yes' THEN 1 ELSE 0 END) AS mental_health_issues,
    SUM(CASE WHEN phys_health_consequence = 'Yes' THEN 1 ELSE 0 END) AS physical_health_issues
FROM mental_health
GROUP BY Gender
ORDER BY total_count DESC;

-- Work Interference Based on Care Options
SELECT 
    care_options AS has_mental_health_care_options,
    work_interfere AS mental_health_interferes_with_work,
    COUNT(*) AS count
FROM mental_health
WHERE work_interfere IS NOT NULL
GROUP BY care_options, work_interfere
ORDER BY care_options, work_interfere;

-- Reported Workplace Consequences for Observing Mental Health Issues
SELECT 
    obs_consequence,
    COUNT(*) AS total
FROM mental_health
GROUP BY obs_consequence
ORDER BY total DESC;


-- Note on Data Cleaning:
-- I cleaned the data before analysis by fixing the gender column to keep values consistent, removing or filling 
-- missing values in key fields like work interference and mental health consequence, checking age values for any
-- odd entries, and making sure categories were written in a similar way for easier grouping.

-- Wrote SQL queries to analyze:
--  Gender distribution in mental health consequences.
--  Mental health trends across different age groups.
--  The role of workplace wellness programs in encouraging help-seeking.
--  Mental health patterns in tech vs non-tech companies.
--  Countries with the highest reported mental health issues.
--  Correlation between family history and seeking treatment.
--  Differences in mental and physical health consequences across genders.
--  Impact of care options on work interference.
--  Reported workplace consequences of observing mental health issues.