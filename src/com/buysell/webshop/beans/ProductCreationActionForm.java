/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.beans;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class ProductCreationActionForm extends org.apache.struts.action.ActionForm {
    
    String creationDate;
    int status;
    String lastModDate;
    long dealerId;
    String title;
    String description;
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
    FormFile img1;
    FormFile img2;
    FormFile img3;
    FormFile img4;
    FormFile img5;
    FormFile img6;
    FormFile thImg;

    public FormFile getImg1() {
        return img1;
    }

    public void setImg1(FormFile img1) {
        this.img1 = img1;
    }

    public FormFile getImg2() {
        return img2;
    }

    public void setImg2(FormFile img2) {
        this.img2 = img2;
    }

    public FormFile getImg3() {
        return img3;
    }

    public void setImg3(FormFile img3) {
        this.img3 = img3;
    }

    public FormFile getImg4() {
        return img4;
    }

    public void setImg4(FormFile img4) {
        this.img4 = img4;
    }

    public FormFile getImg5() {
        return img5;
    }

    public void setImg5(FormFile img5) {
        this.img5 = img5;
    }

    public FormFile getImg6() {
        return img6;
    }

    public void setImg6(FormFile img6) {
        this.img6 = img6;
    }

    public FormFile getThImg() {
        return thImg;
    }

    public void setThImg(FormFile thImg) {
        this.thImg = thImg;
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

    public String getStockStatus() {
        return stockStatus;
    }

    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    /**
     *
     */
    public ProductCreationActionForm() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        
        return errors;
    }
}
