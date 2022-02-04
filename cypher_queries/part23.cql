// Create basic graph
CREATE (n0:Node {name: 'n0'}),
	(n1:Node {name: 'n1'}),
	(n2:Node {name: 'n2'}),
	(n3:Node {name: 'n3'}),
	(n0)-[:CONNECTS]->(n1),
    (n0)-[:CONNECTS]->(n2),
    (n0)-[:CONNECTS]->(n3),
    (n1)-[:CONNECTS]->(n0),
    (n1)-[:CONNECTS]->(n3),
    (n2)-[:CONNECTS]->(n2),
    (n3)-[:CONNECTS]->(n1),
    (n3)-[:CONNECTS]->(n2)

// View the graph
MATCH (n) RETURN n

// Create graph projection
CALL gds.graph.create('test', '*', '*')

// Run PageRank
CALL gds.pageRank.stream('test', {scaler: 'L1Norm'})
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).name AS name, score
ORDER BY name