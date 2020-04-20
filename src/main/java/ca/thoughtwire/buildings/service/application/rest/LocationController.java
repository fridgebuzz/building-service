package ca.thoughtwire.buildings.service.application.rest;

import ca.thoughtwire.buildings.service.application.request.LocationRequest;
import ca.thoughtwire.buildings.service.application.response.ErrorMessage;
import ca.thoughtwire.buildings.service.application.response.LocationResponse;
import ca.thoughtwire.buildings.service.domain.Location;
import ca.thoughtwire.buildings.service.domain.service.LocationNotFoundException;
import ca.thoughtwire.buildings.service.domain.service.LocationService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/locations")
public class LocationController
{
    public LocationController(LocationService locationService)
    {
        this.locationService = locationService;
    }

    @PostMapping
    public LocationResponse getLocationById(@RequestBody LocationRequest locationRequest)
    {
        Location location = locationService.getLocationById(locationRequest.getUser(), locationRequest.getLocation());
        return new LocationResponse(location.getId(), location.getName());
    }

    @GetMapping("/{locationId}")
    public LocationResponse getLocationById(@RequestHeader String user, @PathVariable String locationId)
    {
        Location location = locationService.getLocationById(user, locationId);
        return new LocationResponse(location.getId(), location.getName());
    }

    @ExceptionHandler (LocationNotFoundException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody ErrorMessage handleException(
            Exception e, HttpServletRequest request, HttpServletResponse response) {
         return new ErrorMessage(e.getMessage());
    }

    private LocationService locationService;
}
