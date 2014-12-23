/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

/**
 *
 * @author bbsadmin
 */
public class Product implements Serializable {

    long id;
    String creationDate;
    int status;
    String lastModDate;
    long dealerId;
    String title;
    String description;
    String imageLocation;
    String shortDesc;
    String modelId;
    float actualPrice;
    float discount;
    float offerPrice;
    String currency;
    String shortSpecifics;
    String longSpecifics;
    String accessories;
    String name;
    String offerTill;
    String stockStatus;
    int type;
    long catId;
    long prodId;
    String assignedProducts;
    List assignedProdList;

    public List getAssignedProdList() {
        return assignedProdList;
    }

    public void setAssignedProdList(List assignedProdList) {
        this.assignedProdList = assignedProdList;
    }

    public String getAssignedProducts() {
        return assignedProducts;
    }

    public void setAssignedProducts(String assignedProducts) {
        this.assignedProducts = assignedProducts;
        List ll = new ArrayList();
        if (assignedProducts != null && assignedProducts.trim().length() > 0) {
            StringTokenizer st = new StringTokenizer(assignedProducts, "^");
            if (st != null) {
                while (st.hasMoreTokens()) {
                    ll.add(st.nextToken());
                }
            }
        }
        setAssignedProdList(ll);
    }

    public long getCatId() {
        return catId;
    }

    public void setCatId(long catId) {
        this.catId = catId;
    }

    public long getProdId() {
        return prodId;
    }

    public void setProdId(long prodId) {
        this.prodId = prodId;
    }
    
    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
    
    public String getStockStatus() {
        return stockStatus;
    }

    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }

    public String getAccessories() {
        return accessories;
    }

    public void setAccessories(String accessories) {
        this.accessories = accessories;
    }

    public float getActualPrice() {
        return actualPrice;
    }

    public void setActualPrice(float actualPrice) {
        this.actualPrice = actualPrice;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public long getDealerId() {
        return dealerId;
    }

    public void setDealerId(long dealerId) {
        this.dealerId = dealerId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getImageLocation() {
        return imageLocation;
    }

    public void setImageLocation(String imageLocation) {
        this.imageLocation = imageLocation;
    }

    public String getLastModDate() {
        return lastModDate;
    }

    public void setLastModDate(String lastModDate) {
        this.lastModDate = lastModDate;
    }

    public String getLongSpecifics() {
        return longSpecifics;
    }

    public void setLongSpecifics(String longSpecifics) {
        this.longSpecifics = longSpecifics;
    }

    public String getModelId() {
        return modelId;
    }

    public void setModelId(String modelId) {
        this.modelId = modelId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getOfferPrice() {
        return offerPrice;
    }

    public void setOfferPrice(float offerPrice) {
        this.offerPrice = offerPrice;
    }

    public String getOfferTill() {
        return offerTill;
    }

    public void setOfferTill(String offerTill) {
        this.offerTill = offerTill;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public String getShortSpecifics() {
        return shortSpecifics;
    }

    public void setShortSpecifics(String shortSpecifics) {
        this.shortSpecifics = shortSpecifics;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
