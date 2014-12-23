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
public class BodySubBean implements Serializable{

    private int subCat;

    public int  getSubCat() {
        return subCat;
    }

    public void setSubCat(int subCat) {
        this.subCat = subCat;
    }
    
}
