SELECT
    dest,
    COUNT(*) AS in_degree
FROM
    iroutes
GROUP BY
    dest
ORDER BY in_degree DESC;