/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.util;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SendSMS {

    private static final Logger LOG = Logger.getLogger(SendSMS.class);
    private static String smsurl = BuySellProperties.getProperty("smsurl");

    public static boolean callSendSMS(String mob, String encodedurl){
        int res=0;
        HttpClient hc = new HttpClient();
        GetMethod gm = new GetMethod(smsurl + "&mobilenumber=" + mob + "&message=" + encodedurl);
        try {
            hc.executeMethod(gm);
            res = gm.getStatusCode();
            LOG.info(" Got response while sending message '" + encodedurl + "' to "+mob+" is " + res);
        } catch (Exception ex) {
            LOG.error("Error while sending the command :" + res + " for " + mob + " \n ERROR is " + ex);
        } finally {
            if(gm!=null){
                gm.releaseConnection();
                LOG.debug("Releasing GetMethod Connection");
            }
        }
        if(res==200)
            return true;
        else
            return false;
    }
}
