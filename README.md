## Graph Databases and Network Management Systems

The goal of this project is to review graph databases for network management systems applications, a graph database is a database that uses graph structures for semantic queries with nodes, edges and properties to represent and store data. The relationships allow data in the store to be linked together directly, and in many cases retrieved with one operation. Graph databases hold the relationships between data as a priority. Querying relationships within a graph database is fast because they are perpetually stored within the database itself. Relationships can be intuitively visualized using graph databases, making it useful for network management systems working heavily inter-connected network data. Relationships are not first-class citizens in the RDBMS technology. Graph Database are very strong in highly related data. Even though there are many relationships in the graph database the graph database remain very performant during the retrival of the data even with millions of the nodes. The graph database is very flexible because it does not use a fixed schema for the nodes. Nodes and properties can contain properties.

| Relational | Document-Based | Graph |
|------------|----------------|-------|
| Tables     |   Documents    | Nodes |
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
Nodes: Client, Access Point, Switch.

-The case about VLAN, if the two nodes are connected to a switch that does not imply that those Nodes are L2 connected.

- LLDP (link layer discovery protocol)
In order to get LLDP for Switch 1 this query can be issued:
```
MATCH (s:Device {name: 'Switch 1'})--(p:Port)--(d:Device)
RETURN p AS Port, d as DestinationDevice
```
![Model](img/LLDPSubGraph.png)

The LLDP result for a "Simple two branch deployment" is:
![Model](img/LLDPResult.png)


- Single branch Deployment:
![Model](img/Example%20SD-WAN%20Deployment.png)

![Model](img/NSXModel.png)

### Graph Model
- Lables:
	- Client: 
	- Branch
	- Switch
	- Access Point
	- Port
	- Network

- Single branch Deployment:
![Model](img/SingleBranchDeployment.png)

- Simple two branch deployment:
![Model](img/SimpleNeo4JGraph.png)

- Simple 10 branch deployment
![Model](img/SimpleBranch10Deployments.png)

### How to use create_branch.py?
The tool create_branch.py automaticaly creates a network toplogy based on the number of branches specified. Two cypher files will be needed to create the network toplogy. The common or global cypher file is the file that will be executed only once and it creates global networks and data centers and etc. The branch cypher file will be executed as many as the number is specified the tool will automatically assign new ip addresses and MAC addresses to the toplogy. 

```
usage: create_branch.py [-h] number common branch

positional arguments:
  number      number of branches
  common      global cypher file for networks
  branch      branch cypher file, will be replicated based on the number
              specified

optional arguments:
  -h, --help  show this help message and exit
```

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

### Known Issues
|Issue | Severity |
|----|-----|
| Integer property values cannot be assigned to nodes or edges | Low |

### Migration Plan 
Migration Plan from Elastic Search 

### Realtime Notifications


### Timeline
- 12/4/2019: Added python scripts to automaticaly generate graph based on the number of branches and set MAC address and IP numbers automaticaly. 
- 15/4/2019: Updated images.
