// BRANCH 1 
// switch
CREATE (:Device {type: 'Switch', name: 'Switch ' + $branch});

//ports
MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 1', MAC: $mac, IP: $branch + '.0.0.' + $ip});

MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 2', MAC: $mac, IP: $branch + '.0.0.' + $ip});

MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 3', MAC: $mac, IP: $branch + '.0.0.' + $ip});

MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 4', MAC: $mac, IP: $branch + '.0.0.' + $ip});

MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 1'})
CREATE (c:Client {name:'Client ' + $client, type:'Client', MAC:$mac})-[:CONNECTED]->(p)
return p, c;

MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 2'})
CREATE (c:Client {name:'Client ' + $client, type:'Client', MAC:$mac})-[:CONNECTED]->(p)
return p, c;

MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 3'})
CREATE (p)-[:CONNECTED]->(:Device {name: 'Access Point ' + $branch, type: 'Access Point', MAC:$mac})
RETURN p;

MATCH (d:Device {name: 'Access Point ' + $branch})
CREATE (c:Client {name:'Mobile Client ' + $mobile, type: 'Client'})-[:CONNECTED]->(d);


// gateway
MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 4'})
CREATE (d:Device {name: 'Gateway ' + $branch, type: 'Gateway', MAC: $mac, IP: $branch + '.0.0.' + $ip})-[:CONNECTED]->(p);

// gateway ports
MATCH (d:Device {name: 'Gateway ' + $branch}), (n:Network {name: 'MPLS 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 1', MAC: $mac, IP: $branch + '.0.0.' + $ip})-[:CONNECTED]->(n);

MATCH (d:Device {name: 'Gateway ' + $branch}), (n:Network {name: 'INET 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 2', MAC: $mac, IP: $branch + '.0.0.' + $ip})-[:CONNECTED]->(n);

MATCH (d:Device {name: 'Gateway ' + $branch}), (n:Network {name: 'LTE 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 3', MAC: $mac, IP: $branch + '.0.0.' + $ip})-[:CONNECTED]->(n);

// create branch
CREATE (s:Site {name: 'Branch ' + $branch, type:'Branch'});

MATCH (d:Device {name: 'Access Point ' + $branch}), (s:Site {name: 'Branch ' + $branch})
CREATE (d)-[:BELONGS_TO]->(s);

MATCH (d:Device {name: 'Gateway ' + $branch}), (s:Site {name: 'Branch ' + $branch})
CREATE (d)-[:BELONGS_TO]->(s);

MATCH (d:Device {name: 'Switch ' + $branch}), (s:Site {name: 'Branch ' + $branch})
CREATE (d)-[:BELONGS_TO]->(s);
