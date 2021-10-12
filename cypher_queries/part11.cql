// Initialize Neosemantics
CALL n10s.graphconfig.init({handleVocabUris: "IGNORE"})

// Set constraints
CREATE CONSTRAINT resource IF NOT EXISTS ON (r:Resource) ASSERT r.uri IS UNIQUE

// Preliminary graph inspection
WITH 'PREFIX sch: <http://schema.org/> 
CONSTRUCT{ ?item a sch:Brewery; 
            sch:name ?breweryName; 
            sch:location ?location.            	
            ?location a sch:City; 
           	sch:name ?cityName  } 
WHERE { ?item wdt:P31/wdt:P279* wd:Q131734 .
        ?item wdt:P17 wd:Q183 .
        ?item rdfs:label ?breweryName .
        ?item wdt:P131 ?location .
        ?location rdfs:label ?cityName 
        filter(lang(?cityName)="en")     
      }' AS sparql
CALL n10s.rdf.preview.fetch(
  "https://query.wikidata.org/sparql?query=" +
     apoc.text.urlencode(sparql),"JSON-LD",
  { headerParams: { Accept: "application/ld+json"}} )
YIELD nodes, relationships
RETURN nodes, relationships

// Populate the actual database
WITH 'PREFIX sch: <http://schema.org/> 
CONSTRUCT{ ?item a sch:Brewery; 
            sch:name ?breweryName; 
            sch:location ?location.            	
            ?location a sch:City; 
           	sch:name ?cityName  } 
WHERE { ?item wdt:P31/wdt:P279* wd:Q131734 .
        ?item wdt:P17 wd:Q183 .
        ?item rdfs:label ?breweryName .
        ?item wdt:P131 ?location .
        ?location rdfs:label ?cityName 
        filter(lang(?cityName)="en")     
      }' AS sparql
CALL n10s.rdf.import.fetch(
  "https://query.wikidata.org/sparql?query=" +
     apoc.text.urlencode(sparql),"JSON-LD",
  { headerParams: { Accept: "application/ld+json"}} )
YIELD terminationStatus, triplesLoaded
RETURN terminationStatus, triplesLoaded