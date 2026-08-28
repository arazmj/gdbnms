// GLOBAL
// networks
CREATE (mpls:Network {name: 'MPLS 1', type:'MPLS'});

CREATE (inet:Network {name: 'INET 1', type:'INET'});

CREATE (lte:Network {name: 'LTE 1', type:'LTE'});

// sites
CREATE (dc:Site {name:'Data Center 1', type:'Data Center' });

CREATE (aws:Site {name:'AWS', type:'Cloud Provider' });

MATCH (aws:Site {name: 'AWS'}), (inet:Network {name: 'INET 1'})
CREATE (aws)-[:CONNECTED {created: $created}]->(inet);

MATCH (aws:Site {name: 'AWS'}), (lte:Network {name: 'LTE 1'})
CREATE (aws)-[:CONNECTED {created: $created}]->(lte);

MATCH (dc:Site {name: 'Data Center 1'}), (mpls:Network {name: 'MPLS 1'})
CREATE (dc)-[:CONNECTED {created: $created}]->(mpls);

