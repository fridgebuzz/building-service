package ca.thoughtwire.buildings.service.application.request;

import java.io.Serializable;

public class LocationRequest implements Serializable
{
    public LocationRequest() {}

    public LocationRequest(String user, String location) {
        this.user = user;
        this.location = location;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    private String user;
    private String location;
}
