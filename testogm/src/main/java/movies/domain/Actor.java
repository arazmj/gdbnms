package movies.domain;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.HashSet;
import java.util.Set;

@NodeEntity
public class Actor {

    @Id @GeneratedValue
    private Long id;
    private String name;

    @Relationship(type = "ACTS_IN", direction = "OUTGOING")
    private Set<Movie> movies = new HashSet<>();

    public Actor() {
    }

    public Actor(String name) {
        this.name = name;
    }

    public void actsIn(Movie movie) {
        movies.add(movie);
        movie.getActors().add(this);
    }

    public String getName() {
        return name;
    }
}

