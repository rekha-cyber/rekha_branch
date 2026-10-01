-- =========================================================================
-- queries.sql - your analysis
--
-- Project 1 | SQL: From Data to Insight
-- Team:
-- Dataset:
--
-- This is a DELIVERABLE, graded on two things: the SQL, and what you wrote
-- underneath it. A query with no finding recorded is half an answer - in a
-- month you will not remember what it told you, and neither will whoever is
-- marking it.
--
-- Five queries minimum, each earning its place by answering a question you
-- wrote down in notebook 01. The aggregation should happen here, in SQL,
-- not in pandas after a SELECT *.
-- =========================================================================


-- =========================================================================
-- Q1 | Query 1: Compare average real GDP growth across government composition
-- categories. Also returns the number of country-year observations in each
-- category to provide context for the comparison.
-- =========================================================================
-- Hypothesis: <what you expected before running it>
-- Finding:    <what came back, with the number that matters>


SELECT
    gt.government_type,
    ROUND(AVG(cy.gdp_growth), 2) AS avg_gdp_growth,
    COUNT(*) AS observations
FROM country_year AS cy
INNER JOIN government_types AS gt
    ON cy.government_type_id = gt.government_type_id
GROUP BY gt.government_type_id, gt.government_type
ORDER BY gt.government_type_id;



-- =========================================================================
-- Q2 |Query 2: Compare average unemployment across government composition
-- categories and show the number of observations in each category.
-- =========================================================================
-- Hypothesis:
-- Finding:

SELECT
    gt.government_type,
    ROUND(AVG(cy.unemployment), 2) AS avg_unemployment,
    COUNT(*) AS observations
FROM country_year AS cy
INNER JOIN government_types AS gt
    ON cy.government_type_id = gt.government_type_id
GROUP BY gt.government_type_id, gt.government_type
ORDER BY gt.government_type_id;




-- =========================================================================
-- Q3 |Query 3: Compare average inflation across government composition
-- categories and show the number of observations in each category.
-- =========================================================================
-- Hypothesis:
-- Finding:

SELECT
    gt.government_type,
    ROUND(AVG(cy.inflation), 2) AS avg_inflation,
    COUNT(*) AS observations
FROM country_year AS cy
INNER JOIN government_types AS gt
    ON cy.government_type_id = gt.government_type_id
GROUP BY gt.government_type_id, gt.government_type
ORDER BY gt.government_type_id;



-- =========================================================================
-- Q4 |Country-level GDP growth by government composition
-- =========================================================================
-- Hypothesis:
-- Finding:
SELECT
    c.country_name,
    gt.government_type,
    ROUND(AVG(cy.gdp_growth), 2) AS avg_gdp_growth,
    COUNT(*) AS observations
FROM country_year AS cy
INNER JOIN countries AS c
    ON cy.country_id = c.country_id
INNER JOIN government_types AS gt
    ON cy.government_type_id = gt.government_type_id
GROUP BY
    c.country_name,
    gt.government_type_id,
    gt.government_type
HAVING COUNT(*) >= 3
ORDER BY
    c.country_name,
    gt.government_type_id;




-- =========================================================================
-- Q5 | Query 5: Identify country-government type combinations whose average GDP
-- growth is above the overall dataset average. Groups with fewer than three
-- observations are excluded.
-- =========================================================================
-- Hypothesis:
-- Finding:
SELECT
    c.country_name,
    gt.government_type,
    ROUND(AVG(cy.gdp_growth), 2) AS avg_gdp_growth,
    COUNT(*) AS observations
FROM country_year AS cy
INNER JOIN countries AS c
    ON cy.country_id = c.country_id
INNER JOIN government_types AS gt
    ON cy.government_type_id = gt.government_type_id
GROUP BY
    c.country_name,
    gt.government_type_id,
    gt.government_type
HAVING
    COUNT(*) >= 3
    AND AVG(cy.gdp_growth) > (
        SELECT AVG(gdp_growth)
        FROM country_year
    )
ORDER BY
    c.country_name,
    gt.government_type_id;