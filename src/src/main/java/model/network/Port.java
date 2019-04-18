package model.network;

import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;

/**
 * Created by Amir Razmjou on 2019-04-04.
 */
@NodeEntity
public class Port {
    @Id
    @GeneratedValue
    private Long id;
    private String name;


    private String ip;

    public Port() {}

    public Port(String name) {
        this.name = name;
    }

    public Port(String name, String ip) {
        this.name = name;
        this.ip = ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getName() {
        return name;
    }
}
