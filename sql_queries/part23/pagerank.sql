-- This query is based off of the T-SQL shown in Stack Overflow here:
-- https://stackoverflow.com/questions/17787944/sql-pagerank-implementation
-- It has been converted to PostgreSQL syntax.

DROP TABLE node;
DROP TABLE edge;
DROP TABLE outdegree;
DROP TABLE pagerank;
DROP TABLE tmprank;
CREATE TABLE node(id int PRIMARY KEY);
CREATE TABLE edge(src int,dst int, PRIMARY KEY (src, dst));
CREATE TABLE outdegree(id int PRIMARY KEY, degree int);
CREATE TABLE pagerank(id int PRIMARY KEY, rank float);
CREATE TABLE tmprank(id int PRIMARY KEY, rank float);

--delete all records
DELETE FROM node;
DELETE FROM edge;
DELETE FROM outdegree;
DELETE FROM pagerank;
DELETE FROM tmprank;

--init basic tables
INSERT INTO node VALUES (0);
INSERT INTO node VALUES (1);
INSERT INTO node VALUES (2);
INSERT INTO node VALUES (3);

INSERT INTO edge VALUES (0, 1);
INSERT INTO edge VALUES (0, 2);
INSERT INTO edge VALUES (0, 3);
INSERT INTO edge VALUES (1, 0);
INSERT INTO edge VALUES (1, 3);
INSERT INTO edge VALUES (2, 2);
INSERT INTO edge VALUES (3, 1);
INSERT INTO edge VALUES (3, 2);

--compute out-degree
INSERT INTO outdegree
SELECT 
	n.id, COUNT(e.src) --Count(Edge.src) instead of Count(*) for count no out-degree edge
FROM 
	node n
LEFT OUTER JOIN 
	edge e
ON 
	n.id = e.src
GROUP BY n.id;

DO $$
DECLARE
	-- alpha is the damping factor of the PageRank algorithm.
	-- This value was chosen to be identical to the default of GDS.
	alpha float := 0.85;
	node_num int := COUNT(*) FROM node;
BEGIN
	-- Initialize to a starting value of PageRank
    INSERT INTO pagerank
	SELECT 
		n.id, 
		((1-alpha)/node_num) AS rank
	FROM 
		node n
	INNER JOIN 
		outdegree o
	ON 
		n.id = o.id;

		-- Begin iterative updating through PageRank algorithm
	DECLARE
		iteration int := 0;
	BEGIN
		-- The number of iterations here is chosen as the default of GDS
		WHILE iteration < 20 LOOP
			iteration = iteration + 1;

			INSERT INTO tmprank
			SELECT 
				e.dst, 
				(sum(alpha*p.rank/o.degree)+((1-alpha)/node_num)) AS rank
			FROM
				pagerank p
			INNER JOIN
				edge e
			ON
				p.id = e.src
			INNER JOIN
				outdegree o
			ON
				p.id = o.id
			GROUP BY e.dst;

			DELETE FROM pagerank;
			INSERT INTO pagerank
				SELECT * FROM tmprank;
			DELETE FROM tmprank;

		END LOOP;
	END;
END $$;

SELECT * FROM pagerank ORDER BY id;