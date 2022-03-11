// Create a graph projection of all articles in the database,
// with the specified node properties.
CALL gds.graph.create(
    'articles',
    {
        Article: {
            properties: ['colour_group_code', 'section_no', 'garment_group_no', 'graphical_appearance_no']
        }
    },
    '*'
)

// Run KNN and stream the results to the screen.
// Here we are prioritizing `section_no` as the node weight
// that will be used for computing similarity.
CALL gds.beta.knn.stream('articles', {
    topK: 1,
    nodeWeightProperty: 'section_no',
    randomSeed: 42,
    concurrency: 1,
    sampleRate: 1.0,
    deltaThreshold: 0.0
})
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).prod_name AS prod_name1,
       gds.util.asNode(node1).colour_group_name AS color1,
       gds.util.asNode(node1).section_name AS section_name1, 
       gds.util.asNode(node2).prod_name AS prod_name2,
       gds.util.asNode(node2).colour_group_name AS color2,
       gds.util.asNode(node2).section_name AS section_name2, 
       similarity
ORDER BY similarity DESC

// Create a new relationship based on the 10 most similar articles
// to each given article node.
CALL gds.beta.knn.write('articles', {
    writeRelationshipType: 'SIMILAR',
    writeProperty: 'score',
    topK: 10,
    randomSeed: 42,
    concurrency: 1,
    nodeWeightProperty: 'section_no'
})
YIELD nodesCompared, relationshipsWritten

// Explore the similarity results
match (a1:Article)-[:SIMILAR]->(a2) 
RETURN a1, a2 
LIMIT 500