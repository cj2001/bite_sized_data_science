MATCH (n) RETURN COUNT(n) AS count

MATCH (p1:Person)-[r]->(p2:Person) RETURN p1, r, p2 LIMIT 10

MATCH (p1:Person)-[r]->(p2:Person) RETURN p1.name, r.weight, p2.name LIMIT 10

MATCH (p1:Person)-[r:INTERACTS]->(p2:Person) 
WHERE p1.name = 'Catelyn Stark'
RETURN p1.name AS p1_name, r.weight AS weight, p2.name AS p2_name LIMIT 10

MATCH (k:Knight)-[:DEFENDER_COMMANDER]->(b:Battle)<-[:ATTACKER_KING]-(d:Dead)
    WHERE d:King
    RETURN k.name, b.name, d.name
    LIMIT 10

MATCH (p1:Person)-[*1..3]->(p2:Person) RETURN p1.name, p2.name LIMIT 10

MATCH (k:King)-[*1..4]->(h:House) RETURN k.name, h.name LIMIT 10