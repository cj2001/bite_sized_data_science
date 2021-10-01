// Visualize the schema of the database
CALL db.schema.visualization

// Identify people nodes within 2-3 hops of a region node
MATCH (p:Person)-[*2..3]->(r:Region) RETURN p.name, r.name

// Calculate inDegree of each person node
MATCH (p:Person) 
RETURN p.name, SIZE(()-[]->(p)) AS inDegree
ORDER BY inDegree DESC

// Write inDegree as a property to each person node
MATCH (p:Person) 
SET p.inDegree = SIZE(()-[]->(p))
RETURN p.name, p.inDegree
ORDER BY p.inDegree DESC

// Calculate outDegree of each person node
MATCH (p:Person) 
RETURN p.name, SIZE((p)-[]->()) AS outDegree
ORDER BY outDegree DESC

// Using a path, find the shortest path between two nodes
MATCH p=shortestPath( (:Person {name: "Eddard Stark"})-[*]-(:Person {name: "Vance"}) ) RETURN p




