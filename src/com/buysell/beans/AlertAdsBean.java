/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.util.Date;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author BlueIgnite
 */
public class AlertAdsBean {
     private static Logger LOG = Logger.getLogger(AlertAdsBean.class);
    private int alertId;
    private int userId;
    private Date alertOn;
    private Date alertFrom;
    private Date alertTo;
    private  int catId;
    private String keyword;
    private String city;

    public Date getAlertFrom() {
        return alertFrom;
    }

    public void setAlertFrom(Date alertFrom) {
        this.alertFrom = alertFrom;
    }

    public int getAlertId() {
        return alertId;
    }

    public void setAlertId(int alertId) {
        this.alertId = alertId;
    }

    public Date getAlertOn() {
        return alertOn;
    }

    public void setAlertOn(Date alertOn) {
        this.alertOn = alertOn;
    }

    public Date getAlertTo() {
        return alertTo;
    }

    public void setAlertTo(Date alertTo) {
        this.alertTo = alertTo;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

     public void setPropertiesFromSearchPattern(String dbString) {


        StringTokenizer stz = new StringTokenizer(dbString, "|");

        if (stz != null) {

            if (stz.hasMoreTokens()) {
                this.setKeyword(stz.nextToken());

                if (stz.hasMoreElements()) {
                    String temp = stz.nextToken();
                    if ( temp != null && !temp.trim().equalsIgnoreCase("")  ) {
                       
                        this.setCatId(Integer.parseInt(temp));
                    } else {
                        LOG.info(" null category or empty ");
                        this.setCatId(0);
                    }

                } else {

                    this.setCatId(0);


                }
                    if (stz.hasMoreElements()) {

                        this.setCity(stz.nextToken());
                    } else {

                        this.setCity("AllIndia");
                    }
                }


            
        }
        LOG.info("keyword=" + this.getKeyword());
        LOG.info("category=" + this.getCatId());
        LOG.info("city+=" + this.getCity());


    }

    

}
