// Create some nodes
CREATE (n1:Node {id: 'n1'}),
    (n2:Node {id: 'n2'}),
    (n3:Node {id: 'n3'}),
    (n4:Node {id: 'n4'}),
    (n5:Node {id: 'n5'}),
    (n6:Node {id: 'n6'}),
    (n7:Node {id: 'n7'}),

    (n1)-[:CONNECTS]->(n2),
    (n2)-[:CONNECTS]->(n1),
    (n2)-[:CONNECTS]->(n3),
    (n3)-[:CONNECTS]->(n2),
    (n3)-[:CONNECTS]->(n1),
    (n1)-[:CONNECTS]->(n3),
    (n1)-[:CONNECTS]->(n4),
    (n4)-[:CONNECTS]->(n1),
    (n1)-[:CONNECTS]->(n5),
    (n5)-[:CONNECTS]->(n6),
    (n5)-[:CONNECTS]->(n7),
    (n6)-[:CONNECTS]->(n7),
    (n7)-[:CONNECTS]->(n6)

// Look at the graph
MATCH (n) RETURN n

// Create in-memory graph
CALL gds.graph.create('my_graph', '*', '*')

// Calculated strongly connected components
CALL gds.alpha.scc.stream('my_graph')
YIELD nodeId, componentId
RETURN gds.util.asNode(nodeId).id AS id, componentId
ORDER BY componentId, id
