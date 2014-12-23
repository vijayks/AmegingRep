/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author root
 */
public class UserActionForm extends org.apache.struts.action.ActionForm {

    private String loginName;
    private String userId;
    private String pwd;
    private String isValid;
    public FormFile imgfile;

    public FormFile getImgfile() {
        return imgfile;
    }

    public void setImgfile(FormFile imgfile) {
        this.imgfile = imgfile;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

   
    public FormFile getFile() {
        return imgfile;
    }

    public void setFile(FormFile imgfile) {
        this.imgfile = imgfile;
    }

    

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid;
    }



   /* public UserActionForm() {
        super();
        // TODO Auto-generated constructor stub
    }

       public void reset(ActionMapping mapping, HttpServletRequest request) {
        loginName = null;
        pwd = null;
        isValid=null;

    }*/


    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
   /* public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        if (getLoginName() == null || getLoginName().length() < 1) {
            errors.add("name", new ActionMessage("error.name.required"));
            // TODO: add 'error.name.required' key to your resources
        }
        return errors;
    }*/
}