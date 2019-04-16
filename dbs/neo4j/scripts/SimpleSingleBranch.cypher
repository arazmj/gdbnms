// BRANCH 1 
// switch
CREATE (:Device {type: 'Switch', name: 'Switch ' + $branch, chassisType: 'Network Address', chassisId: $mac, sysName: 'Switch', sysDescr: 'Switch Reversion 0.13'});

//ports
MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 1', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 1, localPort: 'A1'});

MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 2', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 2, localPort: 'A2'});

MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 3', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 3, localPort: 'A3'});

MATCH (d:Device {name: 'Switch ' + $branch})
CREATE (d)-[:HAS]->(:Port {name: 'Port 4', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 4, localPort: 'A4'});

MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 1'})
CREATE (c:Client {name:'Client ' + $client, type:'Client', mac:$mac})-[:CONNECTED]->(p)
return p, c;

MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 2'})
CREATE (c:Client {name:'Client ' + $client, type:'Client', mac:$mac})-[:CONNECTED]->(p)
return p, c;

MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 3'})
CREATE (p)-[:CONNECTED]->(:Device {name: 'Access Point ' + $branch, type: 'Access Point', mac:$mac})
RETURN p;

MATCH (d:Device {name: 'Access Point ' + $branch})
CREATE (c:Client {name:'Mobile Client ' + $mobile, type: 'Client'})-[:CONNECTED]->(d);


// gateway
MATCH (:Device {name: 'Switch ' + $branch})-[:HAS]->(p:Port {name: 'Port 4'})
CREATE (d:Device {name: 'Gateway ' + $branch, type: 'Gateway', mac: $mac, ip: $branch + '.0.0.' + $ip, chassisType: 'Network Address', chassisId: $mac, sysName: 'Gateway', sysDescr: 'Gateway Reversion 0.12'})-[:CONNECTED]->(p);

// gateway ports
MATCH (d:Device {name: 'Gateway ' + $branch}), (n:Network {name: 'MPLS 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 1', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 1, localPort: 'B1'})-[:CONNECTED]->(n);

MATCH (d:Device {name: 'Gateway ' + $branch}), (n:Network {name: 'INET 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 2', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 2, localPort: 'B2'})-[:CONNECTED]->(n);

MATCH (d:Device {name: 'Gateway ' + $branch}), (n:Network {name: 'LTE 1'})
CREATE (d)-[:HAS]->(:Port {name: 'Port 3', mac: $mac, ip: $branch + '.0.0.' + $ip, portIndex: 3, localPort: 'B3'})-[:CONNECTED]->(n);

// create branch
CREATE (s:Site {name: 'Branch ' + $branch, type:'Branch'});

MATCH (d:Device {name: 'Access Point ' + $branch}), (s:Site {name: 'Branch ' + $branch})
CREATE (d)-[:BELONGS_TO]->(s);

MATCH (d:Device {name: 'Gateway ' + $branch}), (s:Site {name: 'Branch ' + $branch})
CREATE (d)-[:BELONGS_TO]->(s);

MATCH (d:Device {name: 'Switch ' + $branch}), (s:Site {name: 'Branch ' + $branch})
CREATE (d)-[:BELONGS_TO]->(s);
