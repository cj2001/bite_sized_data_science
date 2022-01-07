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