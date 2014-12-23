/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

import com.buysell.util.City;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author srikanth
 */
public class Address implements Serializable{

    List cities;

    public List getCities() {
        return cities;
    }

    public void setCities(List cities) {
        this.cities = cities;
    }
    public void addCity(City c){
        if(cities != null){
            cities.add(c);
        }else {
            cities = new ArrayList();
            cities.add(c);
        }

    }


}
