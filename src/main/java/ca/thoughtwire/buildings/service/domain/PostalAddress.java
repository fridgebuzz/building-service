package ca.thoughtwire.buildings.service.domain;

import java.util.Objects;

/**
 * TODO: describe exactly what this class represents
 */
public class PostalAddress
{
    public PostalAddress() {}

    public PostalAddress(String streetAddress, String addressLocality, String addressRegion, String postalCode,
                         String email, String telephone) {
        this.streetAddress = streetAddress;
        this.addressLocality = addressLocality;
        this.addressRegion = addressRegion;
        this.postalCode = postalCode;
        this.email = email;
        this.telephone = telephone;
    }

    public String getStreetAddress() {
        return streetAddress;
    }

    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    public String getAddressLocality() {
        return addressLocality;
    }

    public void setAddressLocality(String addressLocality) {
        this.addressLocality = addressLocality;
    }

    public String getAddressRegion() {
        return addressRegion;
    }

    public void setAddressRegion(String addressRegion) {
        this.addressRegion = addressRegion;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PostalAddress that = (PostalAddress) o;
        return streetAddress.equals(that.streetAddress) &&
                Objects.equals(addressLocality, that.addressLocality) &&
                Objects.equals(addressRegion, that.addressRegion) &&
                Objects.equals(postalCode, that.postalCode) &&
                Objects.equals(email, that.email) &&
                telephone.equals(that.telephone);
    }

    @Override
    public int hashCode() {
        return Objects.hash(streetAddress, addressLocality, addressRegion, postalCode, email, telephone);
    }

    @Override
    public String toString() {
        return "PostalAddress{" +
                "streetAddress='" + streetAddress + '\'' +
                ", addressLocality='" + addressLocality + '\'' +
                ", addressRegion='" + addressRegion + '\'' +
                ", postalCode='" + postalCode + '\'' +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                '}';
    }

    private String streetAddress;
    private String addressLocality;
    private String addressRegion;
    private String postalCode;
    private String email;
    private String telephone;
}
