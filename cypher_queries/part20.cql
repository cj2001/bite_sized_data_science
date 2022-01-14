////////////////////////////////////
//
// Bite-Sized Neo4j for Data Scientists
// Part 20 query
//
// This query sets up the airport route graph to be used in this example
// and several subsequent examples to appear in future videos.
//
////////////////////////////////////

// Create some constraints for query efficiency
CREATE CONSTRAINT airports ON (a:Airport) ASSERT a.iata IS UNIQUE;
CREATE CONSTRAINT cities ON (c:City) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT regions ON (r:Region) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT countries ON (c:Country) ASSERT c.code IS UNIQUE;
CREATE CONSTRAINT continents ON (c:Continent) ASSERT c.code IS UNIQUE;

// Load airport nodes
WITH 
    'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/airport-node-list.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (a:Airport {iata: row.iata})
SET a.id = row.id,
    a.icao = row.icao,
    a.city = row.city,
    a.descr = row.descr,
    a.region = row.region,
    a.runways = toInteger(row.runways),
    a.longest = toInteger(row.longest),
    a.altitude = toInteger(row.altitude),
    a.country = row.country,
    a.continent = row.continent,
    a.lat = toFloat(row.lat),
    a.lon = toFloat(row.lon);

// Load country nodes
WITH 
    'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/country-node-list.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (c:Country {code: row.code})
SET c.descr = row.descr;

// Load continent nodes
WITH 
    'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/continent-node-list.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (c:Continent {code: row.code})
SET c.descr = row.descr;

// Create relationships from IATA codes (in iroutes-edges.csv)
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/iroutes-edges.csv' AS row
MATCH (source:Airport {iata: row.src})
MATCH (target:Airport {iata: row.dest})
MERGE (source)-[r:HAS_ROUTE]->(target)
ON CREATE SET r.distance = toInteger(row.dist);

// Create city nodes and relationships
MATCH (a:Airport)
MERGE (c:City {name: a.city})
MERGE (a)-[:IN_CITY]->(c);

// Create region nodes and relationships
MATCH (a:Airport)
MERGE (r:Region {name: a.region})
MERGE (a)-[:IN_REGION]->(r);

// Create country relationships for airports
MATCH (a:Airport)
MATCH (c:Country {code: a.country})
MERGE (a)-[:IN_COUNTRY]->(c);

// Create country relationships for cities
MATCH (a:Airport)
MATCH (ci:City {name: a.city})
MATCH (co:Country {code: a.country})
MERGE (ci)-[:IN_COUNTRY]->(co);

// Create country relationships for region
MATCH (a:Airport)
MATCH (r:Region {name: a.region})
MATCH (co:Country {code: a.country})
MERGE (r)-[:IN_COUNTRY]->(co);

// Create continent relationships for airports
MATCH (a:Airport)
MATCH (c:Continent {code: a.continent})
MERGE (a)-[:ON_CONTINENT]->(c);

// Create continent relationships for cities
MATCH (a:Airport)
MATCH (ci:City {name: a.city})
MATCH (co:Continent {code: a.continent})
MERGE (ci)-[:ON_CONTINENT]->(co);

// Create continent relationships for regions
MATCH (a:Airport)
MATCH (r:Region {name: a.region})
MATCH (co:Continent {code: a.continent})
MERGE (r)-[:ON_CONTINENT]->(co);

// Create continent relationships for countries
MATCH (a:Airport)
MATCH (c:Country {code: a.country})
MATCH (co:Continent {code: a.continent})
MERGE (c)-[:ON_CONTINENT]->(co);

// Confirm the schema looks correct
CALL db.schema.visualization();