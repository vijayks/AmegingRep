/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 *
 * @author praveen.ch
 * 17th apr 2008...
 */
public class DBFieldName {

    private static Logger LOG = Logger.getLogger(DBFieldName.class);
    HashMap fnmap;
    HashMap tmap;

    public DBFieldName() {
     
// this hash map is used for to pass the database field name to the dynamic query.
        fnmap = new HashMap();

        fnmap.put("catId","CATEGORY_ID");
        fnmap.put("adType","AD_TYPE");
        fnmap.put("adTitle", "TITLE");
        fnmap.put("description", "DESCRIPTION");
        fnmap.put("country", "COUNTRY");
        fnmap.put("state", "STATE");
        fnmap.put("city", "CITY");
        fnmap.put("area", "AREA");
        fnmap.put("locality", "LOCALITY");
        fnmap.put("adress", "ADDRESS_1");
        fnmap.put("image1", "IMAGE1");
        fnmap.put("KmRun", "KM_RUN"); 
        fnmap.put("condition", "CONDITION");
        fnmap.put("yearsOld", "YEARS");
        fnmap.put("model", "MODEL");
        fnmap.put("regNo", "REGNO");
        fnmap.put("color", "COLOR");
        fnmap.put("ownership", "OWNERSHIP");
        fnmap.put("insurance", "INSURANCE");
        fnmap.put("specialOffer", "SP_OFFER");
        fnmap.put("SOFrom", "OFFER_FROM_DATE");
        fnmap.put("SOTo", "OFFER_TO_DATE");
        fnmap.put("fname", "FIRST_NAME");
        fnmap.put("email", "NOTE");
        fnmap.put("ph1", "PHONE");
        fnmap.put("ph2", "PHONE2");
        fnmap.put("lname", "LAST_NAME");
        fnmap.put("additionalContent", "ADDITIONAL_CONTENT");
        fnmap.put("price", "PRICE");
        fnmap.put("min", "MIN");
        fnmap.put("max", "MAX");
        fnmap.put("neg", "NEGOTIABLE");
        fnmap.put("cfp", "CONTACT_PRICE");
        fnmap.put("", "");
        fnmap.put("", "");
        fnmap.put("", "");






// This hash map is used for to pass datatype of a particular field for dynamic query.
        tmap = new HashMap();

        tmap.put("catId","int");
        tmap.put("adType","str");
        tmap.put("adTitle", "str");
        tmap.put("description", "str");
        tmap.put("country", "str");
        tmap.put("state", "str");
        tmap.put("ciry", "str");
        tmap.put("area", "str");
        tmap.put("locality", "str");
        tmap.put("address", "str");
        tmap.put("image1", "str");

        tmap.put("KmRun", "int");// These fields for auto tile type
        tmap.put("condition", "str");
        tmap.put("yearsOld", "str");
        tmap.put("model", "str");
        tmap.put("regNo", "str");
        tmap.put("color", "str");
        tmap.put("ownership", "str");
        tmap.put("insurance", "str");
        tmap.put("specialOffer", "str");
        tmap.put("SOFrom", "str");
        tmap.put("SOTo", "str");

        tmap.put("fname", "str");
        tmap.put("lname", "str");
        tmap.put("email", "str");
        tmap.put("ph1", "str");
        tmap.put("ph2", "str");


        tmap.put("additionalContent", "str");


        tmap.put("price", "float");
        tmap.put("min", "float");
        tmap.put("max", "float");
        tmap.put("neg", "str");
        tmap.put("cfp", "str");
        

    }

    public String getFieldName(String k) {

        String name = null;
        name = (String) fnmap.get(k);
        return name;
    }

    public String getFieldType(String t) {
        String type = null;
        type = (String) tmap.get(t);
        return type;
    }
}
