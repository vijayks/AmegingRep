/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.actionclass;

import com.buysell.util.BuySellProperties;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import com.buysell.util.StaticCityList;
import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author bbsadmin
 */
public class CitySelectionAction extends org.apache.struts.action.Action
{

private final static String SUCCESS = "success";
    private final static Logger LOG = Logger.getLogger(CitySelectionAction.class);
 CityUtil cu=new CityUtil();
 List cl = null;
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
        LOG.info("AdSearchTilesDisplayAction execute() method started");
//        if(cl == null || cl.size() == 0){
//            cl = cu.viewAllCities();
//            StaticCityList.ll = cl;
//            LOG.debug("= List size ="+cl.size());
//        }
//
//       

       /* al=cu.viewAllCities("india", "ap");
        LOG.info(al);
        */

         LOG.info("Request reveived for view all cities");
               // File countryRootDir = new File(BuySellProperties.getProperty("countryLocation"));
                //String countries[] = countryRootDir.list();
         if(StaticCityList.ll == null || StaticCityList.ll.size() == 0 )       {
             StaticCityList.ll = cu.viewAllCities();
         }
                

//                if (countries != null && countries.length > 0) {
//                    for (int j = 0; j < countries.length; j++) {
//                        String cut = countries[j];
//                        File states = new File(BuySellProperties.getProperty("countryLocation") + cut + "/");
//                        String sa[] = states.list();
//                        if (sa != null) {
//                            for (int i = 0; i < sa.length; i++) {
//                                List lcs = cu.viewAllCities(cut, sa[i]);
//                                if (lcs != null && lcs.size() > 0) {
//                                    for (Iterator it = lcs.iterator(); it.hasNext();) {
//                                        City c = (City) it.next();
//                                        c.setCountry(cut);
//                                        c.setState(sa[i]);
//                                        ll.add(c);
//                                    }
//                                }
//                            }
//                        } else {
//                            LOG.info("No States available in " + BuySellProperties.getProperty("countryLocation") + cu + "/");
//                        }
//                    }
//                } else {
//                    LOG.info("NO country available in path" + BuySellProperties.getProperty("countryLocation"));
//                }

    request.getSession().setAttribute("cities", StaticCityList.ll);


        return mapping.findForward(SUCCESS);
}
}
