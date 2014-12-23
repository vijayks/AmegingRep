/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class Demo {

    private final static Logger LOG = Logger.getLogger(Demo.class);

    public String getDbQuery(String dbString, HttpServletRequest req, StringBuffer alertPattern, StringBuffer queryString) {
        LOG.info("inside getDbQuery method");

        SearchUtil sc = new SearchUtil();

        Map m = sc.getSearchFields(dbString);

        Map mv = new HashMap();

        if (m != null) {

            Set keys = m.keySet();

            Iterator itr = keys.iterator();
            //  StringBuffer sbf = new StringBuffer();

            for (; itr.hasNext();) {

                String dbKey = (String) itr.next();

                List l = (List) m.get(dbKey);

                //currently we are supporting max two values only
                if (l != null) {

                    List ll = new ArrayList();

                    switch (l.size()) {

                        case 1:
                            String atr = req.getParameter((String) l.get(0));
                            req.setAttribute((String) l.get(0), atr);//setting specific parameters in request object to redisplay in refine search box
                            if (atr != null && atr.trim().length() > 0) {
                                queryString.append("&" + (String) l.get(0) + "=" + atr);//setting url corresponds to specific tile
                                alertPattern.append("|" + (String) l.get(0) + "^" + atr);// setting pattern for alerts with special fields
                            }
                            ll.add(atr);
                            break;
                        case 2:
                            String atr1 = req.getParameter((String) l.get(0));

                            if (atr1 != null && atr1.trim().length() > 0) {
                                req.setAttribute((String) l.get(0), atr1);
                                queryString.append("&" + (String) l.get(0) + "=" + atr1);

                            }



                            String atr2 = req.getParameter((String) l.get(1));

                            if (atr2 != null && atr2.trim().length() > 0) {
                                req.setAttribute((String) l.get(1), atr2);
                                queryString.append("&" + (String) l.get(1) + "=" + atr2);


                            }

                            if (atr1 != null && atr1.trim().length() > 0 && atr2 != null && atr2.trim().length() > 0) {
                                alertPattern.append("|price^" + atr1 + "-" + atr2);
                            } else if (atr1 != null && atr1.trim().length() > 0) {
                                alertPattern.append("|price^" + atr1 + "-"+atr1);

                            } else if (atr2 != null && atr2.trim().length() > 0) {
                                alertPattern.append("|price^"+atr2+"-" + atr2);

                            }

                            ll.add(atr1);
                            ll.add(atr2);
                            break;
                    }
                    mv.put(dbKey, ll);
                }
            }
           
           
        }
        String q = sc.getQueryFromMap(m, mv, req);
        LOG.info("13");
        return q;
    }
}
