MATCH (d)
DETACH DELETE d;

// GLOBAL
// networks
CREATE (mpls:Network {name: 'MPLS 1', type:'MPLS'});

CREATE (inet:Network {name: 'INET 1', type:'INET'});

CREATE (lte:Network {name: 'LTE 1', type:'LTE'});

// sites
CREATE (dc:Site {name:'Data Center 1', type:'Data Center' });

CREATE (aws:Site {name:'AWS', type:'Cloud Provider' });

MATCH (aws:Site {name: 'AWS'}), (inet:Network {name: 'INET 1'})
CREATE (aws)-[:CONNECTED]->(inet);

MATCH (aws:Site {name: 'AWS'}), (lte:Network {name: 'LTE 1'})
CREATE (aws)-[:CONNECTED]->(lte);

MATCH (dc:Site {name: 'Data Center 1'}), (mpls:Network {name: 'MPLS 1'})
CREATE (dc)-[:CONNECTED]->(mpls);

// BRANCH 1 
// switch
CREATE (:Device {type: 'Switch', name: 'Switch 1'});

//ports
MATCH (d:Device {name: 'Switch 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 1', MAC: '00:00:00:00:00', IP: '192.168.0.1'});

MATCH (d:Device {name: 'Switch 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 2', MAC: '00:00:00:00:00', IP: '192.168.0.1'});

MATCH (d:Device {name: 'Switch 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 3', MAC: '00:00:00:00:00', IP: '192.168.0.1'});

MATCH (d:Device {name: 'Switch 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 4', MAC: '00:00:00:00:00', IP: '192.168.0.1'});

MATCH (:Device {name: 'Switch 1'})-[:HAS]->(p:Port {name: 'Port 1'})
CREATE (c:Client {name:'Client 1', type:'Mobile', MAC:'00:00:00:00:00'})-[:CONNECTED]->(p)
return p, c;

MATCH (:Device {name: 'Switch 1'})-[:HAS]->(p:Port {name: 'Port 2'})
CREATE (c:Client {name:'Client 2', type:'Mobile', MAC:'00:00:00:00:00'})-[:CONNECTED]->(p)
return p, c;

MATCH (:Device {name: 'Switch 1'})-[:HAS]->(p:Port {name: 'Port 3'})
CREATE (p)-[:CONNECTED]->(:Device {name: 'Access Point 1', type: 'Access Point', MAC:'00:00:00:00:00'})
RETURN p;

MATCH (d:Device {name: 'Access Point 1'})
CREATE (c:Client {name:'Mobile Client 1', type: 'Mobile'})-[:CONNECTED]->(d);


// gateway
MATCH (:Device {name: 'Switch 1'})-[:HAS]->(p:Port {name: 'Port 4'})
CREATE (d:Device {name: 'Gateway 1', type: 'Gateway', MAC: '00:00:00:00:00', IP: '192.168.0.1'})-[:CONNECTED]->(p);

// gateway ports
MATCH (d:Device {name: 'Gateway 1'}), (n:Network {name: 'MPLS 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 1', MAC: '00:00:00:00:00', IP: '192.168.0.1'})-[:CONNECTED]->(n);

MATCH (d:Device {name: 'Gateway 1'}), (n:Network {name: 'INET 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 2', MAC: '00:00:00:00:00', IP: '192.168.0.1'})-[:CONNECTED]->(n);

MATCH (d:Device {name: 'Gateway 1'}), (n:Network {name: 'LTE 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 3', MAC: '00:00:00:00:00', IP: '192.168.0.1'})-[:CONNECTED]->(n);

// create branch
CREATE (s:Site {name: 'Branch 1', type:'Branch'});

MATCH (d:Device {name: 'Access Point 1'}), (s:Site {name: 'Branch 1'})
CREATE (d)-[:BELONGS_TO]->(s);

MATCH (d:Device {name: 'Gateway 1'}), (s:Site {name: 'Branch 1'})
CREATE (d)-[:BELONGS_TO]->(s);

MATCH (d:Device {name: 'Switch 1'}), (s:Site {name: 'Branch 1'})
CREATE (d)-[:BELONGS_TO]->(s);
