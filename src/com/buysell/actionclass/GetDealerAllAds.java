/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.actionclass;

import com.buysell.beans.DealerBean;
import com.buysell.beans.DealerMoreInfo;
import com.buysell.beans.UserBean;
import com.buysell.db.DbConnectionPool;
import com.buysell.servlets.DealerService;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.buysell.util.CityUtil;
import java.sql.SQLException;
import java.util.StringTokenizer;

/**
 *
 * @author bbsadmin
 */
public class GetDealerAllAds extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String NODEALER = "failure";
    private static final Logger LOG = Logger.getLogger(GetDealerAllAds.class);
    CityUtil cUtil = new CityUtil();
    DealerService ds = new DealerService();
    List cityClassList;

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList alD;
        String userId;
        LOG.debug(" GetDealerAllAds EXECUTE() started");
        long did = 0;
        int uid = 0;
        if (request.getParameter("Did") != null && request.getParameter("Did").trim().length() > 0) {
            try {
                did = Long.parseLong(request.getParameter("Did"));
            } catch (Exception e) {
                LOG.error("Execption occured " + e);
            }
        }
        LOG.debug("dealerId:" + did);
        if (request.getParameter("Uid") != null && request.getParameter("Uid").trim().length() > 0) {
            try {
                uid = Integer.parseInt(request.getParameter("Uid"));
            } catch (Exception e) {
                LOG.error("Execption occured " + e);
            }
        }
        if (did == 0) {
            did = ds.getDealerId(uid);
            LOG.debug("dealerId:" + did);
        }
        if (did != 0) {
            DealerMoreInfo dmi = ds.getDealerMoreInfo(did);
            if (dmi != null) {
                if (dmi.getProducts() != null && dmi.getProducts().toString().trim().length() > 0) {
                    ArrayList pd = new ArrayList();
                    StringTokenizer str3 = new StringTokenizer(dmi.getProducts(), "|");
                    while (str3.hasMoreTokens()) {
                        pd.add((String) str3.nextToken());
                    }
                    request.setAttribute("products", pd);
                }
//                Karteek
                if (dmi.getProductImages() != null && dmi.getProductImages().toString().trim().length() > 0) {
                    ArrayList im = new ArrayList();
                    StringTokenizer str3 = new StringTokenizer(dmi.getProductImages(), "|");
                    while (str3.hasMoreTokens()) {
                        im.add((String) str3.nextToken());
                    }
                    request.setAttribute("images", im);
                }
//                /Karteek
                request.setAttribute("dAdBean", dmi);

                request.setAttribute("domainNM", dmi.getCompName());
                userId = ds.getUserId(String.valueOf(did));

                alD = ds.getDealerAllAds(userId);
                request.setAttribute("ab", alD);
                request.setAttribute("dId", did);

                cityClassList = new ArrayList();
                cityClassList = cUtil.viewAllCities();
                request.getSession().setAttribute("cities", cityClassList);

                return mapping.findForward(SUCCESS);
            }
        }
        return mapping.findForward(NODEALER);
    }
}
