import argparse
from neo4j import GraphDatabase
import sys, random

driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))
mobile = 0
client = 0
ip = 0


def rand_mac():
    return "%02x:%02x:%02x:%02x:%02x:%02x" % (
        random.randint(0, 255),
        random.randint(0, 255),
        random.randint(0, 255),
        random.randint(0, 255),
        random.randint(0, 255),
        random.randint(0, 255)
    )


def clear_db(tx):
    tx.run("MATCH (d) "
           "DETACH DELETE d")


def add_friend(tx, name, friend_name):
    tx.run("MERGE (a:Person {name: $name}) "
           "MERGE (a)-[:KNOWS]->(friend:Person {name: 'a' + $friend_name})",
           name=name, friend_name=friend_name)


def print_friends(tx, name):
    for record in tx.run("MATCH (a:Person)-[:KNOWS]->(friend) WHERE a.name = $name "
                         "RETURN friend.name ORDER BY friend.name", name=name):
        print(record["friend.name"])


def exec_file(tx, filename, branch):
    f = open(filename)
    cph = f.read()
    cmds = cph.split(';')
    for cmd in cmds:
        if '$client' in cmd:
            global client
            client += 1
        if '$mobile' in cmd:
            global mobile
            mobile += 1
        if '$ip' in cmd:
            global ip
            ip += 1
        if not cmd.isspace():
            print(cmd)
            tx.run(cmd, branch=branch, mobile=mobile, client=client, mac=rand_mac(), ip=ip)


parser = argparse.ArgumentParser()
parser.add_argument("number", help="number of branches")
parser.add_argument("common", help="global cypher file for networks")
parser.add_argument("branch", help="branch cypher file, will be replicated based on the number specified")
args = parser.parse_args()

with driver.session() as session:
    session.write_transaction(clear_db)
    # global file
    session.write_transaction(exec_file, args.common, 1)

    # branch file
    for x in range(1, int(args.number) + 1):
        session.write_transaction(exec_file, args.branch, x)
