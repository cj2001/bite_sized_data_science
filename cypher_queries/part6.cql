CREATE CONSTRAINT UniqueCharacterId ON (c:Character) ASSERT c.id IS UNIQUE

// Load node list
WITH 
    'https://raw.githubusercontent.com/mathbeveridge/gameofthrones/master/data/got-s1-nodes.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (c:Character {id: row.Id})
SET c.name = row.Label

// Load relationship list
WITH
    'https://raw.githubusercontent.com/mathbeveridge/gameofthrones/master/data/got-s1-edges.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MATCH (source:Character {id: row.Source})
MATCH (target:Character {id: row.Target})
MERGE (source)-[:SEASON1 {weight: toInteger(row.Weight)}]-(target)

// Large files
:auto USING PERIODIC COMMIT 1000
// ...and then do the rest of your loading...

