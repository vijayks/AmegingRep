/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 *  /* DESC SCROLL_ADS_T;

 * +-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| S_ID        | int(4)       | NO   | PRI | NULL    | auto_increment |
| SCR_TITLE   | varchar(100) | YES  |     | NULL    |                |
| IMG1        | varchar(20)  | YES  |     | NULL    |                |
| IMG2        | varchar(20)  | YES  |     | NULL    |                |
| 1MG3        | varchar(20)  | YES  |     | NULL    |                |
| DESCRIPTION | varchar(250) | YES  |     | NULL    |                |
| DEALER_ID   | int(11)      | YES  |     | NULL    |                |
| STATUS      | int(11)      | YES  |     | NULL    |                |
| S_DATE      | datetime     | YES  |     | NULL    |                |
| E_DATE      | datetime     | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+


 *
 *  */
package com.buysell.beans;

import java.io.Serializable;

public class ScrAdsBean implements Serializable {

    private int sid;
    private String scrTitle = null;
   private String img1;
   private String img2;
   private String img3;
   private String img4;
   private String img5;
   private String img6;
   private String img7;
   private String img8;
   private String img9;
   private String thumbImg;
   private String url;
    private String desc = null;
    private int dealerId;
    private int status;
    private String sDate = null;
    private String eDate = null;
    private String companyName = null;
    private String logo = null;
    private String address = null;
    private String city = null;
    private String lprice = null;
    private String oprice = null;
    private int categoryId = 0;
    private String offerType = null;
    private String dlrName;
 

    public String getImg4() {
        return img4;
    }

    public void setImg4(String img4) {
        this.img4 = img4;
    }

    public String getImg5() {
        return img5;
    }

    public void setImg5(String img5) {
        this.img5 = img5;
    }

    public String getImg6() {
        return img6;
    }

    public void setImg6(String img6) {
        this.img6 = img6;
    }

    public String getImg7() {
        return img7;
    }

    public void setImg7(String img7) {
        this.img7 = img7;
    }

    public String getImg8() {
        return img8;
    }

    public void setImg8(String img8) {
        this.img8 = img8;
    }

    public String getImg9() {
        return img9;
    }

    public void setImg9(String img9) {
        this.img9 = img9;
    }

    public String getThumbImg() {
        return thumbImg;
    }

    public void setThumbImg(String thumbImg) {
        this.thumbImg = thumbImg;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }


    

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getOfferType() {
        return offerType;
    }

    public void setOfferType(String offerType) {
        this.offerType = offerType;
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public int getDealerId() {
        return dealerId;
    }

    public void setDealerId(int dealerId) {
        this.dealerId = dealerId;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String geteDate() {
        return eDate;
    }

    public void seteDate(String eDate) {
        this.eDate = eDate;
    }

    public String getImg1() {
        return img1;
    }

    public void setImg1(String img1) {
        this.img1 = img1;
    }

    public String getImg2() {
        return img2;
    }

    public void setImg2(String img2) {
        this.img2 = img2;
    }

    public String getImg3() {
        return img3;
    }

    public void setImg3(String img3) {
        this.img3 = img3;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getLprice() {
        return lprice;
    }

    public void setLprice(String lprice) {
        this.lprice = lprice;
    }

    public String getOprice() {
        return oprice;
    }

    public void setOprice(String oprice) {
        this.oprice = oprice;
    }

    public String getsDate() {
        return sDate;
    }

    public void setsDate(String sDate) {
        this.sDate = sDate;
    }

    public String getScrTitle() {
        return scrTitle;
    }

    public void setScrTitle(String scrTitle) {
        this.scrTitle = scrTitle;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

 public String getDlrName() {
        return dlrName;
    }

    public void setDlrName(String dlrName) {
        this.dlrName = dlrName;
    }
}