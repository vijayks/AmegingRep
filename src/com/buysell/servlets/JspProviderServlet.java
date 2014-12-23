/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.servlets;

import com.buysell.util.TemplateTiles;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts.tiles.ComponentDefinition;
import org.apache.struts.tiles.TilesUtil;

/**
 *
 * @author bbsadmin
 */
public class JspProviderServlet extends HttpServlet {
    private static Logger LOG = Logger.getLogger(JspProviderServlet.class);
    TilesUtil tu = new TilesUtil();
    
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
        String clfid=request.getParameter("clfId");
        List ll = new ArrayList();
        if(clfid!=null && clfid.trim().length()>0){
            int id = Integer.parseInt(clfid);
            TemplateTiles tt = new TemplateTiles(id);
            ll = tt.getTileList(id);
            if(ll!=null){
                if(ll.contains("login"))
                    ll.remove("login");
                if(ll.contains("cselect"))
                    ll.remove("cselect");
                if(ll.contains("addcon"))
                    ll.remove("addcon");
                if(ll.contains("submit"))
                    ll.remove("submit");
            }
        }
        InputStream is = null;
        try {
                ComponentDefinition cd = new ComponentDefinition();

                cd = tu.getDefinition(".tile.adLayout", request, getServletContext());
                Map mp = cd.getAttributes();
                ArrayList jsp=new ArrayList();
                if(ll!=null && ll.size()>0 && !mp.isEmpty()) {
                    for(int i=ll.size()-1;i>=0;i--){
                        if(mp.containsKey(ll.get(i)))
                            jsp.add(mp.get(ll.get(i)));
                    }
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher((String)jsp.get(0));
                rd.include(request, response);
                if(jsp.size()==2) {
                    out.println("<br/>");
                    out.println("^^^price^^^");
                    out.println("<br/>");
                    rd = getServletContext().getRequestDispatcher((String)jsp.get(1));
                    rd.include(request, response);
                }
            
                out.flush();
        }  catch(Exception e){
                LOG.error("Exception occurred "+e);
        } finally {
            if(is!=null)
                is.close();
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
