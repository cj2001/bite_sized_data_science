// View the graph

MATCH (n) RETURN n

// Create in-memory graph of all people and their interactions with all other people

CALL gds.graph.create.cypher(
  'people',
  'MATCH (n:Person) RETURN id(n) AS id',
  'MATCH (n:Person)-[]->(m:Person) RETURN id(n) AS source, id(m) AS target')

// Create a weighted in-memory graph

CALL gds.graph.create.cypher(
  'people-weighted',
  'MATCH (n:Person) RETURN id(n) AS id',
  'MATCH (n:Person)-[r:INTERACTS]->(m:Person) RETURN id(n) AS source, id(m) AS target, r.weight AS weight')

// Return back the graph

CALL gds.graph.streamRelationshipProperty('people-weighted', 'weight')
YIELD sourceNodeId, targetNodeId, propertyValue AS weight
RETURN
  gds.util.asNode(sourceNodeId).name AS person1,
  gds.util.asNode(targetNodeId).name AS person2,
  weight
ORDER BY weight DESC

// Multigraphs

CALL gds.graph.create.cypher(
  'interactions',
  'MATCH (n) WHERE n:Person OR n:King RETURN id(n) AS id',
  'MATCH (n)-[r:INTERACTS_1|INTERACTS_5]->(m) RETURN id(n) AS source, id(m) AS target, r.weight AS weight')

// List in-memory graphs

CALL gds.graph.list()

// Drop in-memory graphs

CALL gds.graph.drop('interactions')