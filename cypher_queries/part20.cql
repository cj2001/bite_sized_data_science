CREATE CONSTRAINT airports ON (a:Airport) ASSERT a.id IS UNIQUE;
CREATE CONSTRAINT cities ON (c:City) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT regions ON (r:Region) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT countries ON (c:Country) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT continents ON (c:Continent) ASSERT c.name IS UNIQUE;

// Load airport nodes

WITH 
    'https://raw.githubusercontent.com/cj2001/bite_sized_data_science/main/data/airport-node-list.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (a:Airport {id: row.id})
SET a.iata = row.code,
    a.icao = row.icao,
    a.descr = row.descr,
    a.region = row.region,
    a.runways = row.runways,
    a.longest = row.longest,
    a.elev = row.elev,
    a.country = row.country,
    a.city = row.city,
    a.lat = row.lat,
    a.lon = row.lon

