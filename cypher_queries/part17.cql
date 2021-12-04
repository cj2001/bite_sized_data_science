// Visualize the graph schema
CALL db.schema.visualization

// Create an in-memory graph
CALL gds.graph.create(
    'officers',
    ['Officer', 'Intermediary', 'Entity'],
    {
        OFFICER_OF: {
            orientation: 'UNDIRECTED'
        }
    }
)

// Stream FastRP embeddings to the screen
CALL gds.fastRP.stream(
    'officers',
    {
        embeddingDimension: 10,
        iterationWeights: [0.0, 0.0, 1.0],  // Could also do [0.0, 0.0, 1.0, 1.0, ...etc.]
        normalizationStrength: -0.5,
        randomSeed: 42
    }
)
YIELD nodeId, embedding
RETURN gds.util.asNode(nodeId).name AS name, embedding
LIMIT 10