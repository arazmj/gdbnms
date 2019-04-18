package model.network;

import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.Relationship;

import java.util.*;

/**
 * Created by Amir Razmjou on 2019-04-04.
 */
public class Switch {
    @Id
    @GeneratedValue
    private Long id;
    private String name;

    @Relationship(type = "HAS", direction = "OUTGOING")
    Set<Port> ports = new HashSet<>();

    public Switch() {
    }

    public Switch(String name) {
        this.name = name;
    }

    public void addPort(Port port) {
        ports.add(port);
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Set<Port> getPorts() {
        return ports;
    }
}
