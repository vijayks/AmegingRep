/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.beans;

import com.buysell.util.CategoryUtil;
import com.buysell.util.JspFNameDescMap;
import com.buysell.util.SearchUtil;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;
import org.omg.CORBA.Request;

/**
 *
 * @author bbsadmin
 */
public class BbsBean implements Serializable {

    private static final Logger LOG = Logger.getLogger(BbsBean.class);
    //Bbs Points required fields
    private String reason = null;
    private int points = 0;
    private String pointsOn = null;
    //Redemption points related fields
    private int qty = 0;
    private String status = null;
    private String deliverOn = null;
    private String name = null;
    private String country = null;
    private String state = null;
    private String city = null;//used in saved Searches also// used in Saved Alerts
    private String locality = null;
    private String addr = null;
    private String mobile = null;
    private String deliverTo = null;
    //Saved Search Related fields
    private String searchUrl = null;
    private String keyword = null;//used in saved Alerts
    private int categoryId = 0;   //used in saved Alerts
    private String catName = null;//used in saved Alerts
    private String searchOn = null;
    private int searchId = 0;
    private String qryString = null;
    //saved Alerts related fields
    private String alertOn = null;
    private String alertFrom = null;
    private String alertTo = null;
    private int alertId = 0;
    private String refinePattern = null;

    public String getQryString() {
        return qryString;
    }

    public void setQryString(String qryString) {
        this.qryString = qryString;
    }

    public String getRefinePattern() {
        return refinePattern;
    }

    public void setRefinePattern(String refinePattern) {
        this.refinePattern = refinePattern;
    }

    public int getAlertId() {
        return alertId;
    }

    public void setAlertId(int alertId) {
        this.alertId = alertId;
    }

    public String getAlertFrom() {
        return alertFrom;
    }

    public void setAlertFrom(String alertFrom) {
        this.alertFrom = alertFrom;
    }

    public String getAlertOn() {
        return alertOn;
    }

    public void setAlertOn(String alertOn) {
        this.alertOn = alertOn;
    }

    public String getAlertTo() {
        return alertTo;
    }

    public void setAlertTo(String alertTo) {
        this.alertTo = alertTo;
    }

    public int getSearchId() {
        return searchId;
    }

    public void setSearchId(int searchId) {
        this.searchId = searchId;
    }

    public String getSearchOn() {
        return searchOn;
    }

    public void setSearchOn(String searchOn) {
        this.searchOn = searchOn;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSearchUrl() {
        return searchUrl;
    }

    public void setSearchUrl(String searchUrl) {
        this.searchUrl = searchUrl;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public void setPropertiesFromSearchPattern(String dbString) {
        LOG.info("str=" + dbString);
        HashMap hm = new HashMap();
        CategoryUtil cu = new CategoryUtil();

        if (dbString != null && dbString.trim().length() > 0) {
            this.setQryString(dbString);

            StringTokenizer stz = new StringTokenizer(dbString, "&");

            if (stz != null) {


                while (stz.hasMoreElements()) {


                    String temp = stz.nextToken();
                    if (temp != null && temp.trim().length() > 0 && temp.contains("=")) {

                        //  LOG.info("temp=" + temp);
                        String[] kv = temp.split("=");
                        if (kv != null && kv.length == 2) {
                            temp = (String) hm.get(kv[0]);
                            if (temp != null && temp.trim().length() > 0) {
                                hm.put(kv[0], temp + ", " + kv[1]);
                            } else {
                                hm.put(kv[0], kv[1]);
                            }
                        }


                    }


                }

                Set s = hm.keySet();
                Iterator i = s.iterator();
                while (i.hasNext()) {
                    String t = (String) i.next();
                    LOG.info(t + "==>" + hm.get(t));
                }


                StringBuffer sb = new StringBuffer();
                String temp2 = null;
                String temp = (String) hm.get("keyword");
                SearchUtil su = new SearchUtil();
                List splFields = null;
                JspFNameDescMap jfdesc = new JspFNameDescMap();

                if (temp != null && temp.trim().length() > 0) {
                    sb.append("With keyword <b>\"" + temp + "\"</b>, ");
                }

                LOG.info("1=" + sb);


                try {

                    temp = (String) hm.get("subCatId");
                    if (temp != null && temp.trim().length() > 0 && !temp.trim().equals("0")) {
                        String catNm = cu.getCategoryNameWithId(Integer.parseInt(temp.trim()));
                        sb.append("In category<b> \"" + catNm + "\"</b>, ");
                        splFields = su.getJspFieldsForCatId(Integer.parseInt(temp.trim()));
                    }

                } catch (Exception e) {
                    LOG.info("Error:" + e);
                }

                LOG.info("2=" + sb);



                temp = (String) hm.get("adType");
                if (temp != null && temp.trim().length() > 0) {
                    sb.append(" \"" + temp + "\" Ads ");
                }

                LOG.info("3=" + sb);

                temp = (String) hm.get("city");
                if (temp != null && temp.trim().length() > 0) {
                    sb.append(" in city<b> \"" + temp + "\"</b>; ");
                }
                LOG.info("4=" + sb);

                temp = (String) hm.get("lcs");
                if (temp != null && temp.trim().length() > 0) {


                    StringTokenizer st = new StringTokenizer(temp, ",");
                    if (st != null) {
                        int count = st.countTokens();
                        boolean one = false;
                        if (count == 1) {
                            one = true;
                        }
                        if (count > 0) {
                            sb.append("<b> Locations </b> : ");
                            while (st.hasMoreTokens()) {

                                String location = st.nextToken();
                                if (location != null && location.trim().length() > 0) {


                                    if (count == 1) {

                                        if (one) {
                                            sb.append(location + ";");
                                        } else {
                                            sb = new StringBuffer(sb.substring(0, sb.length() - 2));
                                            sb.append(" & " + location + ";");
                                        }
                                    } else {
                                        sb.append(location + ", ");
                                    }
                                    LOG.info("11=" + sb);

                                }
                                count--;
                            }

                        }
                    }
                }

                LOG.info("5=" + sb);

                temp = (String) hm.get("clfs");
                if (temp != null && temp.trim().length() > 0) {

                    StringTokenizer st = new StringTokenizer(temp, ",");
                    if (st != null) {
                        int count = st.countTokens();
                        boolean one = false;
                        if (count == 1) {
                            one = true;
                        }
                        if (count > 0) {
                            sb.append("<b> Classfications </b> :");
                            while (st.hasMoreTokens()) {
                                String catid = st.nextToken();
                                if (catid != null && catid.trim().length() > 0) {

                                    try {
                                        if (count == 1) {

                                            if (one) {
                                                sb.append(cu.getCategoryNameWithId(Integer.parseInt(catid.trim())) + ";");
                                            } else {
                                                sb = new StringBuffer(sb.substring(0, sb.length() - 2));
                                                sb.append(" & " + cu.getCategoryNameWithId(Integer.parseInt(catid.trim())) + ";");
                                            }

                                        } else {
                                            sb.append(cu.getCategoryNameWithId(Integer.parseInt(catid.trim())) + ", ");
                                        }
                                        LOG.info("11=" + sb);
                                    } catch (Exception e) {
                                        LOG.error("error:" + e);
                                    }

                                }
                                count--;
                            }

                        }
                    }

                }

                LOG.info("6=" + sb);

                temp = (String) hm.get("minPrc");
                temp2 = (String) hm.get("maxPrc");
                if (temp != null && temp.trim().length() > 0 && temp2 != null && temp2.trim().length() > 0) {
                    sb.append(" Price range from \"<b>Rs.");
                    sb.append(temp + " to Rs." + temp2 + "\"</b>;");
                } else if (temp2 != null && temp2.trim().length() > 0) {
                    sb.append(" Price \"Rs.<b>");
                    sb.append(temp2 + "\"</b>;");
                } else if (temp != null && temp.trim().length() > 0) {
                    sb.append(" Price \"Rs.<b>");
                    sb.append(temp + "\"</b>;");
                }

                if (splFields != null && splFields.size() > 0) {
                    LOG.info("spFilds:" + splFields);

                    Iterator itr = splFields.iterator();
                    if (itr != null) {
                        String jspf, sfv, desc;
                        while (itr.hasNext()) {
                            jspf = (String) itr.next();
                            if (jspf != null && jspf.trim().length() > 0) {
                                sfv = (String) hm.get(jspf);
                                if (sfv != null && sfv.trim().length() > 0) {
                                    desc = jfdesc.getDescToJspField(jspf);
                                    if (desc != null) {
                                        sb.append(" " + desc + " : " + sfv + "; ");
                                    }
                                }
                            }
                        }
                    }
                }

                LOG.info("7=" + sb);


                temp = (String) hm.get("opa");
                if (temp != null && temp.trim().length() > 0 && temp.trim().equalsIgnoreCase("y")) {
                    sb.append(" with \" <b>Only Photo \" Ads</b>;");
                }
                LOG.info("8=" + sb);




                if (sb.length() > 0) {
                    this.setRefinePattern(sb.toString());
                }

            }// tokenize dbString no tnull

        }//dbstring no null
    }

    public void setPropertiesFromAlertPattern(String dbString) {
        if (dbString != null && dbString.trim().length() > 0) {
            LOG.info("dbString=" + dbString);
            HashMap hm = new HashMap();
            CategoryUtil cu = new CategoryUtil();

            StringTokenizer stz = new StringTokenizer(dbString, "|");

            if (stz != null && stz.countTokens() > 0) {
                String temp = null;

                if (stz.hasMoreTokens()) {
                    temp = (String) stz.nextToken();
                    if (temp != null && temp.trim().length() > 0) {

                        hm.put("keyword", temp);
                    }
                }// to extracat keyword from dbstring


                if (stz.hasMoreTokens()) {

                    temp = (String) stz.nextToken();
                    if (temp != null && temp.trim().length() > 0 && !temp.trim().equals("0")) {

                        StringTokenizer str1 = new StringTokenizer(temp, ",");


                        if (str1 != null) {
                            LOG.debug("tokenize catids");
                            List clfs = new ArrayList();

                            while (str1.hasMoreTokens()) {
                                try {

                                    clfs.add(str1.nextToken().trim());
                                } catch (Exception e) {
                                    LOG.error("Error :" + e);
                                }

                            }

                            if (clfs != null && clfs.size() == 1) {
                                LOG.debug("only one id");
                                List l = null;

                                try {

                                    l = cu.getClfCatIdsWithSubCatId(Integer.parseInt(((String) clfs.get(0)).trim()));
                                } catch (Exception e) {
                                    LOG.error("ERROR:" + e);
                                }

                                if (l != null && l.size() > 0) {
                                    LOG.debug("it is subcategory id");
                                    hm.put("subCatId", (String) clfs.get(0));
                                } else {
                                    LOG.debug("it is classification id");
                                    hm.put("clfs", (String) clfs.get(0));
                                    try {
                                        hm.put("subCatId", String.valueOf(cu.getRootCatId(Integer.parseInt((String) clfs.get(0)))));
                                        LOG.info("hm.get(subCatId=" + hm.get("subCatId"));
                                    } catch (Exception e) {
                                        LOG.info("Subcat Error:" + e);
                                    }
                                }
                            } else if (clfs != null && clfs.size() > 1) {

                                LOG.debug("many ids");
                                try {
                                    hm.put("subCatId", String.valueOf(cu.getRootCatId(Integer.parseInt((String) clfs.get(0)))));
                                    LOG.info("hm.get(subCatId=" + hm.get("subCatId"));
                                } catch (Exception e) {
                                    LOG.info("Subcat Error:" + e);
                                }

                                Iterator itr = clfs.iterator();
                                if (itr != null) {
                                    StringBuffer s = new StringBuffer();
                                    while (itr.hasNext()) {

                                        s.append((String) itr.next() + ", ");

                                    }
                                    hm.put("clfs", s.substring(0, s.length() - 2));
                                }
                            }
                        }


                    } // test weather category is null or not "0"
                }//  to extracat subcatId or classification ids from dbstring



                if (stz.hasMoreTokens()) {
                    temp = (String) stz.nextToken();
                    if (temp != null && temp.trim().length() > 0) {

                        hm.put("city", temp);
                    }
                }// to extracat city from dbstring




                while (stz.hasMoreTokens()) {
                    temp = stz.nextToken();
                    if (temp != null && temp.trim().length() > 0 && temp.contains("^")) {
                        temp = temp.replace('^', '=');

                        LOG.info("b4 spitting:" + temp);
                        if (temp != null && temp.trim().length() > 0 && temp.contains("=")) {
                            String[] kv = temp.split("=");
                            LOG.info("kv=" + kv);
                            if (kv != null && kv.length == 2) {
                                temp = (String) hm.get(kv[0]);
                                LOG.info("key=" + kv[0]);
                                if (temp != null && temp.trim().length() > 0) {
                                    hm.put(kv[0], temp + ", " + kv[1]);
                                } else {
                                    hm.put(kv[0], kv[1]);
                                }
                            }
                        }
                    }
                }// while looping through tokenized elements with "|" which have name-value pairs



                // display alert pattern creting string

                Set s = hm.keySet();
                Iterator i = s.iterator();
                while (i.hasNext()) {
                    String t = (String) i.next();
                    LOG.info(t + "==>" + hm.get(t));
                }


                StringBuffer sb = new StringBuffer();

                SearchUtil su = new SearchUtil();
                List splFields = null;
                JspFNameDescMap jfdesc = new JspFNameDescMap();

                temp = (String) hm.get("keyword");
                if (temp != null && temp.trim().length() > 0) {
                    sb.append("With keyword \"" + temp + "\", ");
                }

                LOG.info("1=" + sb);


                try {

                    temp = (String) hm.get("subCatId");
                    if (temp != null && temp.trim().length() > 0 && !temp.trim().equals("0")) {
                        String catNm = cu.getCategoryNameWithId(Integer.parseInt(temp.trim()));
                        sb.append("In category \"" + catNm + "\", ");
                        splFields = su.getJspFieldsForCatId(Integer.parseInt(temp.trim()));
                    }

                } catch (Exception e) {
                    LOG.info("Error:" + e);
                }

                LOG.info("2=" + sb);



                temp = (String) hm.get("adType");
                if (temp != null && temp.trim().length() > 0) {
                    sb.append(" \"" + temp + "\" Ads ");
                }

                LOG.info("3=" + sb);

                temp = (String) hm.get("city");
                if (temp != null && temp.trim().length() > 0) {
                    sb.append(" in city \"" + temp + "\"; ");
                }
                LOG.info("4=" + sb);

                temp = (String) hm.get("lcs");
                if (temp != null && temp.trim().length() > 0) {


                    StringTokenizer st = new StringTokenizer(temp, ",");
                    if (st != null) {
                        int count = st.countTokens();
                        boolean one = false;
                        if (count == 1) {
                            one = true;
                        }
                        if (count > 0) {
                            sb.append(" Locations : ");
                            while (st.hasMoreTokens()) {

                                String location = st.nextToken();
                                if (location != null && location.trim().length() > 0) {


                                    if (count == 1) {

                                        if (one) {
                                            sb.append(location + ";");
                                        } else {
                                            sb = new StringBuffer(sb.substring(0, sb.length() - 2));
                                            sb.append(" & " + location + ";");
                                        }
                                    } else {
                                        sb.append(location + ", ");
                                    }
                                    LOG.info("11=" + sb);

                                }
                                count--;
                            }

                        }
                    }
                }

                LOG.info("5=" + sb);

                temp = (String) hm.get("clfs");
                if (temp != null && temp.trim().length() > 0) {

                    StringTokenizer st = new StringTokenizer(temp, ",");
                    if (st != null) {
                        int count = st.countTokens();
                        boolean one = false;
                        if (count == 1) {
                            one = true;
                        }
                        if (count > 0) {
                            sb.append(" Classfications :");
                            while (st.hasMoreTokens()) {
                                String catid = st.nextToken();
                                if (catid != null && catid.trim().length() > 0) {

                                    try {
                                        if (count == 1) {

                                            if (one) {
                                                sb.append(cu.getCategoryNameWithId(Integer.parseInt(catid.trim())) + ";");
                                            } else {
                                                sb = new StringBuffer(sb.substring(0, sb.length() - 2));
                                                sb.append(" & " + cu.getCategoryNameWithId(Integer.parseInt(catid.trim())) + ";");
                                            }

                                        } else {
                                            sb.append(cu.getCategoryNameWithId(Integer.parseInt(catid.trim())) + ", ");
                                        }
                                        LOG.info("11=" + sb);
                                    } catch (Exception e) {
                                        LOG.error("error:" + e);
                                    }

                                }
                                count--;
                            }

                        }
                    }

                }

                LOG.info("6=" + sb);

                temp = (String) hm.get("price");
                LOG.info("price=====>" + temp);

                if (temp != null && temp.trim().length() > 0 && temp.contains("-")) {

                    LOG.info("b4 spitting:" + temp);

                    String[] kv = temp.split("-");
                    if (kv != null && kv.length == 2) {
                        if (kv[0].equals(kv[1])) {

                            sb.append(" Price \"Rs.");
                            sb.append(kv[0] + "\";");

                        } else {
                            sb.append(" Price range from \"Rs.");
                            sb.append(kv[0] + " to Rs." + kv[1] + "\";");
                        }
                    }
                }

                LOG.info("spl Fields===>" + splFields);
                if (splFields != null && splFields.size() > 0) {
                    LOG.info("spFilds:" + splFields);

                    Iterator itr = splFields.iterator();
                    if (itr != null) {
                        String jspf, sfv, desc;
                        while (itr.hasNext()) {
                            jspf = (String) itr.next();
                            if (jspf != null && jspf.trim().length() > 0) {
                                sfv = (String) hm.get(jspf);
                                if (sfv != null && sfv.trim().length() > 0) {
                                    desc = jfdesc.getDescToJspField(jspf);
                                    if (desc != null) {
                                        sb.append(" " + desc + " : " + sfv + "; ");
                                    }
                                }
                            }
                        }
                    }
                }

                LOG.info("7=" + sb);

                temp = (String) hm.get("opa");
                if (temp != null && temp.trim().length() > 0 && temp.trim().equalsIgnoreCase("y")) {
                    sb.append(" with \" Only Photo \" Ads;");
                }
                LOG.info("8=" + sb);




                if (sb.length() > 0) {
                    this.setRefinePattern(sb.toString());
                }


            }//DbString tokenize null test
        }// DbString not null


    }

    public void setPropertiesFromString(String dbString) {


        StringTokenizer stz = new StringTokenizer(dbString, "|");

        if (stz != null) {

            if (stz.hasMoreTokens()) {
                this.setName(stz.nextToken());
            }
            if (stz.hasMoreTokens()) {
                this.setCountry(stz.nextToken());
            }
            if (stz.hasMoreTokens()) {
                this.setState(stz.nextToken());
            }
            if (stz.hasMoreTokens()) {
                this.setCity(stz.nextToken());
            }
            if (stz.hasMoreTokens()) {
                this.setLocality(stz.nextToken());
            }
            if (stz.hasMoreTokens()) {
                this.setAddr(stz.nextToken());
            }
            if (stz.hasMoreTokens()) {
                this.setMobile(stz.nextToken());


            }
        }


    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getPointsOn() {
        return pointsOn;
    }

    public void setPointsOn(String pointsOn) {
        this.pointsOn = pointsOn;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDeliverOn() {
        return deliverOn;
    }

    public void setDeliverOn(String deliverOn) {
        this.deliverOn = deliverOn;
    }

    public String getDeliverTo() {
        return deliverTo;
    }

    public void setDeliverTo(String deliverTo) {
        this.deliverTo = deliverTo;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
