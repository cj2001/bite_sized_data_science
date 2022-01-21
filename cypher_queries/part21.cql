// Inspect the graph schema to make sure we have everything in there correctly
CALL db.schema.visualization()

// Find all airports within 2 hops of Denver (DEN)
MATCH (den:Airport {iata: 'DEN'})-[:HAS_ROUTE*1..2]->(a:Airport) 
WHERE a.iata <> 'DEN' 
RETURN DISTINCT(a.iata)
ORDER BY a.iata