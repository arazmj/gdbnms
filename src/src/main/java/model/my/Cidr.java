package model.my;

/**
 * Created by Amir Razmjou on 2019-04-04.
 */
public class Cidr {
    private final String IPAddress;
    private final int subnet;

    public Cidr(String IPAddress, int subnet) {
        this.IPAddress = IPAddress;
        this.subnet = subnet;
    }

    public Cidr(String IPAddress) {
        this.subnet = 0;
        this.IPAddress = IPAddress;
    }
}
