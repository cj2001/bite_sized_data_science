# Bite-Sized Neo4j for Data Scientists
### Written by: Dr. Clair J. Sullivan, Data Science Advocate, Neo4j
#### email: clair.sullivan@neo4j.com
#### Twitter: @CJLovesData1
#### Last updated: April 13, 2022

All notebooks can be found in `notebooks/`.
Some videos are strictly based on Cypher querys, which can be found in `cypher/`.

## THIS SERIES IS ON HIATUS FOR A WHILE!!!

Stay tuned to the Neo4j YouTube channel for new episodes coming soon!

### Note:
The notebooks in this repository are not meant to be stand-alone and thus are not commented.  They go with the videos.  So you are encouraged to watch the videos and then consult the notebooks should you will to look at the actual code in depth.

## Videos

### :sparkles: :sparkles: Find this video series as its [own webpage](https://neo4j.com/video/bite-sized-neo4j-for-data-scientists/) on the Neo4j webpage!!! :sparkles: :sparkles:

### [Complete YouTube playlist of full series](https://dev.neo4j.com/bite_sized_playlist)

[Part 1: Connect from Jupyter to a Neo4j Sandbox](https://dev.neo4j.com/bites_part1)

[Part 2: Using the py2neo Python Driver](https://dev.neo4j.com/bites_part2)

[Part 3: Using the Neo4j Python Driver](https://dev.neo4j.com/bites_part3)

[Part 4: Basic Cypher Queries (and with Google Colab)](https://dev.neo4j.com/bites_part4)
  - This video uses a Google Colab notebook, which can be found [here](https://dev.neo4j.com/bites_part4_notebook)

[Part 5: Populating the Database from Pandas](https://dev.neo4j.com/bites_part5)
  - This video refers to a YouTube video on how to create efficient Cypher queries, which is linked in the references below.

[Part 6: Populating the Database with LOAD CSV](https://dev.neo4j.com/bites_part6)
  - This video references [this GitHub repo](https://github.com/mathbeveridge/gameofthrones) that has the data used in this part.

[Part 7: Populating the Database with the neo4j-admin tool](https://dev.neo4j.com/bites_part7)
  - This video works from the command line using Docker.  The shell commands are provided in GitHub gists, which can be found [here](https://gist.github.com/cj2001/9321ff16672921e1c197b67336f97f19).
  - The data for this part can be found in `data/` (the files are `got-s1-nodes.csv` and `got-s1-edges.csv`).

[Part 8: Populating the Database from a JSON file](https://dev.neo4j.com/bites_part8)
  - This video references a JSON file I created for my NODES 2021 tutorial, "Creating a Knowledge Graph with Neo4j: A Simple Machine Learning Approach."
    - [Repository for the workshop](https://dev.neo4j.com/nodes2021_kg_workshop): Contains the JSON file
      - I have also put this file in the `data/` directory of this repository, but the Cypher query I used in the video (`cypher_queries/part8.cql`) uses the workshop repo.
    - [Video of the workshop](https://dev.neo4j.com/kg_workshop)

[Part 9: Cypher Queries 2](https://dev.neo4j.com/bites_part9)

[Part 10: Creating In-Memory Graphs with Cypher Projections](https://dev.neo4j.com/bites_part10)

[Part 11: Import RDF Data from Wikidata](https://dev.neo4j.com/bites_part11)
  - To query Wikidata, it is helpful to know how to use SPARQL.  The query builder that I showed (which has several great example queries) can be found [here](https://query.wikidata.org/).  Wikidata also provides a good [SPARQL tutorial](https://www.wikidata.org/wiki/Wikidata:SPARQL_tutorial).
  - This video shows the use of Neosemantics for importing the RDF data.  See below in the References for docs on how to use it.
  - This video also shows _very_ quickly demonstrates Neo4j Bloom for visualization and queries.  For an in-depth look at how to use Bloom, see [this video](https://dev.neo4j.com/3p6q7IP).

[Part 12: Creating In-Memory Graphs with Native Projections](https://dev.neo4j.com/bites_part12)
  - This is the sister video for Part 10, which explored the other method for creating in-memory graphs.

[Part 13: Calculating Centrality](https://dev.neo4j.com/bites_part13)

[Part 14: Community Detection with the Louvain Method](https://dev.neo4j.com/bites_part14)

[Part 15: Community Detection via Weakly Connected Components](https://dev.neo4j.com/bites_part15)

[Part 16: Using Strongly Connected Components to Detect Communities](https://dev.neo4j.com/bites_part16)

[Part 17: Creating FastRP Graph Embeddings](https://dev.neo4j.com/bites_part17)
  - For more information on how FastRP works, see the following blog posts:
    - [Behind the scenes on the Fast Random Projection algorithm for generating graph embeddings](https://dev.neo4j.com/fastrp_background)
    - [Making FastRP Graph Embeddings Work for You](https://dev.neo4j.com/frp_tuning)

[Part 18: Putting Graph Embeddings into a Machine Learning Model](https://dev.neo4j.com/bites_part18)
  - This video moves quickly!  It will be important to read [this blog post](https://dev.neo4j.com/frp_tuning), particularly for understanding how to get the embeddings into a format for the machine learning model.

[Part 19: Starting with a SQL table...](https://dev.neo4j.com/bites_part19)
  - This video is the start of a series looking at why we might want to go from SQL to a graph database
  - It is based off of the graph data that can be found in [here](https://github.com/krlawrence/graph)
  - I use PostgreSQL for my demonstrations, but you can use your SQL of choice
  - All queries to populate your database are in `./sql_queries/part19`

[Part 20: ...And compare it to a graph... (2/n)](https://dev.neo4j.com/bites_part20)
  - This video builds off of Part 19, using the same data imported into Neo4j
  - To create the CSV files used for this graph, I exported each of the tables in Part 19 directly from Postgres via pgAdmin
    - I made some tweaks of the headers to get them into Neo4j via `LOAD CSV` easily
    - The data files can be found in `./data`

[Part 21: An example of when querying a graph can be easier than SQL (3/n)](https://dev.neo4j.com/bites_part21)
  - This video builds off of Parts 19 and 20 of this series
  - If you do not already have a Neo4j database populated with this data, follow the instructions in Part 20 or run the script `./cypher_queries/part20.cql` to populate the database

[Part 22: A side-by-side calculation of degree using SQL and Neo4j (4/n)](https://dev.neo4j.com/bites_part22)
  - This video builds off of Parts 19-21 of this series
  - If you do not already have a SQL database populated with this data, use the queries in `./sql_queries/part19/`
  - If you do not already have a Neo4j database populated with this data, follow the instructions in Part 20 or run the script `./cypher_queries/part20.cql` to populate the database

[Part 23: PageRank done two ways (5/n)](https://dev.neo4j.com/bites_part23)
  - This video builds off of Parts 19-22 of this series
  - We will be using a very simplistic graph for this demonstration
  - The PageRank SQL query was taken from [this Stack Overflow post](https://stackoverflow.com/questions/17787944/sql-pagerank-implementation), which was originally written for T-SQL and has been modified in this repo to work in PostgreSQL

[Page 24: Why graphs? (6/6)](https://dev.neo4j.com/bites_part24)
  - This video builds off of Parts 19-23 of this series
  - This is the final video in the mini series-within-a-series for the SQL vs. Neo4j comparisons

[Part 25: Creating a graph for a Kaggle competition](https://dev.neo4j.com/bites_part25)
  - This video is based off of the [H&M Personalized Fashion Recommendations Kaggle competition](https://www.kaggle.com/c/h-and-m-personalized-fashion-recommendations/overview)
  - The original data can be found and downloaded from the Kaggle public API via their CLI tool, assuming you have a Kaggle account
    - For information on how to use the Kaggle public API, see [this article](https://www.kaggle.com/docs/api)

[Part 26: Creating a graph model of the Kaggle competition (2/n)](https://dev.neo4j.com/bites_part26)
  - This video is based off of Part 25, which uses the [H&M Personalized Fashion Recommendations Kaggle competition](https://www.kaggle.com/c/h-and-m-personalized-fashion-recommendations/overview)
  - There is no code used in this part
  - If you would like to make an image of a graph model for yourself, check out [arrows.app](https://arrows.app/)

[Part 27: Node similarity of Kaggle competition graph (3/n)](https://dev.neo4j.com/bites_part27)
  - This video is based off of Parts 25 and 26, which uses the [H&M Personalized Fashion Recommendations Kaggle competition](https://www.kaggle.com/c/h-and-m-personalized-fashion-recommendations/overview)
  - If you need a refresher on how to create an in-memory graph projection as is done in this video, please consult [Part 12](https://dev.neo4j.com/bites_part12)

[Part 28: Using KNN to identify similar items of Kaggle competition graph (4/n)](https://dev.neo4j.com/bites_part28)
  - This video is based off of Parts 25-27
  - If you need a refresher on how to create an in-memory graph projection as is done in this video, please consult [Part 12](https://dev.neo4j.com/bites_part12)
  - In this video we will do some very basic feature engineering to explore the [K-Nearest Neighbors](https://neo4j.com/docs/graph-data-science/current/algorithms/knn/) for each article of clothing to obtain similar articles
  - (The next video will also do KNN, but using some much more sophisticated features!)

[Part 29: Using KNN with more sophisticated feature vectors (5/n)](https://dev.neo4j.com/bites_part29)
  - This video is based off of Parts 25-28

[Part 30: Introducing GDS 2.0!](https://dev.neo4j.com/bites_part30)
  - This video just scrapes the surface of all of the new offerings within GDS 2.0, but focuses on the new [GDS Python Client](https://dev.neo4j.com/python_gds)

## References

- [O'Reilly Graph Algorithm Examples in Apache Spark & Neo4j Book](https://dev.neo4j.com/graph_algorithms_book)
- [The Neo4j Cheat Sheet and Quick Reference](https://dev.neo4j.com/neo4j_cheatsheet)
- [Neo4j Cypher Reference Card](https://neo4j.com/docs/cypher-refcard/current/)
- [Advanced Cypher Query Tuning (video)](https://youtu.be/xPSKqm4hFRc)
- [Awesome Procedures on Cypher (APOC) User Guide](https://neo4j.com/labs/apoc/4.1/)
- [Graph Data Science Library API Docs](https://dev.neo4j.com/graph_data_science)
- [Neosemantics Docs](https://neo4j.com/labs/neosemantics/)
- [Bloom Docs](https://neo4j.com/docs/bloom-user-guide/current/)
