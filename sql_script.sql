
-- Assume there is a table called 'admissions' in Microsoft SQL Server.
-- Write an SQL query to calculate the total and average admissions for each month over the last two years. Include the month and year in the results
SELECT
    YEAR(AdmissionDate) AS Year,
    MONTH(AdmissionDate) AS Month,
    COUNT(*) AS Total_Admissions,
    AVG(COUNT(episode_id)) OVER () AS Average_Admissions
FROM
    admissions
WHERE
    AdmissionDate >= DATEADD(YEAR, -2, GETDATE())
GROUP BY
    YEAR(AdmissionDate), MONTH(AdmissionDate)
ORDER BY
    Year, Month;


--Write an SQL query to analyse the distribution of TotalCharges by PrincipalDiagnosis and Sex. Use percentiles to describe the distribution.

SELECT DISTINCT
    PrincipalDiagnosis,
    Sex,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY TotalCharges) OVER (PARTITION BY PrincipalDiagnosis, Sex) AS Percentile_25,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TotalCharges) OVER (PARTITION BY PrincipalDiagnosis, Sex) AS Median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY TotalCharges) OVER (PARTITION BY PrincipalDiagnosis, Sex) AS Percentile_75
FROM
    admissions;