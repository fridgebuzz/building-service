package ca.thoughtwire.buildings.service.domain.service;

import ca.thoughtwire.buildings.service.domain.Location;

public interface LocationService
{
    Location getLocationById(String user, String locationId);
}
