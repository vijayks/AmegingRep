/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author bbsadmin
 */
public class CategoryResultBean implements Serializable
{
    private List results=null;

    public List getResults() {
        return results;
    }

    public void setResults(List results) {
        this.results = results;
    }
    public String toString()
    {
        return "this is CategoryResultBean reference";
    }
    

}
