// Create natural directed graph
CALL gds.graph.create(
    'purchases',                     
    ['Article', 'Customer'],                       
    {                                         
        PURCHASED: { properties: "price" }   
    }
)

// Node similarity of customers
CALL gds.nodeSimilarity.stream('purchases',
	{ 
    	degreeCutoff: 5
    }
)
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).customer_id AS CustomerId1,
	gds.util.asNode(node1).age AS CustomerAge1,
    gds.util.asNode(node2).customer_id AS ArticleId2,
    gds.util.asNode(node2).age AS CustomerAge2,
	similarity
ORDER BY similarity DESCENDING
LIMIT 10

// Compare most similar customers
MATCH (c:Customer)-->(a:Article)
WHERE c.customer_id = "2452f252d9ddded26c848008d7af7cf9b92af4ea5c6284a0c5d9cd2567325e74"
OR c.customer_id = "d396b64b7786922528517f3a6a7cf6fcdfe8b139e1cbb5ffd821f4ada741d3b9"
RETURN c, a

// Create reverse-directed graph
CALL gds.graph.create(
    'purchases-rev',                     
    ['Article', 'Customer'],                       
    {                                         
        PURCHASED: { properties: "price", orientation: "REVERSE" }   
    }
)

// Node similarity of articles
CALL gds.nodeSimilarity.stream('purchases-rev',
	{ 
    	degreeCutoff: 5, 
        similarityCutoff: 0.5
    }
)
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).prod_name AS ProductName1,
	gds.util.asNode(node1).garment_group_name AS GroupName1,
 	gds.util.asNode(node2).prod_name AS ProductName2,
    gds.util.asNode(node2).garment_group_name AS GroupName2,
	similarity
ORDER BY similarity DESC

// Evaluate other purchases of similar items
MATCH (a1:Article {prod_name: "Don Vito tie tanga"})<--(c:Customer)-->(a2:Article)
RETURN a1.prod_name, a1.department_name, a1.colour_group_name, 
	   a2.prod_name, a2.department_name, a2.colour_group_name


