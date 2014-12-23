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
public class RSFM extends org.apache.struts.action.ActionForm {

    private String atr;
    private String nm;
    private Float minPrc;
    private Float maxPrc;

    public String getAtr() {
        return atr;
    }

    public void setAtr(String atr) {
        this.atr = atr;
    }

    public Float getMaxPrc() {
        return maxPrc;
    }

    public void setMaxPrc(Float maxPrc) {
        this.maxPrc = maxPrc;
    }

    public Float getMinPrc() {
        return minPrc;
    }

    public void setMinPrc(Float minPrc) {
        this.minPrc = minPrc;
    }

    public String getNm() {
        return nm;
    }

    public void setNm(String nm) {
        this.nm = nm;
    }
    
    
    public RSFM() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        if (true) {
            errors.add("name", new ActionMessage("error.name.required"));
            // TODO: add 'error.name.required' key to your resources
        }
        return errors;
    }
}
