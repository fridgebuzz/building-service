package ca.thoughtwire.buildings.service.infrastructure.configuration;

import ca.thoughtwire.buildings.service.domain.repository.LocationRepository;
import ca.thoughtwire.buildings.service.domain.service.LocationService;
import ca.thoughtwire.buildings.service.domain.service.LocationServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class BeanConfiguration
{
    @Bean
    LocationService locationService(LocationRepository locationRepository)
    {
        return new LocationServiceImpl(locationRepository);
    }
}
