/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.db.DbConnectionPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class CategoryUtil {

    private static List categories;
    private static final String query = "select * from CATEGORY_T ORDER BY DISPLAY_ORDER DESC";
    private static final Logger LOG = Logger.getLogger(CategoryUtil.class);
    private List catIds = new ArrayList();
    private static HashMap hm = new HashMap();
    Connection con;
    ResultSet rs;
    PreparedStatement ps;

    public CategoryUtil() {
        if (categories == null) {
            categories = new ArrayList();
            populateCategories();
        }

    }

    public void forcePopulate() {
        if (categories != null) {
            synchronized (categories) {
                categories.clear();
                populateCategories();
            }
        }
    }

    public static List getCategories() {
        return categories;
    }

    public static void setCategories(List categories) {
        CategoryUtil.categories = categories;
    }

    private void populateCategories() {


        List ll = new ArrayList();

        try {
            con = DbConnectionPool.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    Category cat = new Category();
                    cat.setId(rs.getInt(1));
                    cat.setName(rs.getString(2));
                    cat.setDescription(rs.getString(3));
                    cat.setImagePath(rs.getString(4));
                    cat.setTemplateId(rs.getInt(5));
                    cat.setParent(rs.getInt(6));
                    cat.setCreationDate(rs.getDate(7));
                    cat.setDisplayOrder(rs.getInt(8));
                    String tags = rs.getString(9);
                    if (tags != null && tags.trim().length() > 0) {
                        cat.setTags(getTagList(tags));
                    }
                    ll.add(cat);
                    catIds.add(cat.id);

                }
            }

        } catch (SQLException ex) {
            LOG.error("Not able to crate categories" + ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }

            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }

        populateSubCategories(ll);
        //populateAdCount();
        populateCityAdCount();

        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cat = (Category) itr.next();
                HashMap ccc = (HashMap) cat.cc;

                Set s = ccc.keySet();
                for (Iterator iter = s.iterator(); iter.hasNext();) {
                    String key = (String) iter.next();

                }

            }
        }
        populateCatNamesMAP();

    }

    private List getChildList(List ll, int catId) {
        List l = new ArrayList();
        for (Iterator itr = ll.iterator(); itr.hasNext();) {
            Category cat = (Category) itr.next();
            if (cat.getParent() == catId) {
                l.add(cat);
            }
        }
        return l;
    }

    private List getTagList(String tags) {
        List ll = new ArrayList();
        StringTokenizer st = new StringTokenizer(tags, ",");
        while (st.hasMoreTokens()) {
            String tag = st.nextToken();
            ll.add(tag);
        }
        return ll;

    }

    public Category getCategoryByID(int id) {
        Category cat = null;
        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cats = (Category) itr.next();
                if (id == cats.id) {
                    cat = cats;
                    break;
                }
            }
        }

        return cat;
    }
// this method is used to get the sub cagegory & classification ids when you pass the main category id..

    public int[] getSubCatIds(int id) {
        int i = 0;
        int[] ids = new int[20];
        Category cat = null;
        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cats = (Category) itr.next();
                if (id == cats.parent) {

                    ids[i] = cats.id;

                    if (categories != null && categories.size() > 0) {
                        for (Iterator itr1 = categories.iterator(); itr1.hasNext();) {
                            Category cats1 = (Category) itr1.next();
                            if (ids[i] == cats1.parent) {
                                i++;
                                ids[i] = cats1.id;
                            }
                        }
                    }
                    i++;

                    /*if (ids[i - 1] == cats.parent) {
                    ids[i] = cats.parent;
                    i++;
                    }*/
                }
            }
        }

        return ids;
    }

    /* this metod used in body category to display the classificatons */
    public List getSub(int id) {
        List al = new ArrayList();

        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cats = (Category) itr.next();
                if (cats.getParent() == id) {

                    al.add(cats.getId());
                }
            }
        }
        return al;
    }

    /* this method used to get all childs for the requested category id */
    public ArrayList getAll(int id) {
        ArrayList al = new ArrayList();
        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cats = (Category) itr.next();
                if (cats.getParent() == id) {
                    al.add(cats.getId());

                    for (Iterator itr1 = categories.iterator(); itr1.hasNext();) {
                        Category catc = (Category) itr1.next();
                        if (catc.getParent() == cats.getId() && cats.getId() != 0) {
                            al.add(catc.getId());

                        }
                    }
                }
            }
            al.add(id);
        }
        return al;
    }

    public int getRootCatId(int xx) {
        int rootId = 0;

        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cats = (Category) itr.next();
                if (cats.getId() == xx) {
                    rootId = cats.getParent();
                }
            }
        }

        return rootId;


    }

    public ArrayList getClfCatIdsWithSubCatId(int id) {


        ArrayList al = new ArrayList();

        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cats = (Category) itr.next();
                if (id == cats.getParent()) {
                    al.add(cats.getId());

                }
            }
        }

        return al;
    }

    public String getCategoryNameWithId(int id) {
        String catName = null;


        if (categories != null && categories.size() > 0) {
            for (Iterator itr = categories.iterator(); itr.hasNext();) {
                Category cat = (Category) itr.next();
                if (id == cat.id) {
                    catName = cat.name;
                }
            }
        }

        return catName;
    }

    private void populateSubCategories(List ll) {
        if (ll.size() > 0) {
            for (Iterator itr = ll.iterator(); itr.hasNext();) {
                Category cat = (Category) itr.next();

                cat.setSubCategories(getChildList(ll, cat.getId()));

                categories.add(cat);
            }

        }

    }

    public List getCategoryIDs() {
        return catIds;
    }

    private void populateCityAdCount() {

        con = DbConnectionPool.getConnection();
        String qry = "SELECT CATEGORY_ID , COUNT(*),CITY FROM AD_T,ADDRESS_T,AD_FIELDS  WHERE STATUS=1 AND AD_T.AD_ID = AD_FIELDS.AD_ID  AND  AD_FIELDS.ADD_ID=ADDRESS_T.ADDRESS_ID GROUP BY CITY,CATEGORY_ID";
        try {
            ps = con.prepareStatement(qry);
            rs = ps.executeQuery();
            if (rs != null) {
                AddCountUtil.hm = new HashMap();
                while (rs.next()) {
                    LOG.info("cid=" + rs.getInt(1) + "  city=" + rs.getString(3) + "  adsCount=" + rs.getInt(2));
                    Category cat = getCategoryByID(rs.getInt(1));
                    if (cat != null) {
                        cat.setCityCount(rs.getString(3), rs.getInt(2));
                        cat.setCityCount("All India", cat.getCityCount("All India") + rs.getInt(2));
                        LOG.info(" Adding count to category" + cat.getId() + " .... city  " + rs.getString(3) + " count " + rs.getString(2));
                        AddCountUtil.addAddCountByCatID(String.valueOf(cat.getId()), rs.getInt(2), rs.getString(3));
                        AddCountUtil.addAddCountByCatID(String.valueOf(cat.getId()), (AddCountUtil.getAddCountByCatID(String.valueOf(cat.getId()), "All India") + rs.getInt(2)), "All India");
                        Category cat2 = getCategoryByID(cat.getParent());
                        if (cat2 != null) {
                            cat2.setTotalSubCatAdCount(rs.getString(3), cat2.getTotalSubCatAdCount(rs.getString(3)) + rs.getInt(2));
                            cat2.setTotalSubCatAdCount("All India", cat2.getTotalSubCatAdCount("All India") + rs.getInt(2));
                        } else {
                            LOG.error("Parent Category is not found with given chield id");
                        }
                    } else {
                        LOG.error("Category with given id is not found");
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Error In CityAdCount Population :" + e);
        } finally {
            try {
                 if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    DbConnectionPool.closeConnection(con);
                }

            } catch (Exception e) {
                LOG.error("= Exception Occured in closing db connections ::=" + e);
            }
        }

    }

    private void populateCatNamesMAP() {
        Iterator itr = categories.iterator();
        if (itr != null) {
            for (; itr.hasNext();) {
                Category cat = (Category) itr.next();
                CatIDName cin = new CatIDName();
                cin.id = cat.id;
                cin.name = cat.name;
                if (cat.parent > 0) {
                    Category catp = getCategoryByID(cat.parent);
                    cin.parent = catp.name;
                    if (catp.parent > 0) {
                        Category catsp = getCategoryByID(catp.parent);
                        cin.superParent = catsp.name;
                    }
                }
                hm.put(String.valueOf(cin.id), cin);
            }
        }

    }

    public static CatIDName getCINForCatId(String id) {
        return (CatIDName) hm.get(id);
    }

    public class CatIDName {

        int id;
        String parent;
        String name;
        String superParent;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getParent() {
            return parent;
        }

        public void setParent(String parent) {
            this.parent = parent;
        }

        public String getSuperParent() {
            return superParent;
        }

        public void setSuperParent(String superParent) {
            this.superParent = superParent;
        }
    }
}
