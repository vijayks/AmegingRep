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
public class createCategoryFormbean extends org.apache.struts.action.ActionForm {


     private String catNM;
     FormFile catImg;

     private long parentId;

    public long getParentId() {
        return parentId;
    }

    public void setParentId(long parentId) {
        this.parentId = parentId;
    }

    public FormFile getCatImg() {
        return catImg;
    }

    public void setCatImg(FormFile catImg) {
        this.catImg = catImg;
    }
     private String catShrtDesc;

    public String getCatNM() {
        return catNM;
    }

    public void setCatNM(String catNM) {
        this.catNM = catNM;
    }

    public String getCatShrtDesc() {
        return catShrtDesc;
    }

    public void setCatShrtDesc(String catShrtDesc) {
        this.catShrtDesc = catShrtDesc;
    }

    public void reset() {
        this.catNM="";
        this.catImg=null;
        this.parentId=0;
        this.catShrtDesc="";
    }



    /**
     *
     */
    public createCategoryFormbean() {
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
//        if (getName() == null || getName().length() < 1) {
//            errors.add("name", new ActionMessage("error.name.required"));
//            // TODO: add 'error.name.required' key to your resources
//        }
        return errors;
    }
}
