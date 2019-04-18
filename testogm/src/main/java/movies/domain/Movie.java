package movies.domain;

import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.HashSet;
import java.util.Set;

@NodeEntity
public class Movie {

    @Id
    @GeneratedValue
    private Long id;
    private String title;
    private int released;

    @Relationship(type = "ACTS_IN", direction = "INCOMING")
    Set<Actor> actors = new HashSet<>();

    public Movie() {
    }

    public Movie(String title, int year) {
        this.title = title;
        this.released = year;
    }

    public Set<Actor> getActors() {
        return actors;
    }

    public Long getId() {
        return id;
    }
}
