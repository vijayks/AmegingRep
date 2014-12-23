package com.buysell.util;

import java.io.Serializable;
import java.util.ArrayList;

public class City implements Serializable{

    String name;
    String location;
    String area;
    String pincode;
    String country;
    String state;
    ArrayList loc;
    String readyState;

    public String getReadyState() {
        return readyState;
    }

    public void setReadyState(String readyState) {
        this.readyState = readyState;
    }


    public ArrayList getLoc() {
        return loc;
    }

    public void setLoc(ArrayList loc) {
        this.loc = loc;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPincode() {
        return pincode;
    }

    public void setPincode(String pincode) {
        this.pincode = pincode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    
}

  