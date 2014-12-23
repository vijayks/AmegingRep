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
public class BidBean {
    private long bidderId;
    private String bidderName;
    private Date biddingTime;
    private float currentPrice;
    private String bidderEmail;
    private String bidderMobile;

    public BidBean(long bidderId, String bidderName, Date biddingTime, float currentPrice, String bidderEmail, String bidderMobile) {
        this.bidderId = bidderId;
        this.bidderName = bidderName;
        this.biddingTime = biddingTime;
        this.currentPrice = currentPrice;
        this.bidderEmail = bidderEmail;
        this.bidderMobile = bidderMobile;
    }
    
    public long getBidderId() {
        return bidderId;
    }

    public void setBidderId(long bidderId) {
        this.bidderId = bidderId;
    }

    public String getBidderName() {
        return bidderName;
    }

    public void setBidderName(String bidderName) {
        this.bidderName = bidderName;
    }

    public Date getBiddingTime() {
        return biddingTime;
    }

    public void setBiddingTime(Date biddingTime) {
        this.biddingTime = biddingTime;
    }

    public float getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(float currentPrice) {
        this.currentPrice = currentPrice;
    }

    public String getBidderEmail() {
        return bidderEmail;
    }

    public void setBidderEmail(String bidderEmail) {
        this.bidderEmail = bidderEmail;
    }

    public String getBidderMobile() {
        return bidderMobile;
    }

    public void setBidderMobile(String bidderMobile) {
        this.bidderMobile = bidderMobile;
    }

    

}
