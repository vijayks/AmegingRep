/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

/**
 *
 * @author bbsadmin
 */
public class DealerBean extends UserBean  implements Serializable{

    String comp_name;
    String logoPath;
    String dlrType;
    String noAds;
    String noOffers;
    String noSms;
    String description;
    String toolTip;
    String phone1;
    String phone2;
    String emailId;
    long dlId;
    String wsUrl;
    String occupation;
    String gender;
    String locality;
    String address;
    String city;
    String pincode;
    String state;
    String country;
    String landmark;
    String details;
    String path;
    String website;
    String categories;
    List categoryList;

    public String getCategories() {
        return categories;
    }

    public void setCategories(String categories) {
        this.categories = categories;

         List ll = new ArrayList();
        if (categories != null && categories.trim().length() > 0) {
            StringTokenizer st = new StringTokenizer(categories, "|");
            if (st != null) {
                while (st.hasMoreTokens()) {
                    ll.add(st.nextToken());
                }
            }
        }
        setCategoryList(ll);
    }

    public List getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List categoryList) {
        this.categoryList = categoryList;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }
    
    public String getLandmark() {
        return landmark;
    }

    public void setLandmark(String landmark) {
        this.landmark = landmark;
    }
    
    public String getPincode() {
        return pincode;
    }

    public void setPincode(String pincode) {
        this.pincode = pincode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
    
    public String getDlrType() {
        return dlrType;
    }

    public void setDlrType(String dlrType) {
        this.dlrType = dlrType;
    }

    public String getNoAds() {
        return noAds;
    }

    public void setNoAds(String noAds) {
        this.noAds = noAds;
    }

    public String getNoOffers() {
        return noOffers;
    }

    public void setNoOffers(String noOffers) {
        this.noOffers = noOffers;
    }

    public String getNoSms() {
        return noSms;
    }

    public void setNoSms(String noSms) {
        this.noSms = noSms;
    }

    public String getWsUrl() {
        return wsUrl;
    }

    public void setWsUrl(String wsUrl) {
        this.wsUrl = wsUrl;
    }
   
    public long getDlId() {
        return dlId;
    }

    public void setDlId(long dlId) {
        this.dlId = dlId;
    }
    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getPhone1() {
        return phone1;
    }

    public void setPhone1(String phone1) {
        this.phone1 = phone1;
    }

    public String getPhone2() {
        return phone2;
    }

    public void setPhone2(String phone2) {
        this.phone2 = phone2;
    }

    public String getToolTip() {
        return toolTip;
    }

    public void setToolTip(String toolTip) {
        this.toolTip = toolTip;
    }    

    public String getComp_name() {
        return comp_name;
    }

    public void setComp_name(String comp_name) {
        this.comp_name = comp_name;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }
    
}
