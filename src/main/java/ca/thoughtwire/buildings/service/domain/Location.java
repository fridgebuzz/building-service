package ca.thoughtwire.buildings.service.domain;

import java.io.Serializable;
import java.util.Objects;

/**
 * TODO: describe exactly what this class represents
 */
public class Location implements Serializable
{
    public Location() {}

    public Location(String id, String name, String additionalType, PostalAddress address, Person contact,
                    String complex, String image, String timeZone, String rootZone)
    {
        this.id = id;
        this.name = name;
        this.additionalType = additionalType;
        this.address = address;
        this.contact = contact;
        this.complex = complex;
        this.image = image;
        this.timeZone = timeZone;
        this.rootZone = rootZone;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAdditionalType() {
        return additionalType;
    }

    public void setAdditionalType(String additionalType) {
        this.additionalType = additionalType;
    }

    public PostalAddress getAddress() {
        return address;
    }

    public void setAddress(PostalAddress address) {
        this.address = address;
    }

    public Person getContact() {
        return contact;
    }

    public void setContact(Person contact) {
        this.contact = contact;
    }

    public String getComplex() {
        return complex;
    }

    public void setComplex(String complex) {
        this.complex = complex;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTimeZone() {
        return timeZone;
    }

    public void setTimeZone(String timeZone) {
        this.timeZone = timeZone;
    }

    public String getRootZone() {
        return rootZone;
    }

    public void setRootZone(String rootZone) {
        this.rootZone = rootZone;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Location location = (Location) o;
        return id.equals(location.id) &&
                name.equals(location.name) &&
                Objects.equals(additionalType, location.additionalType) &&
                address.equals(location.address) &&
                contact.equals(location.contact) &&
                complex.equals(location.complex) &&
                image.equals(location.image) &&
                timeZone.equals(location.timeZone) &&
                rootZone.equals(location.rootZone);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, additionalType, address, contact, complex, image, timeZone, rootZone);
    }

    @Override
    public String toString() {
        return "Location{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", additionalType='" + additionalType + '\'' +
                ", address=" + address +
                ", contact=" + contact +
                ", complex='" + complex + '\'' +
                ", image='" + image + '\'' +
                ", timeZone='" + timeZone + '\'' +
                ", rootZone='" + rootZone + '\'' +
                '}';
    }

    private String id;
    private String name;
    private String additionalType;
    private PostalAddress address;
    private Person contact;
    private String complex;
    private String image;
    private String timeZone;
    private String rootZone;
}
