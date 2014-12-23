/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class CategorySearch {
 private static final Logger LOG = Logger.getLogger(CategorySearch.class);
    public HashMap getSuggStrings(String str) {
        str = " "+str.trim();
        HashMap hm = new HashMap();
        LOG.info("Inside search action to fetch "+str);
        List ll = CategoryUtil.getCategories();
        CategoryUtil cu = new CategoryUtil();
        if (ll != null && ll.size() > 0) {
            for (Iterator itr = ll.iterator(); itr.hasNext();) {
                Category c = (Category) itr.next();
                if (c.getName().toLowerCase().startsWith(str.trim().toLowerCase())||c.getName().toLowerCase().contains(str.toLowerCase())) {
                    int parent = c.getParent();
                    if (parent > 0) {
                        Category p = cu.getCategoryByID(parent);
                        int pp = p.getParent();
                        if (pp > 0) {
                            Category sp = cu.getCategoryByID(pp);
                            hm.put(c.getId(), sp.getName() + "-->" + p.getName() + "-->" + c.getName());
                        } else {
                            List csl = c.getSubCategories();
                            if (csl.size() > 0) {
                                for (Iterator itrs = csl.iterator();itrs.hasNext();) {
                                    Category cs = (Category)itrs.next();
                                     //LOG.info(p.getName()+"-->"+c.getName()+"-->"+cs.getName()+" Adding because 2 contain "+str);
                                    hm.put(cs.getId(), p.getName()+"-->"+c.getName()+"-->"+cs.getName());
                                }
                            }
                        }
                    }else {
                        List csl = c.getSubCategories();
                        if(csl.size() > 0){
                            for(Iterator it = csl.iterator();it.hasNext();){
                                Category cs = (Category) it.next();
                                List cscsl = cs.getSubCategories();
                                if(cscsl.size() >0){
                                    for(Iterator ii= cscsl.iterator();ii.hasNext();){
                                        Category csll = (Category) ii.next();
                                        // LOG.info(c.getName()+"-->"+cs.getName()+"-->"+csll.getName()+" Adding because 1 contain "+str);
                                        hm.put(csll.getId(), c.getName()+"-->"+cs.getName()+"-->"+csll.getName());
                                    }
                                }
                            }
                        }
                    }

                }

            }
        }
        //LOG.info("HM constructed is "+hm);
        return hm;

    }
}
