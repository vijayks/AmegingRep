/*
 * To change this tcitylate, choose Tools | Tcitylates
 * and open the tcitylate in the editor.
 */
package com.buysell.util;

import java.util.Comparator;

/**
 *
 * @author bbsadmin
 */
public class CityComparator implements Comparator {

    public int compare(Object city1, Object city2) {
        String city1Name = ((City) city1).getName();
        String city2Name = ((City) city2).getName();
        return city1Name.compareTo(city2Name);
        

    }
}
