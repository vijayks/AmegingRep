/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class CitiSelectorServlet extends HttpServlet {

    private static Logger LOG = Logger.getLogger(CitiSelectorServlet.class);
    CityUtil cUtil = new CityUtil();
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
        LOG.info("citySelectorServlet service() started");
         City cityObj = null;
         List locationsList = null;
        String city = request.getParameter("city");
        if (city != null) {
            Cookie cityCookie = new Cookie("presentCity", city);
            //LOG.info("getMaxAge=" + cityCookie.getMaxAge());
            cityCookie.setMaxAge(360 * 24 * 60 * 60);
            response.addCookie(cityCookie);
            request.getSession().setAttribute("city", city);

            //retriving prev city and get country and state to set to new city object
            //TODO:the below code should be moved to cityUtil

            List  cityClassList = cUtil.viewAllCities();
                String cityName = (String)request.getSession().getAttribute("city");
                if(cityName != null && cityClassList.size() >0){
                    Iterator itr= cityClassList.iterator();
                    while (itr.hasNext()){
                        City c = (City) itr.next();
                        if(c.getName().equals(cityName.trim())){
                            cityObj = c;
                            locationsList = c.getLoc();
                            request.setAttribute("locations",locationsList);
                            break;
                        }
                    }
                }
        }

        if (cityObj == null) {
             cityObj = new City();
            cityObj.setName("All India");
        }
        request.getSession().setAttribute("cityObj", cityObj);
        String url=(String) request.getParameter("url");
        if(url == null || url.equals("null") || url.contains(".ico") || url.contains("rig") || url.equals("/"))
        {
            url="/tile1.do";
        }
        try {
            //String url=request.getRequestURL().toString();
            //String path= request.getServletPath();

            if (url.contains("/ccs")) {
                //String qry = request.getParameter("qry");
                String forwardto = (String) request.getSession().getAttribute("pre");
                if(forwardto==null || forwardto.trim().length()==0) {
                    forwardto = "/tile1.do";
                }
                RequestDispatcher rd = request.getRequestDispatcher(forwardto);
                rd.forward(request, response);

            } else {

                // String qry = request.getParameter("qry");
                String forwardto = url;
                request.getSession().setAttribute("pre", forwardto);
                RequestDispatcher rd = request.getRequestDispatcher(forwardto);
                rd.forward(request, response);
            }


        } finally {
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
