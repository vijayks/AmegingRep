/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.siteAdds;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**

 * @author bbsadmin
 */
public class AddServer extends HttpServlet {

    private static Logger LOG = Logger.getLogger(AddServer.class);
    AddManager addManger;

    @Override
    public void init() throws ServletException {
        super.init();
        addManger = new AddManager();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        List ads = new ArrayList();
        Random r=new Random();
         int ran=r.nextInt(10);
        ads = addManger.getAdds(10);
        StringBuffer sb = new StringBuffer();
       // int type = Integer.parseInt(request.getParameter("type"));
        sb.append("<response>");

        if (ads != null && ads.size() > 0) {

           // for (Iterator it = ads.iterator(); it.hasNext();)
            {
                try {
                    SiteAdd sa = (SiteAdd) ads.get(ran);//it.next();
                    if (sa.getSPlace() == 1) {
                        sb.append("<siteAdd1 url=\"" + sa.getUrl() + "\" page= \"" + sa.getPage() + "\" place=\"" + sa.getSPlace() + "\" duration=\"" + sa.getDuration() + "\" image=\"" + sa.getImg() + "\" type=\"" + sa.getType() + "\" />");
                    } else if (sa.getSPlace() == 2) {
                        sb.append("<siteAdd2 url=\"" + sa.getUrl() + "\" page= \"" + sa.getPage() + "\" place=\"" + sa.getSPlace() + "\" duration=\"" + sa.getDuration() + "\" image=\"" + sa.getImg() + "\" type=\"" + sa.getType() + "\" />");
                    } else if (sa.getSPlace() == 3) {
                        sb.append("<siteAdd3 url=\"" + sa.getUrl() + "\" page= \"" + sa.getPage() + "\" place=\"" + sa.getSPlace() + "\" duration=\"" + sa.getDuration() + "\" image=\"" + sa.getImg() + "\" type=\"" + sa.getType() + "\" />");
                    }else if (sa.getSPlace() == 4) {
                        sb.append("<siteAdd3 url=\"" + sa.getUrl() + "\" page= \"" + sa.getPage() + "\" place=\"" + sa.getSPlace() + "\" duration=\"" + sa.getDuration() + "\" image=\"" + sa.getImg() + "\" type=\"" + sa.getType() + "\" />");
                    } else if (sa.getSPlace() == 5) {
                        sb.append("<siteAdd3 url=\"" + sa.getUrl() + "\" page= \"" + sa.getPage() + "\" place=\"" + sa.getSPlace() + "\" duration=\"" + sa.getDuration() + "\" image=\"" + sa.getImg() + "\" type=\"" + sa.getType() + "\" />");
                    }



                } catch (Exception e) {
                    LOG.info("== Error in getting site ads list ==" + e);
                }
            }
        }
        sb.append("</response>");
        out.println(sb);
       // LOG.debug("== generated xml for site ads  ==" + sb);
        out.flush();
        out.close();
    }

    @Override
    public void destroy() {
        addManger.stopAll();
    }
}
