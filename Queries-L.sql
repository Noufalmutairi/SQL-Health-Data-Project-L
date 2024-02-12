-- Desciptive Statistics --
SELECT 
    COUNT(DISTINCT region) AS Number_of_regions,
    SUM(patients_2018 + patients_2019 + patients_2020 + patients_2021 + patients_2022) AS total_patients,
    ROUND(AVG(patients_2018 + patients_2019 + patients_2020 + patients_2021 + patients_2022),
            0) AS average_patients,
    (SELECT 
            SUM(male)
        FROM
            l_deom) AS total_males,
    (SELECT 
            SUM(female)
        FROM
            l_deom) AS total_females,
    MIN(patients_2018 + patients_2019 + patients_2020 + patients_2021 + patients_2022) AS min_patients,
    MAX(patients_2018 + patients_2019 + patients_2020 + patients_2021 + patients_2022) AS max_patients,
    ROUND(STDDEV(patients_2018 + patients_2019 + patients_2020 + patients_2021 + patients_2022),
            0) AS patients_stddev
FROM
    l_region;



-- Clculate the average and standard deviation for each year --
SELECT 
    ROUND(AVG(p_2019), 0) AS average_2019,
    ROUND(STDDEV(p_2019), 0) AS stddev_2019,
    ROUND(AVG(p_2020), 0) AS average_2020,
    ROUND(STDDEV(p_2020), 0) AS stddev_2020,
    ROUND(AVG(p_2021), 0) AS average_2021,
    ROUND(STDDEV(p_2021), 0) AS stddev_2021,
    ROUND(AVG(p_2022), 0) AS average_2022,
    ROUND(STDDEV(p_2022), 0) AS stddev_2022
FROM
    l_region;



-- Top 5 Regions -- 
SELECT 
    Region, total_patients
FROM
    l_region
ORDER BY total_patients DESC
LIMIT 5;



-- Find the percentage change in patients numbers for each region between 2018 and 2022 -- 
SELECT 
    Region,
    patients_2018,
    patients_2022,
    CONCAT(ROUND((patients_2022 - patients_2018) / patients_2018 * 100,
                    0),
            '%') AS percentage_change,
    CASE
        WHEN (patients_2022 - patients_2018) > 0 THEN 'increase'
        WHEN (patients_2022 - patients_2018) < 0 THEN 'decrease'
        ELSE 'No Change'
    END AS change_type
FROM
    l_region
ORDER BY percentage_change DESC;



-- the total number of patients for each age group --
SELECT 
    Age_group,
    SUM(patients_2018 + patients_2019 + patients_2020 + patients_2021 + patients_2022) AS total_patients
FROM
    l_agegroup
GROUP BY Age_group;



-- Find region with an increase in patients from 2018 to 2022 --
SELECT 
    Region, patients_2018, patients_2022
FROM
    l_region
WHERE
    patients_2018 < patients_2022;



-- Exploring the Demographics informations --
SELECT 
    SUM(male) AS `total Males`,
    SUM(female) AS `total Females`,
    SUM(saudi) AS `Saudi`,
    SUM(non_saudi) AS `Non Saudi`,
    SUM(Resident) AS `Resident Patients`,
    SUM(non_Resident) AS `Non Resident`
