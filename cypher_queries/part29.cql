CALL gds.graph.create(
    'articles',
    '*',
    {PURCHASED: 
        {
            orientation: 'UNDIRECTED',
            properties: 'price'
        }
    }
)

CALL gds.fastRP.write(
  'articles',
  {
    embeddingDimension: 8,
    writeProperty: 'embedding'
  }
)

CALL gds.graph.create(
    'articles_embs',
    {
        Article: {properties: 'embedding'},
        Customer: {properties: 'embedding'}
    },
    '*'
)

CALL gds.beta.knn.write(
    'articles_embs', 
    {
        nodeLabels: ['Article'],
        nodeWeightProperty: 'embedding',
        writeRelationshipType: 'SIMILAR_TO',
        writeProperty: 'score',
        concurrency: 4,
        sampleRate: 1.0,
        maxIterations: 100
    }
)

MATCH (n)-[:SIMILAR_TO]->(m)
RETURN n, m
LIMIT 100