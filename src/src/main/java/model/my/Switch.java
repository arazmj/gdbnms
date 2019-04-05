package model.my;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Amir Razmjou on 2019-04-04.
 */
public class Switch {
    List<Port> ports;

    public Switch(Port[] ports) {
        this.ports = Arrays.asList(ports);
    }

    public Switch() {
        this.ports = new ArrayList<>();
    }

    public void addPort(Port port) {
        ports.add(port);
    }
}
