/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.UserBean;
import com.buysell.util.UrlPointsUtil;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class UrlFilter implements Filter {

    private static final boolean debug = true;
    private static Logger LOG = Logger.getLogger(UrlFilter.class);
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public UrlFilter() {
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
    UrlPointsUtil upu = new UrlPointsUtil();

        HttpSession session = ((HttpServletRequest) request).getSession();
        String path = ((HttpServletRequest) request).getServletPath();
        UserBean ub = (UserBean) ((HttpServletRequest) request).getSession().getAttribute("userBean");

        if (ub != null) {
            int bbspc = 0;
            if (((HttpServletRequest) request).getSession().getAttribute("bbspc") == null) {
                bbspc = 5;
                ((HttpServletRequest) request).getSession().setAttribute("bbspc", bbspc);
            } else {
                bbspc = (Integer) ((HttpServletRequest) request).getSession().getAttribute("bbspc");
                HashMap<String, Integer> hp = upu.getUrlPoints();
                String s = path;
                s = s.substring(s.indexOf("/") + 1, s.indexOf("."));
                if (path.indexOf("/bs/") > -1) {
                    s = "bs";
                }
                if (hp.containsKey(s)) {
                    bbspc += hp.get(s);
                    ((HttpServletRequest) request).getSession().setAttribute("bbspc", bbspc);
                }
            }

        }
        chain.doFilter(request, response);


    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter 
     */
    public void destroy() {
    }

    /**
     * Init method for this filter 
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
        }
    }
}
