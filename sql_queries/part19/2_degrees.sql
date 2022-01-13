SELECT * FROM airports LIMIT 1;

SELECT * FROM iroutes LIMIT 5;

-- Find all of the airports within exactly 2 connections of Denver, CO (DEN)
WITH target AS (
    SELECT
        dest
    FROM
        iroutes
    WHERE
        src = 'DEN'
)
SELECT
    DISTINCT(i.dest), a.city
FROM
    iroutes i
JOIN
    airports a
ON
    i.dest = a.iata
WHERE
    i.src IN (SELECT * FROM target)

ORDER BY
    dest
;

-- Count the number of airports within exactly 2 connections of Denver, CO (DEN)
WITH target AS (
    SELECT
        dest
    FROM
        iroutes
    WHERE
        src = 'DEN'
)
SELECT
    COUNT(DISTINCT(i.dest))
FROM
    iroutes i
WHERE
    i.src IN (SELECT * FROM target)
;