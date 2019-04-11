## Graph Databases and Network Management Systems

The goal of this project is to review graph databases for network management systems applications, a graph database is a database that uses graph structures for semantic queries with nodes, edges and properties to represent and store data. The relationships allow data in the store to be linked together directly, and in many cases retrieved with one operation. Graph databases hold the relationships between data as a priority. Querying relationships within a graph database is fast because they are perpetually stored within the database itself. Relationships can be intuitively visualized using graph databases, making it useful for network management systems working heavily inter-connected network data. Relationships are not first-class citizens in the RDBMS technology. Graph Database are very strong in highly related data. Even though there are many relationships in the graph database the graph database remain very performant during the retrival of the data even with millions of the nodes. The graph database is very flexible because it does not use a fixed schema for the nodes. Nodes and properties can contain properties.

| Relational | Document-Based | Graph |
|------|-------|----|
| Tables |Documents | Nodes  |
| Schemas with nullables | No Schemas | No Schemas  |
| Relations with foreign keys | Relations with foreign keys | Relation is first class citizen |
| Related data is fetched with joins | Related data is fetched with joins  | Related data is fetched with patterns |

The purpose for this review is find the best graph database technology and the supporting case scenarios to use the database to store and retrieve network topology data.

This research covers:

- What are the best graph database candidates?
- Query Language 
- What is the sample network toplogy data that base our work upon?
- Which one of common Networking Object Models to use?
- How to use Object Graph Mappers?
- How do we track changes topological changes

### Case Scenarios

- How many ElasticSearch Nodes currently are being used?
- What is typical number of node and edges in the worst case scenario.
- What type of edges and nodes we have for SDWAN scenario. 
Example of graph edges: Wired Connection, Wireless, MPLS Connection, VPN Connection, Aggregated Link
Nodes: Client, Access Point, Switch

### Graph Model
Simple two branch deployment:
![Model](https://raw.githubusercontent.com/arazmj/gdbnms/master/img/SimpleNeo4JGraph.png)

1. Lables:
-

### Graph database candidates
- [GraphDB Lite](http://graphdb.ontotext.com). GraphDB Lite is a free RDF triplestore that allows to store up to 100 million triples on a desktop
computer. This version of GraphDB can be easily deployed using JAVA. SPARQL 1.1 queries are performed in memory, not using files based indices. Reasoning operations for inferencing are supported in GraphDB Lite
Query language: SPARQL

- [Neo4j Community Edition](https://neo4j.com). Neo4j is an open-source graph database, implemented in Java described as embedded, disk-based,
fully transactional Java persistence engine that stores data structured in graphs rather than in tables
Query language: Cypher

- [OrientDB Community Edition](https://orientdb.com). 
Neo4j is an open-source graph database, implemented in Java described as embedded, disk-based,
fully transactional Java persistence engine that stores data structured in graphs rather than in tables
	- Query language: SQL

- [Graph Engine](https://www.graphengine.io) Graph Engine (GE) is a distributed, in-memory, large graph processing engine, underpinned by a
strongly-typed RAM store and a general computation engine. The distributed RAM store provides a globally addressable high-performance key-value store over a cluster of machines. Through the RAM store, GE enables the fast random data access power over a large distributed data set.
	- Query language: RESTfull

- [HyperGraphDB](http://www.hypergraphdb.org) HyperGraphDB is a general purpose, open-source data storage mechanism based on a powerful
knowledge management formalism known as directed hypergraphs designed mostly for knowledge management, AI and semantic web projects, it can also be used as an embedded object-oriented database for Java projects of all sizes.
	- Query language: HyperGraphDB Query API

- [MapGraph](https://github.com/stuartsierra/mapgraph)
MapGraph API makes it easy to develop high performance graph analytics on GPUs. The API is
based on the Gather-Apply-Scatter (GAS) model as used in GraphLab. To deliver high performance computation and efficiently utilize the high memory bandwidth of GPUs, MapGraph's CUDA kernels use multiple sophisticated strategies, such as vertex-degree-dependent dynamic parallelism granularity and frontier compaction.
	- Query language 

- [ArangoDB](https://www.arangodb.com)
ArangoDB is a distributed free and open-source database with a flexible data model for documents,
graphs, and key-values. Build high performance applications using a convenient SQL-like query language or JavaScript extensions.
	- Query language 

- [Titan](http://titan.thinkaurelius.com) ArangoDB is a distributed free and open-source database with a flexible data model for documents,
graphs, and key-values. Build high performance applications using a convenient SQL-like query language or JavaScript extensions.
	- Query language 


### Sample network toplogy
### Common object models
#### OpenNMS

### Migration Plan 
Migration Plan from Elastic Search 

### Realtime Notifications

