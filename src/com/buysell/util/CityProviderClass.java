/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.io.File;
import com.buysell.util.CityUtil;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class CityProviderClass {

    public static ArrayList cities;
     private static Logger LOG = Logger.getLogger(CityProviderClass.class);

    public  CityProviderClass() {
        CityUtil cu = new CityUtil();

        File countryRootDir = new File(BuySellProperties.getProperty("countryLocation"));
        String countries[] = countryRootDir.list();

        if (countries != null && countries.length > 0) {
            for (int j = 0; j < countries.length; j++) {
                String cut = countries[j];
                File states = new File(BuySellProperties.getProperty("countryLocation") + cut + "/");
                String sa[] = states.list();
                if (sa != null) {
                    for (int i = 0; i < sa.length; i++) {
                        List lcs = cu.viewAllCities(cut, sa[i]);
                        if (lcs != null && lcs.size() > 0) {
                            for (Iterator it = lcs.iterator(); it.hasNext();) {
                                City c = (City) it.next();
                                c.setCountry(cut);
                                c.setState(sa[i]);
                                cities.add(c);
                                LOG.info("cities="+c);
                            }
                        }
                    }
                }
            }
        }

    }


   

    public static ArrayList getCitiesList(){
        return  cities;
    }
}
    
