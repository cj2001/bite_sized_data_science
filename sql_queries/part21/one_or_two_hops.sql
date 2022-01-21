-- Get all airports withing 1 *OR* 2 connections of Denver, CO (DEN)
WITH target AS (
    SELECT
        dest
    FROM
        iroutes
    WHERE
        src = 'DEN'
),
two_hops AS (
	SELECT
		DISTINCT(i.dest)
	FROM
		iroutes i
	WHERE
		i.src IN (SELECT * FROM target)
),
both_hops AS (
	SELECT 
		a.dest 
	FROM 
		target a
	UNION ALL
	SELECT 
		b.dest 
	FROM 
		two_hops b
)
SELECT
	DISTINCT(dest)
FROM
	both_hops
WHERE
	dest != 'DEN'
ORDER BY
	dest
;