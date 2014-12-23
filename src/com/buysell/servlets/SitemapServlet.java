/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.servlets;

import com.buysell.db.DbConnectionPool;
import com.buysell.util.BuySellProperties;
import com.buysell.util.Category;
import com.buysell.util.CategoryUtil;
import com.buysell.util.URlUtil;
import com.sri.sitemap.SiteMap;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class SitemapServlet extends HttpServlet {

    CategoryUtil cu = new CategoryUtil();
    private static Logger LOG = Logger.getLogger(SitemapServlet.class);
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        SiteMap sm = new SiteMap();
        String dfUrls = BuySellProperties.getProperty("defaultSMUrls");
        String catSMUrl = BuySellProperties.getProperty("catSMUrl");
        String adSMUrl = BuySellProperties.getProperty("adSMUrl");
        String smQuery = BuySellProperties.getProperty("SMQuery");
        String smPath = BuySellProperties.getProperty("site-map.path");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res=null;
        try {
            if(smQuery!=null &&  smQuery.trim().length()>0) {
            con = DbConnectionPool.getConnection();
            ps=con.prepareStatement(smQuery);
            rs=ps.executeQuery();
            if(rs!=null) {
                while (rs.next()) {
                    if(rs.getString(1)!=null && rs.getString(1).trim().length()>0 && rs.getLong(2)!=0 && rs.getLong(3)!=0){
                        String aurl=URlUtil.getUrlString(rs.getString(1), String.valueOf(rs.getLong(2)), String.valueOf(rs.getLong(3)));
                        if(adSMUrl != null && adSMUrl.trim().length()>0 && aurl != null && aurl.trim().length()>0) {
                            sm.addUrlInfo(adSMUrl.concat(aurl),null,"monthly","1.0");
                        }
                    }
                }
            }
            }
        } catch(Exception e) {
            LOG.error("Error occurred while retrieving ads list "+e);
        } finally {
            if(rs!=null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    LOG.error("Error occurred while closing ResultSet "+e);
                }
            }
            if(ps!=null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    LOG.error("Error occurred while closing PreparedStatement "+e);
                }
            }
            if(con!=null) {
                DbConnectionPool.closeConnection(con);
            }
        }
        if(dfUrls != null && dfUrls.trim().length()>0 ) {
            StringTokenizer st = new StringTokenizer(dfUrls, "-");
            while (st.hasMoreTokens()) {
                String ur = st.nextToken();
                if(ur!=null && ur.trim().length()>0) {
                    sm.addUrlInfo(ur,null,null,"0.7");
                }
            }
        }
        List cgl = cu.getCategories();
        if(cgl!=null && cgl.size() > 0) {
            for(Iterator it = cgl.iterator();it.hasNext();) {
                Category cat = (Category) it.next();
                if(cat.getParent()==0) {
                    List subCats=cat.getSubCategories();
                    if(subCats != null && subCats.size()>0) {
                        for(Iterator it1 = subCats.iterator(); it1.hasNext();) {
                            Category ct = (Category) it1.next();
                            if(ct!=null && ct.getName()!=null && ct.getName().trim().length()>0 && ct.getId()>0) {
                                String curl=ct.getName().trim().replaceAll("&amp;", "&").replaceAll(" ", "-").replaceAll("/", "-")+"-sc"+ct.getId()+".in";
                                if(catSMUrl != null && catSMUrl.trim().length()>0 && curl != null && curl.trim().length()>0) {
                                    sm.addUrlInfo(catSMUrl.concat(curl),null,null,"0.8");
                                }
                            }
                        }
                    }
                }
            }
        }
        if(smPath!=null && smPath.trim().length()>0) {
            sm.generateSiteMap(smPath);
            res="Sitemap Generated Successfully";
        }
        try{

        } finally {
            out.write(res);
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
