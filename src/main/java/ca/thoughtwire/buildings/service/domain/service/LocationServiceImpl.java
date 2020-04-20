package ca.thoughtwire.buildings.service.domain.service;

import ca.thoughtwire.buildings.service.domain.Location;
import ca.thoughtwire.buildings.service.domain.repository.LocationRepository;

public class LocationServiceImpl implements LocationService
{
    public LocationServiceImpl(LocationRepository locationRepository)
    {
        this.locationRepository = locationRepository;
    }

    public Location getLocationById(String user, String locationId)
    {
        return locationRepository
                .findById(user, locationId)
                .orElseThrow(() -> new LocationNotFoundException(locationId));
    }

    private final LocationRepository locationRepository;

}
