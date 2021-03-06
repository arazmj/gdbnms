/*******************************************************************************
 * This file is part of OpenNMS(R).
 *
 * Copyright (C) 2014 The OpenNMS Group, Inc.
 * OpenNMS(R) is Copyright (C) 1999-2014 The OpenNMS Group, Inc.
 *
 * OpenNMS(R) is a registered trademark of The OpenNMS Group, Inc.
 *
 * OpenNMS(R) is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published
 * by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version.
 *
 * OpenNMS(R) is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with OpenNMS(R).  If not, see:
 *      http://www.gnu.org/licenses/
 *
 * For more information contact:
 *     OpenNMS(R) Licensing <license@opennms.org>
 *     http://www.opennms.org/
 *     http://www.opennms.com/
 *******************************************************************************/

package model.opennms.src.main.java.org.opennms.netmgt.model;

import javax.xml.bind.annotation.adapters.XmlAdapter;

import org.opennms.netmgt.model.monitoringLocations.OnmsMonitoringLocation;

public class MonitoringLocationIdAdapter extends XmlAdapter<String, OnmsMonitoringLocation> {

    @Override
    public String marshal(final OnmsMonitoringLocation v) throws Exception {
        return v == null? null : v.getLocationName();
    }

    @Override
    public OnmsMonitoringLocation unmarshal(final String v) throws Exception {
        if (v == null) return null;
        final OnmsMonitoringLocation location = new OnmsMonitoringLocation(v, v);
        return location;
    }

}
