import movies.domain.Actor;
import movies.domain.Movie;
import org.neo4j.ogm.config.Configuration;
import org.neo4j.ogm.session.Session;
import org.neo4j.ogm.session.SessionFactory;

/**
 * Created by Amir Razmjou on 2019-04-15.
 */
class Main {
    public static void main(String ... args) {
        Configuration configuration = new Configuration.Builder()
                .uri("bolt://neo4j:password@localhost")
                .build();

        //Set up the Session
        SessionFactory sessionFactory = new SessionFactory(configuration, "movies.domain");
        Session session = sessionFactory.openSession();

        Movie movie = new Movie("The Matrix", 1999);

        Actor keanu = new Actor("Keanu Reeves");
        keanu.actsIn(movie);

        Actor carrie = new Actor("Carrie-Ann Moss");
        carrie.actsIn(movie);

        //Persist the movie. This persists the actors as well.
        session.save(movie);

        //Load a movie
        Movie matrix = session.load(Movie.class, movie.getId());
        for(Actor actor : matrix.getActors()) {
            System.out.println("Actor: " + actor.getName());
        }
    }
}
