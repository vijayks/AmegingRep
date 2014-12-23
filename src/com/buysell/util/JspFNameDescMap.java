/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

import java.util.HashMap;

/**
 *
 * @author bbsadmin
 */
public class JspFNameDescMap {


   static HashMap hm ;
    static{

        hm = new HashMap(60);
        hm.put("ath", " <b>Author</b> ");
        hm.put("nm", " <b>Name</b> ");
        hm.put("price", "<b>Price</b>");
        hm.put("ptype", " <b>Pet Type</b> ");
        hm.put("mod", " <b>Model</b> ");
        hm.put("clr", " <b>Colour</b> ");
        hm.put("typ", " <b>Type </b>");
//        hm.put("yso", " <b>Years</b> ");
        hm.put("are", " <b> Area</b> ");
        hm.put("nbr", " <b> No of Bed Rooms </b> ");
      
        hm.put("fnd", " <b> Furnished </b> ");
        hm.put("fc", " <b> Facing </b> ");
        hm.put("tfl", " <b> Total Floors</b> ");
        hm.put("qlf", " <b> Qualification </b> ");
        hm.put("pub", " <b> Publication </b> ");
        hm.put("bd", " <b> Breed </b> ");
        hm.put("obj", " <b> Objects </b> ");
        hm.put("mtr", " <b> Material </b> ");
        hm.put("brnd", " <b> Brand </b> ");
    
    


    }

    public HashMap getJspFieldDescMap()
    {
        return hm;
    }

    public String getDescToJspField(String jspFieldName){
        return (String)hm.get(jspFieldName);
    }
}
