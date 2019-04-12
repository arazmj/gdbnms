from neo4j import GraphDatabase
import sys

driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))


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

def exec_file(tx, filename):
    f = open(filename)
    cph = f.read()
    tx.run(cph)


with driver.session() as session:
    session.write_transaction(clear_db)
    session.write_transaction(exec_file, sys.argv[1])
    session.write_transaction(add_friend, "Arthur", "Guinevere")
    session.write_transaction(add_friend, "Arthur", "Lancelot")
    session.write_transaction(add_friend, "Arthur", "Merlin")
    session.read_transaction(print_friends, "Arthur")
