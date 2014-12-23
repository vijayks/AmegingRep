/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author bbsadmin
 */
public class BodyResultBean implements Serializable{
    private ArrayList results=null;

    public ArrayList getResults() {
        return results;
    }

    public void setResults(ArrayList results) {
        this.results = results;
    }


}
