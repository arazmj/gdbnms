CREATE (:Device {type: 'Switch', name: 'Switch 1'})

MATCH (d:Device)
CREATE (d)-[:HAS]->(:Port {name: 'Port 1'})


MATCH (d:Device)
CREATE (d)-[:HAS]->(:Port {name: 'Port 2'})


MATCH (d:Device)
CREATE (d)-[:HAS]->(:Port {name: 'Port 3'})


MATCH (d:Device)
CREATE (d)-[:HAS]->(:Port {name: 'Port 4'})


MATCH (p:Port)
WHERE p.name = 'Port 1'
CREATE (c:Client {name:'Client 1', type:'Mobile'})-[:CONNECTED]->(p)
RETURN p

MATCH (p:Port)
WHERE p.name = 'Port 2'
CREATE (c:Client {name:'Client 2', type:'Mobile'})-[:CONNECTED]->(p)
RETURN p

MATCH (p:Port)
WHERE p.name = 'Port 3'
CREATE (p)-[:CONNECTED]->(:Device {name: 'Access Point 1', Type: 'Access Point'})

MATCH (d:Device)
WHERE d.name = 'Access Point 1'
CREATE (c:Client {name:'Mobile Client 1', type:'Mobile'})-[:CONNECTED]->(d)
RETURN p

MATCH (d:Device)
WHERE d.name = 'Switch 1'
CREATE (d)-[:CONNECTED]->(:Network {name: 'MPLS 1', type:'MPLS'})

MATCH (d:Device)
WHERE d.name = 'Switch 1'
CREATE (d)-[:CONNECTED]->(:Network {name: 'INET 1', type:'INET'})

MATCH (d:Device)
WHERE d.name = 'Switch 1'
CREATE (d)-[:CONNECTED]->(:Network {name: 'LTE 1', type:'LTE'})

MATCH (d:Device)
CREATE (d)-[:BELONGS_TO]->(s:Site {name: 'Branch 1', type: 'Branch'})
RETURN d, s

CREATE (s:Site {name: 'Branch 1', type:'Branch'})

MATCH (d:Device), (s:Site)
CREATE (d)-[:BELONGS_TO]->(s)


