
package com.buysell.beans;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class ScrollOffersFormBean extends org.apache.struts.action.ActionForm {

   private String title=null;
   private String description=null;
   private FormFile img1;
   private FormFile img2;
   private FormFile img3;
   private FormFile img4;
   private FormFile img5;
   private FormFile img6;
   private FormFile img7;
   private FormFile img8;
   private FormFile img9;
   private FormFile thumbImg;


   private String dateS=null;
   private String dateE=null;
   private int dealerId;
   private String offCity=null;
   private String lprice=null;
   private String oprice=null;
   private int category=0;
   private String offType=null;
   private String url=null;




   public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public String getOffType() {
        return offType;
    }

    public void setOffType(String offType) {
        this.offType = offType;
    }



    public int getDealerId() {
        return dealerId;
    }

    public void setDealerId(int dealerId) {
        this.dealerId = dealerId;
    }


    public String getLprice() {
        return lprice;
    }

    public void setLprice(String lprice) {
        this.lprice = lprice;
    }

    public String getOffCity() {
        return offCity;
    }

    public void setOffCity(String offCity) {
        this.offCity = offCity;
    }

    public String getOprice() {
        return oprice;
    }

    public void setOprice(String oprice) {
        this.oprice = oprice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }



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

    public String getDateE() {
        return dateE;
    }

    public void setDateE(String dateE) {
        this.dateE = dateE;
    }

    public String getDateS() {
        return dateS;
    }

    public void setDateS(String dateS) {
        this.dateS = dateS;
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public FormFile getImg7() {
        return img7;
    }

    public void setImg7(FormFile img7) {
        this.img7 = img7;
    }

    public FormFile getImg8() {
        return img8;
    }

    public void setImg8(FormFile img8) {
        this.img8 = img8;
    }

    public FormFile getImg9() {
        return img9;
    }

    public void setImg9(FormFile img9) {
        this.img9 = img9;
    }

    public FormFile getThumbImg() {
        return thumbImg;
    }

    public void setThumbImg(FormFile thumbImg) {
        this.thumbImg = thumbImg;
    }



    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();

        return errors;
    }
}
