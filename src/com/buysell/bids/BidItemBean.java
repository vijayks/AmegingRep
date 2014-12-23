/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.bids;

import java.util.Date;
import java.util.Vector;

/**
 *
 * @author bbsadmin
 */
public class BidItemBean {

    private long id;
    private long bidProdId;
    private Date bidStart;
    private Date bidEnd;
    private float initialPrice;
    private int status;
    private int bidderSize;
    private float lowerLimit;
    private float upperLimit;
    private int bidLimit;
    private int superBid;
    private String prodName;
    private String prodImg;
    private long bidderId;
    private String bidderName;
    private Date biddingTime;
    private float currentPrice;
    private Vector bidDetails = new Vector();
    private float productPrice;
    private String description;
    private String images;
    private String prodModel;
    private String shortSpecs;
    private String longSpecs;
    private String prodOwner;
    private String bidderEmail;
    private String bidderMobile;

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
    
    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getLongSpecs() {
        return longSpecs;
    }

    public void setLongSpecs(String longSpecs) {
        this.longSpecs = longSpecs;
    }

    public String getProdModel() {
        return prodModel;
    }

    public void setProdModel(String prodModel) {
        this.prodModel = prodModel;
    }

    public String getProdOwner() {
        return prodOwner;
    }

    public void setProdOwner(String prodOwner) {
        this.prodOwner = prodOwner;
    }

    public String getShortSpecs() {
        return shortSpecs;
    }

    public void setShortSpecs(String shortSpecs) {
        this.shortSpecs = shortSpecs;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public float getCurrentPrice() {
        return currentPrice;
    }
   
    public long getBidderId() {
        return bidderId;
    }

    public String getBidderName() {
        return bidderName;
    }

    public Date getBiddingTime() {
        return biddingTime;
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

    public Date getBidEnd() {
        return bidEnd;
    }

    public void setBidEnd(Date bidEnd) {
        this.bidEnd = bidEnd;
    }

    public int getBidLimit() {
        return bidLimit;
    }

    public void setBidLimit(int bidLimit) {
        this.bidLimit = bidLimit;
    }

    public long getBidProdId() {
        return bidProdId;
    }

    public void setBidProdId(long bidProdId) {
        this.bidProdId = bidProdId;
    }

    public Date getBidStart() {
        return bidStart;
    }

    public void setBidStart(Date bidStart) {
        this.bidStart = bidStart;
    }

    public int getBidderSize() {
        return bidderSize;
    }

    public void setBidderSize(int bidderSize) {
        this.bidderSize = bidderSize;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public float getInitialPrice() {
        return initialPrice;
    }

    public void setInitialPrice(float initialPrice) {
        this.initialPrice = initialPrice;
    }

    public float getLowerLimit() {
        return lowerLimit;
    }

    public void setLowerLimit(float lowerLimit) {
        this.lowerLimit = lowerLimit;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getSuperBid() {
        return superBid;
    }

    public void setSuperBid(int superBid) {
        this.superBid = superBid;
    }

    public float getUpperLimit() {
        return upperLimit;
    }

    public void setUpperLimit(float upperLimit) {
        this.upperLimit = upperLimit;
    }

    public void setBidDetails(long bidderId, String bidderName,float bid, String bidderEmail, String bidderMobile){
        BidBean bb = new BidBean(this.bidderId, this.bidderName, this.biddingTime, this.currentPrice, this.bidderEmail, this.bidderMobile);
        addBidDetails(bb);
        this.currentPrice = bid;
        this.bidderId = bidderId;
        this.bidderName = bidderName;
        this.biddingTime = new Date();
        this.bidderEmail = bidderEmail;
        this.bidderMobile = bidderMobile;
    }

    public void setBidDetails(long bidderId, String bidderName,float bid,Date bidTime, String bidderEmail, String bidderMobile){
        BidBean bb = new BidBean(this.bidderId, this.bidderName, this.biddingTime, this.currentPrice, this.bidderEmail, this.bidderMobile);
        addBidDetails(bb);
        this.currentPrice = bid;
        this.bidderId = bidderId;
        this.bidderName = bidderName;
        this.biddingTime = bidTime;
        this.bidderEmail = bidderEmail;
        this.bidderMobile = bidderMobile;
    }

    private  synchronized void addBidDetails(BidBean bb){
        if(bidDetails.size() >= bidderSize ){
            bidDetails.remove(bidderSize-1);
        }
        bidDetails.add(0,bb);        
    }

    public Vector getBidDetails(){
        return bidDetails;
    }

}
