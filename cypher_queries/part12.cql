// Basic in-memory graph (undirected) of (:Person)-[:INTERACTS]-(:Person)
CALL gds.graph.create(
    'interactions',
    'Person',
    'INTERACTS'
)

// Create the same as above but make it directed
CALL gds.graph.create(
    'interactions-directed',
    'Person',
    {INTERACTS: 
        {
            orientation: 'UNDIRECTED'
        }
    }
)

// Add edge weights
CALL gds.graph.create(
    'weighted-interactions',
    'Person',
    {INTERACTS: 
        {
            properties: 'weight'
        }
    }
)

// Create the same as above but make it with multiple nodes
CALL gds.graph.create(
    'people-houses',
    ['Person', 'House'],
    'BELONGS_TO'
)

// Confirm the above ran correctly
MATCH (p:Person)-[r:BELONGS_TO]->(h:House) RETURN COUNT(r)

// Super fancy: multiple types of nodes and relationships with weights and orientations
CALL gds.graph.create(
    'fancy-graph',
    ['Person', 'House'],
    {
        INTERACTS: 
        {
            orientation: 'UNDIRECTED',
            properties: 'weight'
        },
        BELONGS_TO: 
        {
            orientation: 'NATURAL'
        }
    }
)

// Clean up!
CALL gds.graph.list();
CALL gds.graph.drop('interactions');

// etc.



