// Calculate inDegree
MATCH (a:Airport)
WITH a, SIZE((a)<-[:HAS_ROUTE]-()) AS in_degree
RETURN a.iata, in_degree
ORDER BY in_degree DESC

// Calculate total degree
MATCH (a:Airport)
WITH a, SIZE((a)-[:HAS_ROUTE]-()) AS degree
RETURN a.iata, degree
ORDER BY degree DESC