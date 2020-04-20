package ca.thoughtwire.buildings.service.domain.service;

import ca.thoughtwire.buildings.service.domain.Location;
import ca.thoughtwire.buildings.service.domain.repository.LocationRepository;
import mockit.Expectations;
import mockit.Mocked;
import mockit.Verifications;
import mockit.integration.junit4.JMockit;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import java.util.Optional;

@RunWith(JMockit.class)
public class LocationServiceImplTest {

    @Before
    public void setUp() throws Exception
    {
        tested = new LocationServiceImpl(locationRepository);
    }

    @Test
    public void findLocationSucceeds()
    {
        new Expectations()
        {
            {
                locationRepository.findById(TEST_USER, TEST_LOCATION);
                Location loc = new Location();
                loc.setId("abc");
                result = Optional.of(loc);
            }
        };

        tested.getLocationById(TEST_USER, TEST_LOCATION);

        new Verifications()
        {
            {
                locationRepository.findById(TEST_USER, TEST_LOCATION);
                times = 1;
            }
        };

    }

    @After
    public void tearDown() throws Exception
    {
    }

    @Mocked
    private LocationRepository locationRepository;

    private LocationService tested;

    public static final String TEST_USER = "test-user";
    public static final String TEST_LOCATION = "location_1";

}