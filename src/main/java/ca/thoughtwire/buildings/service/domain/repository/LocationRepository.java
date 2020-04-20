package ca.thoughtwire.buildings.service.domain.repository;

import ca.thoughtwire.buildings.service.domain.Location;

import java.util.Optional;

/**
 * Interface for storing & retrieving Locations
 */
public interface LocationRepository
{
    Optional<Location> findById(String user, String locationId);
}
