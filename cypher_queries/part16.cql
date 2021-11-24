// Create some nodes

CREATE (n1:Node {id: 'n1'})
CREATE (n2:Node {id: 'n2'})
CREATE (n3:Node {id: 'n3'})
CREATE (n4:Node {id: 'n4'})
CREATE (n5:Node {id: 'n5'})
CREATE (n6:Node {id: 'n6'})
CREATE (n7:Node {id: 'n7'})

// Create some relationships

CREATE (n1)-[:CONNECTS]->(n2)
CREATE (n2)-[:CONNECTS]->(n1)
CREATE (n2)-[:CONNECTS]->(n3)
CREATE (n3)-[:CONNECTS]->(n2)
CREATE (n3)-[:CONNECTS]->(n1)
CREATE (n1)-[:CONNECTS]->(n3)
CREATE (n1)-[:CONNECTS]->(n4)
CREATE (n4)-[:CONNECTS]->(n1)
CREATE (n1)-[:CONNECTS]->(n5)
CREATE (n5)-[:CONNECTS]->(n6)
CREATE (n5)-[:CONNECTS]->(n7)
CREATE (n6)-[:CONNECTS]->(n7)
CREATE (n7)-[:CONNECTS]->(n6)

// Look at the graph
MATCH (n) RETURN n

// Create in-memory graph
CALL gds.graph.create('my_graph', '*', '*')

// Calculated strongly connected components
CALL gds.alpha.scc.stream('my_graph')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).id AS id, componentId
ORDER BY componentId, id
