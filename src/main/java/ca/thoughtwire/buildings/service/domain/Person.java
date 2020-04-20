package ca.thoughtwire.buildings.service.domain;

import java.io.Serializable;
import java.util.Objects;

/**
 * TODO: describe exactly what this class represents
 */
public class Person implements Serializable
{
    public Person () {}

    public Person(String id, String name, String givenName, String familyName) {
        this.id = id;
        this.name = name;
        this.givenName = givenName;
        this.familyName = familyName;
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

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return id.equals(person.id) &&
                name.equals(person.name) &&
                givenName.equals(person.givenName) &&
                familyName.equals(person.familyName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, givenName, familyName);
    }

    @Override
    public String toString() {
        return "Person{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", givenName='" + givenName + '\'' +
                ", familyName='" + familyName + '\'' +
                '}';
    }

    private String id;
    private String name;
    private String givenName;
    private String familyName;
}
