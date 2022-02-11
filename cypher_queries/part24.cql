// Find all airports in California (region: US-CA).
// Then find all airports within the United Kingdom that are within
// 2 hops of those California aiports.  
// Return those results ordered by decreasing PageRank.

MATCH (src:Airport)-[:IN_REGION]->(r:Region {name: 'US-CA'})
WITH src
MATCH (src)-[:HAS_ROUTE*1..2]->(dest)-[:IN_COUNTRY]->(c:Country {name: 'United Kingdom'})
RETURN DISTINCT dest
ORDER BY dest.pagerank DESC