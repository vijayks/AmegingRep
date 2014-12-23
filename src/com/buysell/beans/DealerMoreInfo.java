/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.beans;

import java.util.Date;
import java.util.List;

/**
 *
 * @author bbsadmin
 */
public class DealerMoreInfo implements java.io.Serializable {

    private int dId;
    private String compName;
    private String logo;
    private String city;
    private String addInfo;
    private String products;
    private String businessDetails;
    private String address;
    private String landMark;
    private String phone;
    private String mobile;
    private String emailId;
    private String webUrl;
    private String googleMap;
    private String productImages;
    private int dtypeId;
    private String locality;
    private String website;
    private String path;
    private long activeWsId;
    private Date dt;
    private List wsCatList;
    private List websiteImages;
    private String displayName;

    public List getWebsiteImages() {
        return websiteImages;
    }

    public void setWebsiteImages(List websiteImages) {
        this.websiteImages = websiteImages;
    }

    public List getWsCatList() {
        return wsCatList;
    }

    public void setWsCatList(List wsCatList) {
        this.wsCatList = wsCatList;
    }
    
    public long getActiveWsId() {
        return activeWsId;
    }

    public void setActiveWsId(long activeWsId) {
        this.activeWsId = activeWsId;
    }

    public Date getDt() {
        return dt;
    }

    public void setDt(Date dt) {
        this.dt = dt;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
    
    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }

    public int getDtypeId() {
        return dtypeId;
    }

    public void setDtypeId(int dtypeId) {
        this.dtypeId = dtypeId;
    }
    

    public String getAddInfo() {
        return addInfo;
    }

    public void setAddInfo(String addInfo) {
        this.addInfo = addInfo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBusinessDetails() {
        return businessDetails;
    }

    public void setBusinessDetails(String businessDetails) {
        this.businessDetails = businessDetails;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public int getdId() {
        return dId;
    }

    public void setdId(int dId) {
        this.dId = dId;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getGoogleMap() {
        return googleMap;
    }

    public void setGoogleMap(String googleMap) {
        this.googleMap = googleMap;
    }

    public String getLandMark() {
        return landMark;
    }

    public void setLandMark(String landMark) {
        this.landMark = landMark;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProductImages() {
        return productImages;
    }

    public void setProductImages(String productImages) {
        this.productImages = productImages;
    }

    public String getProducts() {
        return products;
    }

    public void setProducts(String products) {
        this.products = products;
    }

    public String getWebUrl() {
        return webUrl;
    }

    public void setWebUrl(String webUrl) {
        this.webUrl = webUrl;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    

    
}
