package com.amirrazmjou.gdbnms;

import model.network.Port;
import model.network.Switch;
import org.neo4j.ogm.config.Configuration;
import org.neo4j.ogm.cypher.ComparisonOperator;
import org.neo4j.ogm.cypher.Filter;
import org.neo4j.ogm.session.Session;
import org.neo4j.ogm.session.SessionFactory;

import java.util.Collection;

/**
 * Created by Amir Razmjou on 2019-04-16.
 */
public class AppOGMDriver {

    public static void main(String ... args) {
        Configuration configuration = new Configuration.Builder()
                .uri("bolt://neo4j:password@localhost")
                .build();

        //Set up the Session
        SessionFactory sessionFactory = new SessionFactory(configuration,
                "model.network");

        Session session = sessionFactory.openSession();

        Collection<Switch> switches = session.loadAll(Switch.class, new Filter("name",
                ComparisonO perator.EQUALS, "Switch 1"));

        for (Switch s: switches) {
            System.out.println(s.getName());
        }

        sessionFactory.close();
    }
    public static void main1(String ... args) {
        Configuration configuration = new Configuration.Builder()
                .uri("bolt://neo4j:password@localhost")
                .build();

        //Set up the Session
        SessionFactory sessionFactory = new SessionFactory(configuration,
                "model.network");
        Session session = sessionFactory.openSession();

        Switch mySwitch = new Switch("My Switch 1");
        Port port = new Port("Port 1", "192.168.1.1");
        mySwitch.addPort(port);

        session.save(mySwitch);

        Switch savedSwitch = session.load(Switch.class, mySwitch.getId());
        Collection<Switch> switches = session.loadAll(Switch.class, new Filter("name",
                ComparisonOperator.EQUALS, "My Switch 1"));

        for (Switch s: switches) {
            System.out.println(s.getName());
        }
        System.out.println(mySwitch.getId());
        System.out.println(savedSwitch.getName());
        for (Port p: savedSwitch.getPorts())
            System.out.println(p.getName());

        sessionFactory.close();

//
    }
}
