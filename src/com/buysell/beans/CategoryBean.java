/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author bbsadmin
 */
public class CategoryBean implements Serializable
{

   private String  CATEGORY_ID=null;
    private String  CATEGORY_NAME=null;
    private String  DESCRIPTION=null;

    public String getCATEGORY_ID() {
        return CATEGORY_ID;
    }

    public void setCATEGORY_ID(String CATEGORY_ID) {
        this.CATEGORY_ID = CATEGORY_ID;
    }

    public String getCATEGORY_NAME() {
        return CATEGORY_NAME;
    }

    public void setCATEGORY_NAME(String CATEGORY_NAME) {
        this.CATEGORY_NAME = CATEGORY_NAME;
    }

    public String getDESCRIPTION() {
        return DESCRIPTION;
    }

    public void setDESCRIPTION(String DESCRIPTION) {
        this.DESCRIPTION = DESCRIPTION;
    }



    public String toString()
    {
        return "this is CategoryResultBean reference";
    }
    

}
