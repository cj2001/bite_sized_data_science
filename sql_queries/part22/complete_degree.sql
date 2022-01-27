WITH out_deg AS (
    SELECT
        src,
        COUNT(*) AS out_degree
    FROM
        iroutes
    GROUP BY
        src
),
in_deg AS (
    SELECT
        dest,
        COUNT(*) AS in_degree
    FROM
        iroutes
    GROUP BY
        dest
)
SELECT
    t0.src,
    (t0.out_degree + t1.in_degree) AS degree
FROM
    out_deg t0
INNER JOIN 
    in_deg t1
ON 
    t0.src = t1.dest
ORDER BY degree DESC;