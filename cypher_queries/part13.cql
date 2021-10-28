// Start by creating an in-memory, unweighted graph with a native projection
CALL gds.graph.create(
    'interactions',
    'Person',
    {INTERACTS: 
        {
            orientation: 'UNDIRECTED'
        }
    }
)

// Run PageRank on an unweighted graph
CALL gds.pageRank.stream('interactions')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC, name ASC
LIMIT 10

// Create a weighted in-memory graph, this type with a Cypher projection
CALL gds.graph.create.cypher(
    'weighted-interactions',
    'MATCH (p:Person) RETURN id(p) AS id',
    'MATCH (p1:Person)-[r:INTERACTS]->(p2:Person) RETURN id(p1) AS source, id(p2) AS target, r.weight AS weight'
)

// Run PageRank on a weighted graph
CALL gds.pageRank.stream('weighted-interactions')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC
LIMIT 10

// Run Betweenness Centrality on a unweighted graph
CALL gds.betweenness.stream('interactions')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC
LIMIT 10

// Run Degree Centrality on weighted graph
CALL gds.degree.stream('weighted-interactions')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY score DESC
LIMIT 10
