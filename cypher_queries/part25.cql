// Visualize the database schema
CALL db.schema.visualization()

// Visualize a small portion of the graph
MATCH (n)--(m) RETURN n, m LIMIT 100
