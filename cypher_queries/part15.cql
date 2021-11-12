// Load in nodes
WITH "https://raw.githubusercontent.com/neo4j-graph-analytics/book/master/data/sw-nodes.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:Library {id: row.id}) 

// Load in relationships
WITH "https://raw.githubusercontent.com/neo4j-graph-analytics/book/master/data/sw-relationships.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MATCH (source:Library {id: row.src})
MATCH (destination:Library {id: row.dst})
MERGE (source)-[:DEPENDS_ON]->(destination)

// Create in-memory graph
CALL gds.graph.create('dependencies', '*', '*')

// Run WCC
CALL gds.wcc.stream('dependencies')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).id AS name, componentId
ORDER BY componentId, name

// Check if the results make sense
MATCH (n)--(m) RETURN n, m