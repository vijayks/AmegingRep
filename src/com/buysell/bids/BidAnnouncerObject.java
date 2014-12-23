/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.bids;

import java.util.Date;

/**
 *
 * @author bbsadmin
 */
 public class BidAnnouncerObject{
    String prodName;
    String prodImg;
    String wonUserName;
    long wonUserId;
    float wonPrice;
    Date wonDt;
    Date insertedTime;
    float initialPrice;
    float productPrice;
    long bidId;
    Date bidEndDt;

    public Date getBidEndDt() {
        return bidEndDt;
    }

    public void setBidEndDt(Date bidEndDt) {
        this.bidEndDt = bidEndDt;
    }

    public long getBidId() {
        return bidId;
    }

    public void setBidId(long bidId) {
        this.bidId = bidId;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public float getInitialPrice() {
        return initialPrice;
    }

    public void setInitialPrice(float initialPrice) {
        this.initialPrice = initialPrice;
    }

    public Date getInsertedTime() {
        return insertedTime;
    }

    public void setInsertedTime(Date insertedTime) {
        this.insertedTime = insertedTime;
    }

    public String getProdImg() {
        return prodImg;
    }

    public void setProdImg(String prodImg) {
        this.prodImg = prodImg;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public Date getWonDt() {
        return wonDt;
    }

    public void setWonDt(Date wonDt) {
        this.wonDt = wonDt;
    }

    public float getWonPrice() {
        return wonPrice;
    }

    public void setWonPrice(float wonPrice) {
        this.wonPrice = wonPrice;
    }

    public long getWonUserId() {
        return wonUserId;
    }

    public void setWonUserId(long wonUserId) {
        this.wonUserId = wonUserId;
    }

    public String getWonUserName() {
        return wonUserName;
    }

    public void setWonUserName(String wonUserName) {
        this.wonUserName = wonUserName;
    }


    public BidAnnouncerObject() {
        insertedTime = new Date();
    }

}