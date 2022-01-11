CREATE CONSTRAINT airports ON (a:Airport) ASSERT a.id IS UNIQUE;
CREATE CONSTRAINT cities ON (c:City) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT regions ON (r:Region) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT countries ON (c:Country) ASSERT c.code IS UNIQUE;
CREATE CONSTRAINT continents ON (c:Continent) ASSERT c.code IS UNIQUE;

// Load airport nodes
WITH 
    'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/airport-node-list.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (a:Airport {id: row.id})
SET a.iata = row.iata,
    a.icao = row.icao,
    a.city = row.city,
    a.descr = row.descr,
    a.region = row.region,
    a.runways = row.runways,
    a.longest = row.longest,
    a.altitude = row.altitude,
    a.country = row.country,
    a.continent = row.continent,
    a.lat = row.lat,
    a.lon = row.lon;

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
:auto USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/iroutes-edges.csv'
    AS row
MATCH (source:Airport {iata: row.src})
MATCH (target:Airport {iata: row.dest})
MERGE (source)-[:HAS_ROUTE {distance: toInteger(row.dist)}]->(target);

// The above only works on a blank GDS sandbox.  The normal ones times out.
// Can the above be recreated with apoc.periodic.iterate?

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

// Create country relationships for region
MATCH (a:Airport)
MATCH (r:Region {name: a.region})
MATCH (co:Country {code: a.country})
MERGE (r)-[:IN_COUNTRY]->(co);
