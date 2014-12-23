/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.beans;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class CategoryFormBean extends org.apache.struts.action.ActionForm {

    private ArrayList results = null;
    
           public ArrayList getResults() {
        return results;
    }

    public void setResults(ArrayList results) {
        this.results = results;
    }

    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        return errors;
    }
}
