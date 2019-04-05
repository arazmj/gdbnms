package model.my;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Amir Razmjou on 2019-04-04.
 */
public class Port {
    List<Cidr> cidrList;

    public Port(Cidr[] cidrList) {
        this.cidrList = Arrays.asList(cidrList);
    }

    public Port(Cidr cidr) {
        this.cidrList = new ArrayList<>();
        this.cidrList.add(cidr);
    }
}
