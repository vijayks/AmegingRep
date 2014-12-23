/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.servlets;

import com.buysell.comand.CommandIntr;
import com.buysell.comand.FetchAddCommand;
import com.buysell.comand.PopulateCategoryCommand;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.StringTokenizer;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class RefreshServlet extends HttpServlet {

    HashMap hm = new HashMap();
    private final static Logger LOG = Logger.getLogger(RefreshServlet.class);

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
        try {
            String comm = request.getParameter("cmd");
            if(comm!= null && comm.trim().length() >0){
                out.write("SUCCESS");
                out.flush();
                executeCommand(comm);
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

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        LOG.info("Populating the Commands");
        hm.put("NAD", new FetchAddCommand());
        hm.put("POP", new PopulateCategoryCommand());
    }

 public void executeCommand(String command){
        LOG.info("Received command "+command);
        StringTokenizer str = new StringTokenizer(command,"$");
        String comm = str.nextToken();
        CommandIntr cmd = (CommandIntr) hm.get(comm);
        cmd.execute(command);
    }


}
