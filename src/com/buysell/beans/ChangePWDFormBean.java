/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author bbsadmin
 */
public class ChangePWDFormBean extends org.apache.struts.action.ActionForm {
    
    private String oldPWD;
    private String newPWD;

    public String getNewPWD() {
        return newPWD;
    }

    public void setNewPWD(String newPWD) {
        this.newPWD = newPWD;
    }

    public String getOldPWD() {
        return oldPWD;
    }

    public void setOldPWD(String oldPWD) {
        this.oldPWD = oldPWD;
    }

   public ChangePWDFormBean() {
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
