package com.buysell.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.StringTokenizer;



import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SearchUtil {

    Properties p;

    public SearchUtil() {
        populateTypeMap();
    }
    private static Logger LOG = Logger.getLogger(SearchUtil.class);

    public Map getSearchFields(String fields) {
        Map fm = new HashMap();
        List fp = getIndividualFields(fields);
        fm = getFlHashMap(fp);
        LOG.info("5");
        return fm;
    }

    public List getJspFieldsForCatId(int catId) {

        List ll = null, atrList = null;
        atrList = new ArrayList();
        CategoryUtil cu = new CategoryUtil();

        AdvancedTiles at = new AdvancedTiles(catId);
        String dbJsp = at.getSearchFields(catId);
        ll = getIndividualFields(dbJsp);

        if (ll.size() > 0) {
            for (Iterator itr = ll.iterator(); itr.hasNext();) {

                StringTokenizer sk = new StringTokenizer((String) itr.next(), ":");
                if (sk != null) {
                    String atr = null;
                    String fld = null;
                    if (sk.hasMoreTokens()) {
                        fld = sk.nextToken();
                        atr = sk.nextToken();
                    }
                    if (atr != null && !atr.contains("~")) {
                        atrList.add(atr);
                    }

                }

            }
        }



        return atrList;
    }

    public Map getFlHashMap(List fp) {
        List atrList;// = new ArrayList() ;
        Map m = new HashMap();
        if (fp.size() > 0) {
            for (Iterator itr = fp.iterator(); itr.hasNext();) {
                atrList = new ArrayList();
                StringTokenizer sk = new StringTokenizer((String) itr.next(), ":");
                if (sk != null) {
                    String atr = null;
                    String fld = null;
                    if (sk.hasMoreTokens()) {
                        fld = sk.nextToken();
                        atr = sk.nextToken();
                    }
                    if (atr != null && atr.contains("~")) {
                        StringTokenizer skr = new StringTokenizer(atr, "~");
                        while (skr.hasMoreTokens()) {
                            atrList.add(skr.nextToken());
                        }
                    } else {
                        atrList.add(atr);
                    }
                    m.put(fld, atrList);
                }


            }
        }
        LOG.info("4");
        return m;

    }

    public List getIndividualFields(String fields) {
        StringTokenizer sk = new StringTokenizer(fields, "|");
        List tl = new ArrayList();
        if (sk != null) {
            while (sk.hasMoreTokens()) {
                tl.add(sk.nextToken());
            }
        }
        LOG.info("3");
        return tl;
    }

    public String getQueryFromMap(Map m, Map vals, HttpServletRequest request) {
        StringBuilder sb = new StringBuilder();

        Set k = m.keySet();

        int sz = k.size();

        LOG.info("#######" + k);
        if (k != null) {
            Iterator itr = k.iterator();
            int i = 0;
            while (itr.hasNext()) {
                LOG.info("inside while" + itr);


                String key = (String) itr.next();
                if (key != null) {
                    LOG.info("-----------" + key);
                    String q = getQuery(key, vals.get(key), request);
                    if (q != null) {
                        if (i >= 1 && i < sz && !sb.toString().endsWith(" AND ")) {
                            sb.append(" AND ");
                        }
                        sb.append(q);
                    }
                    LOG.info("#######2#######" + sb.toString());
                    i++;
                }
            }
        }
        LOG.info("6");
        return sb.toString();

    }

    private String getQuery(String key, Object O, HttpServletRequest request) {

        List atr = (List) O;
        String tmp = null;
        LOG.info("Inside get Query" + atr);
        LOG.info("++++++++++++++++++++++++++++++++++++++++" + atr.size());
        if (atr != null && atr.size() > 1) {
            if (BuySellProperties.getProperty(key) != null && BuySellProperties.getProperty(key).equalsIgnoreCase("N")) {


                String min = (String) atr.get(0);
                String max = (String) atr.get(1);
                LOG.info(" MIn is " + min + "  Max is " + max);
                String adType = (String) request.getAttribute("adType");
                if (adType != null && adType.trim().length() > 0) {

                    if (adType.equals("offered")) {

                        if (min != null && min.trim().length() > 0 && max != null && max.trim().length() > 0) {
                            tmp = key + " >= " + min + " AND " + key + " <= " + max;
                        } else if (min != null && min.trim().length() > 0) {
                            tmp = key + " >= " + min;
                        } else if (max != null && max.trim().length() > 0) {
                            tmp = key + " <= " + max;
                        }

                    } else if (adType.equals("wanted")) {

                        if (min != null && min.trim().length() > 0 && max != null && max.trim().length() > 0) {
                            tmp = "MINI <= " + min + " AND MAX >= " + min + " AND MINI <= " + max + " AND MAX >= " + max;
                        } else if (min != null && min.trim().length() > 0) {
                            tmp = "MINI <= " + min + " AND MAX >= " + min;
                        } else if (max != null && max.trim().length() > 0) {
                            tmp = "MINI <= " + max + " AND MAX >= " + max;
                        }
                    }
                }

            }
        } else {

            /*if(BuySellProperties.getProperty(key).equalsIgnoreCase("N")){
            tmp = key+" > "+atr.get(0) ;
            LOG.info("++++++++++++++++++++++++++++++++++++++++"+tmp);
            }else {*/
            if (atr.get(0) != null && ((String) atr.get(0)).trim().length() > 0) {
                tmp = key + " LIKE '%" + atr.get(0) + "%'";
            }

        }
        LOG.info("++++++++++++++++++++" + tmp);
        return tmp;
    }

    private void populateTypeMap() {
        p = new Properties();
        try {
            p.load(Thread.currentThread().getContextClassLoader().getResourceAsStream(BuySellProperties.getProperty("typeFile")));
            LOG.info("+1+ file file from resource ++");

        } catch (IOException ex) {
            LOG.info("error occured in populating--" + ex);
        }

    }

    public String test(String s) {
        String q = s;
        Map m = new HashMap();
        List l = new ArrayList();
        l.add("Srikanth");
        m.put("AUTHOR", l);

        List ll = new ArrayList();
        ll.add("JAVA");
        m.put("NAME", ll);

        List lll = new ArrayList();
        lll.add(new Integer(10));
        lll.add(new Integer(20));
        m.put("PRICE", lll);


        LOG.info("+2+");

        LOG.info("$$$" + m.keySet());

        Map mm = getSearchFields(q);

        LOG.info("$$$" + mm.keySet());

        String qq = null;//= getQueryFromMap(mm, m);

        LOG.info("////test ending////");

        return qq;


    }

    /*public String getDbQuery(String dbString , HttpServletRequest req){
    SearchUtil sc = new SearchUtil();
    Map m = sc.getSearchFields(dbString);
    Map mv = new HashMap();

    if(m != null){
    Set keys = m.keySet();
    Iterator itr = keys.iterator();
    for(;itr.hasNext();){
    String dbKey = (String)itr.next();
    List l = (List) m.get(dbKey);
    //currently we are supporting max two values only
    if(l != null){
    List ll = new ArrayList();
    switch(l.size()){
    case 1:
    String atr = req.getParameter((String)l.get(0));
    ll.add(atr);
    break;
    case 2:
    String atr1 = req.getParameter((String)l.get(0));
    String atr2 = req.getParameter((String)l.get(1));
    ll.add(atr1);
    ll.add(atr2);
    break;
    }
    mv.put(dbKey, ll);
    }
    }
    }
    String q = sc.getQueryFromMap(m, mv);

    return q;
    }
     */
}
