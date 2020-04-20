package ca.thoughtwire.buildings.service.domain.service;

public class LocationNotFoundException extends RuntimeException
{
    public LocationNotFoundException(String locationId)
    {
        super(generateMessgae(locationId));
        this.locationId = locationId;
    }

    public static String generateMessgae(String locationId)
    {
        return String.format(MESSAGE_FORMAT, locationId);
    }

    public String getLocationId() {
        return locationId;
    }

    private final String locationId;

    private static final String MESSAGE_FORMAT = "Location not found: %s";
}
