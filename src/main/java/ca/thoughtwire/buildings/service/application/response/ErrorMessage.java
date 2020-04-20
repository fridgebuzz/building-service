package ca.thoughtwire.buildings.service.application.response;

import java.io.Serializable;

public class ErrorMessage implements Serializable
{
    public ErrorMessage() {}

    public ErrorMessage(String message)
    {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    private String message;
}
