/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;


import java.io.IOException;
import java.util.Properties;
import org.apache.log4j.Logger;


/**
 *
 * @author srikanth
 */
public class BuySellProperties {
 private static Logger LOG = Logger.getLogger(BuySellProperties.class);
    private static Properties props=null;
    public String fileName;

    private BuySellProperties(String fileName) {

        this.fileName = fileName;
        if(this.fileName != null && props == null){
            try {
                props = new Properties();
                props.load(Thread.currentThread().getContextClassLoader().getResourceAsStream(fileName));
            } catch (IOException ex) {
               LOG.debug("Error while population properties"+ex);
            }
        }
    }
    public static String getProperty(String key){
        if(props == null){
            BuySellProperties bsp = new BuySellProperties("buysell.properties");
        }
        return props.getProperty(key);
    }

}
