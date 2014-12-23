/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class AddCountUtil {

    static HashMap hm = new HashMap();
    private static Logger LOG = Logger.getLogger(AddCountUtil.class);

    public static int getAddCountByCatID(String id, String cityName) {
        int i = 0;
        HashMap cmp = (HashMap) hm.get(cityName);
        if (cmp != null) {
            String s = (String) cmp.get(id);
            if (s != null) {
                try {
                    i = Integer.parseInt(s);
                } catch (NumberFormatException e) {
                    LOG.error(" NOt able to convert " + s + " to number " + e);
                }
            }

        }
      //  LOG.debug("Total adds available for category " + id + " is " + i);
        return i;
    }

    public static void addAddCountByCatID(String catId, int count, String cityName) {
        HashMap cmp = (HashMap) hm.get(cityName);
        if (cmp == null) {
            cmp = new HashMap();
            hm.put(cityName, cmp);
        }
        cmp.put(catId, String.valueOf(count));
    }

    public static void incAddCountByCatId(String caId, int inc, String cityName) {

        CategoryUtil cu = new CategoryUtil();

        int i = 0;
        HashMap cmap = (HashMap) hm.get(cityName);
        if (cmap != null) {

            String s = (String) cmap.get(caId);
            if (s != null) {
                try {
                    i = Integer.parseInt(s);
                } catch (NumberFormatException e) {
                    LOG.error(" NOt able to convert " + s + " to number " + e);
                }
            }
        } else {
            cmap = new HashMap();
            hm.put(cityName, cmap);
        }
        i = i + inc;
        cmap.put(caId, String.valueOf(i));

        i = 0;
        cmap = (HashMap) hm.get("All India");
        if (cmap != null) {

            String s = (String) cmap.get(caId);
            if (s != null) {
                try {
                    i = Integer.parseInt(s);
                } catch (NumberFormatException e) {
                    LOG.error(" NOt able to convert " + s + " to number " + e);
                }
            }
        } else {
            cmap = new HashMap();
            hm.put("All India", cmap);
        }
        i = i + inc;
        cmap.put(caId, String.valueOf(i));




        Category cat1 = null;
        try {

            cat1 = cu.getCategoryByID(Integer.parseInt(caId));
        } catch (Exception e) {
            LOG.error(" Error to convert String to Number");
        }

        if (cat1 != null) {

            cat1.setCityCount(cityName, inc);
            cat1.setCityCount("All India", cat1.getCityCount("All India") + inc);

            Category cat2 = cu.getCategoryByID(cat1.getParent());

            if (cat2 != null) {
                cat2.setTotalSubCatAdCount(cityName, cat2.getTotalSubCatAdCount(cityName) + inc);
                cat2.setTotalSubCatAdCount("All India", cat2.getTotalSubCatAdCount("All India") + inc);
            } else {
                LOG.error("Parent Category is not found with given chield id");
            }
        }


    }
}
