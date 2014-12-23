/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class PreferenceBean implements Serializable {

    int userId = 0;
    int preferenceId = 0;
    int smsTimeFrom = 0;
    int smsTimeTo = 0;
    int maxSms = 0;
    int callMe = 0;
    int respType = 0;
    String ModifiedDate = null;
    ArrayList catIds = null;
      private static Logger LOG = Logger.getLogger(PreferenceBean.class);

    public String getModifiedDate() {
        return ModifiedDate;
    }

    public void setModifiedDate(String ModifiedDate) {
        this.ModifiedDate = ModifiedDate;
    }

    public int getRespType() {
        return respType;
    }

    public void setRespType(int respType) {
        this.respType = respType;
    }

    public int getCallMe() {
        return callMe;
    }

    public void setCallMe(int callMe) {
        this.callMe = callMe;
    }

    public ArrayList getCatIds() {
        return catIds;
    }

    public void setCatIds(ArrayList catIds) {
        this.catIds = catIds;
    }

    public int getMaxSms() {
        return maxSms;
    }

    public void setMaxSms(int maxSms) {
        this.maxSms = maxSms;
    }

    public int getPreferenceId() {
        return preferenceId;
    }

    public void setPreferenceId(int preferenceId) {
        this.preferenceId = preferenceId;
    }

    public int getSmsTimeFrom() {
        return smsTimeFrom;
    }

    public void setSmsTimeFrom(int smsTimeFrom) {
        this.smsTimeFrom = smsTimeFrom;
    }

    public int getSmsTimeTo() {
        return smsTimeTo;
    }

    public void setSmsTimeTo(int smsTimeTo) {
        this.smsTimeTo = smsTimeTo;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setcatIdsWithDbString(String dbString) {

        ArrayList al = new ArrayList();

        if (dbString != null) {

            StringTokenizer st = new StringTokenizer(dbString, "|");
            while (st.hasMoreTokens()) {
                String tag = st.nextToken();
                 LOG.info("In preferenceBean="+tag);
                if (tag != null) {
                    al.add(tag);

                   
                }

            }

        }
        this.setCatIds(al);

    }
}
