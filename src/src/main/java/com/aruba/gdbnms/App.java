package com.aruba.gdbnms;

import model.my.Cidr;
import model.my.Port;
import model.my.Switch;
import org.neo4j.driver.v1.AuthTokens;
import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import org.neo4j.driver.v1.Session;
import org.neo4j.driver.v1.StatementResult;
import org.neo4j.driver.v1.Transaction;
import org.neo4j.driver.v1.TransactionWork;
import static org.neo4j.driver.v1.Values.parameters;

public class App implements AutoCloseable
{
    private final Driver driver;

    public App( String uri, String user, String password )
    {
        driver = GraphDatabase.driver( uri, AuthTokens.basic( user, password ) );
    }

    @Override
    public void close() throws Exception
    {
        driver.close();
    }

    public void printGreeting( final String message )
    {
        Switch mySwitch = new Switch(new Port[] {
                new Port(new Cidr("10.12.13.14")),
                new Port(new Cidr("11.11.11.11")),
                new Port(new Cidr("192.168.1.1")),
                new Port(new Cidr("127.0.0.1", 24))
        });

        
        try ( Session session = driver.session() )
        {
            String greeting = session.writeTransaction( new TransactionWork<String>()
            {
                @Override
                public String execute( Transaction tx )
                {
                    StatementResult result = tx.run( "CREATE (a:Greeting) " +
                                    "SET a.message = $message " +
                                    "RETURN a.message + ', from node ' + id(a)",
                            parameters( "message", message ) );
                    return result.single().get( 0 ).asString();
                }
            } );
            System.out.println( greeting );
        }
    }

    public static void main( String... args ) throws Exception
    {
        try ( App greeter = new App( "bolt://localhost:7687", "neo4j", "password" ) )
        {
            greeter.printGreeting( "hello, world" );
        }
    }
}
