package ca.thoughtwire.buildings.service.infrastructure.repository;

import ca.thoughtwire.buildings.service.domain.Location;
import ca.thoughtwire.buildings.service.domain.Person;
import ca.thoughtwire.buildings.service.domain.PostalAddress;
import ca.thoughtwire.buildings.service.domain.repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

@Component
public class JdbcLocationRepository implements LocationRepository
{
    @Autowired
    public JdbcLocationRepository(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Optional<Location> findById(String user, String locationId) {
        try {
            return Optional.ofNullable(jdbcTemplate.queryForObject(FIND_QUERY, new Object[]{user, locationId},
                    new LocationMapper()));
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    private class LocationMapper implements RowMapper<Location> {

        @Override
        public Location mapRow(ResultSet resultSet, int i) throws SQLException {
            String id = resultSet.getString("id");
            String image = resultSet.getString("image");
            String complex = resultSet.getString("complex");
            String name = resultSet.getString("name");
            String timeZone = resultSet.getString("timezone");
            String streetAddress = resultSet.getString("street_address");
            String telephone = resultSet.getString("telephone");
            String addressLocality = resultSet.getString("address_locality");
            String contactName = resultSet.getString("contact_name");
            String rootZone = resultSet.getString("root_zone");

            PostalAddress postalAddress = new PostalAddress();
            postalAddress.setStreetAddress(streetAddress);
            postalAddress.setAddressLocality(addressLocality);
            postalAddress.setTelephone(telephone);

            Person person = new Person();
            person.setName(contactName);

            Location location = new Location();
            location.setAddress(postalAddress);
            location.setComplex(complex);
            location.setContact(person);
            location.setId(id);
            location.setImage(image);
            location.setName(name);
            location.setRootZone(rootZone);
            location.setTimeZone(timeZone);

            return location;
        }
    }

    private JdbcTemplate jdbcTemplate;

    private static final String FIND_QUERY =
            "SELECT DISTINCT id, image, complex, name, timezone, street_address, telephone, address_locality, contact_name, root_zone FROM locations INNER JOIN group_to_location  ON (id = location) INNER JOIN user_to_group USING (\"group\") WHERE \"user\" =  ? AND id = ?";
}
