/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.servlets;

import com.buysell.beans.UserBean;
import com.buysell.util.BuySellProperties;
import com.buysell.util.City;
import com.buysell.util.CityUtil;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class CityFilter implements Filter {

    String url = null;
    private FilterConfig filterConfig = null;
    private static Logger LOG = Logger.getLogger(CityFilter.class);
    ArrayList al = new ArrayList();
    String mlnal = null; //mlnal - mobile login not availble links
    CityUtil cUtil = new CityUtil();

    public CityFilter() {
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
        //LOG.info("CityFilter Called1");
        HttpSession session = ((HttpServletRequest) request).getSession();
        String path = ((HttpServletRequest) request).getServletPath();
        Cookie[] ck = ((HttpServletRequest) request).getCookies();
        String city = (String) session.getAttribute("city");
        String rCity = ((HttpServletRequest) request).getParameter("city");
        Object ctl = session.getAttribute("cities");
        String subDomain = null;
        UserBean ub = (UserBean) ((HttpServletRequest) request).getSession().getAttribute("userBean");
        if (request.getParameter("dmc") != null && request.getParameter("dmc").trim().length() > 0) {
            String cls = request.getParameter("dmc").toString();
            ((HttpServletRequest) request).getSession().setAttribute("dealerMenuClass", cls);
        }

        String ur = ((HttpServletRequest) request).getRequestURL().toString();
        ur = ur.substring(ur.indexOf("//") + 2);
        ur = ur.substring(0, ur.indexOf("/"));
        if (ur.indexOf(".") != ur.lastIndexOf(".")) {
            int endIndex = ur.indexOf(".");
            subDomain = ur.substring(0, endIndex);

        }
        if (ctl == null) {
            List cityClassList = new ArrayList();
            cityClassList = cUtil.viewAllCities();
            ((HttpServletRequest) request).getSession().setAttribute("cities", cityClassList);
        }
        if (subDomain == null || subDomain.equals("www") || subDomain.equals("192")) {
            //dmc---->DealerMenuClass,  cls---->class,   This is for accordion in MyAccount_menu
            if (path.equals("/")) {
                ((HttpServletRequest) request).getSession().setAttribute("surl", path);
                String rdPath = url;
                if (city == null || (rCity != null && rCity.equals("All India"))) {
                    rdPath = url + "&city=All India";
                }
                RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(rdPath);
                rd.forward(request, response);
            } else if (path.contains("/ccs-")) {
                ((HttpServletRequest) request).getSession().setAttribute("surl", "/tile1.do");
                String cty = "All India";
                String ct = path.substring(path.indexOf("/ccs-") + 5);
                if (ct != null && ct.length() > 0) {
                    cty = ct;
                }
                String rdPath = "/ccs?url=/tile1.do&city=" + cty;
                RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(rdPath);
                rd.forward(request, response);
            } else if ((path.contains("-cl") || path.contains("-sc")) && path.contains(".in")) { // for classification and sub category urls
                String rdPath = "";
                String pms;
                int clfId = 0;
                int subCatId = 0;
                pms = path.substring(path.lastIndexOf("-") + 1, path.lastIndexOf(".in"));
                if (pms != null) {
                    if (pms.indexOf("cl") > -1) {
                        String clf = pms.substring(2, pms.indexOf("cs"));
                        String sc = pms.substring(pms.indexOf("cs") + 2, pms.length());
                        if (clf != null && sc != null && clf.trim().length() > 0 && sc.trim().length() > 0 && Character.isDigit(clf.charAt(0)) && Character.isDigit(sc.charAt(0))) {
                            try {
                                clfId = Integer.parseInt(clf);
                                subCatId = Integer.parseInt(sc);
                            } catch (Exception e) {
                                LOG.error("Exception occurred " + e);
                            }
                        }
                    } else if (pms.indexOf("sc") > -1) {
                        String sc = pms.substring(pms.indexOf("sc") + 2, pms.length());
                        if (sc != null && sc.trim().length() > 0 && Character.isDigit(sc.charAt(0))) {
                            try {
                                subCatId = Integer.parseInt(sc);
                            } catch (Exception e) {
                                LOG.error("Exception occurred " + e);
                            }
                        }
                    }
                }
                if (rCity != null && rCity.trim().length() > 0) {
                    Cookie cityCookie = new Cookie("presentCity", rCity);
                    cityCookie.setMaxAge(360 * 24 * 60 * 60);
                    HttpServletResponse resp = (HttpServletResponse) response;
                    resp.addCookie(cityCookie);
                    session.setAttribute("city", rCity);

                    List cityClassList = cUtil.viewAllCities();
                    String cityName = (String) session.getAttribute("city");
                    City cityObj = null;
                    if (cityName != null && cityClassList.size() > 0) {
                        Iterator itr = cityClassList.iterator();
                        while (itr.hasNext()) {
                            City c = (City) itr.next();
                            if (c.getName().equals(cityName.trim())) {
                                cityObj = c;
                                List locationsList = c.getLoc();
                                request.setAttribute("locations", locationsList);
                                break;
                            }
                        }
                    }
                    if (cityObj == null) {
                        cityObj = new City();
                        cityObj.setName("All India");
                    }
                    session.setAttribute("cityObj", cityObj);
                }
                if (city == null) {
                    session.setAttribute("city", "All India");
                }
                if (subCatId <= 0) {
                    rdPath = "/tile1.do";
                    if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                        rdPath = BuySellProperties.getProperty("localurl") + rdPath;
                    }
                    ((HttpServletResponse) response).sendRedirect(rdPath);
                } else {
                    if (clfId <= 0) {
                        rdPath = "/clf.do?subCatId=" + subCatId;
                    } else {
                        String start = request.getParameter("start") != null ? request.getParameter("start") : "0";
                        String range = request.getParameter("range") != null ? request.getParameter("range") : BuySellProperties.getProperty("middle");
                        String oBy = request.getParameter("byO") != null ? request.getParameter("byO") : "1";
                        rdPath = "/displayClfAds.do?clfId=" + clfId + "&subCatId=" + subCatId + "&start=" + start + "&range=" + range + "&byO=" + oBy;
                        if (request.getParameter("adType") != null) {
                            rdPath += "&adType=" + request.getParameter("adType");
                        }
                    }
                    ((HttpServletRequest) request).getSession().setAttribute("surl", "catCityChange" + path);
                    RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(rdPath);
                    rd.forward(request, response);
                }
            } else if (!(("/" + url).equals(path)) && !(path.startsWith("/bs")) && !(path.startsWith("/rs")) && !(path.startsWith("/bc")) && !(path.startsWith("/ima")) && !(path.startsWith("/bbsimage")) && !(path.startsWith("/resourceGet")) && !(path.startsWith("/css")) && !(path.startsWith("/js")) && !(path.startsWith("/siteAds")) && !(path.startsWith("/scroll")) && !(path.startsWith("/regChk")) && !(path.startsWith("/globalHome")) && !(path.startsWith("/myAccountNL")) && !(path.startsWith("/logout")) && !(path.startsWith("/robots.txt")) && !(path.startsWith("/bidref")) && !(path.startsWith("/highslid"))) {
                ((HttpServletRequest) request).getSession().setAttribute("surl", path);
                // LOG.debug("path="+BuySellProperties.getProperty(path));
                if (BuySellProperties.getProperty(path) != null) {
                    StringBuilder sb = new StringBuilder("&");
                    for (Enumeration e = ((HttpServletRequest) request).getParameterNames(); e.hasMoreElements();) {
                        String param = e.nextElement().toString();
                        if (!param.equals("url") && !param.equals("city") && !param.equals("range") && !param.equals("start") && !param.equals("byO") && !param.equals("lcs")) {
                            sb.append(param).append("=").append(request.getParameter(param)).append("&");
                        }
                    }
                    String queryString = sb.toString().substring(0, sb.length() - 1);

                    ((HttpServletRequest) request).setAttribute("queryString", queryString);
                    LOG.debug("\nqueryString=" + queryString + "\n");
                }


                if (ub != null && ub.getLoginType().equals("LOGIN WITH MOBILE NUMBER")) {
                    if (!al.contains(path.trim())) {
                        chain.doFilter(request, response);
                    } else {
                        RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher("/mobileLogin.do");
                        rd.forward(request, response);
                    }
                } else if (path.indexOf("/dd-") > -1) {
                    LOG.debug("dealer URL change is applying");

                    String[] ss = path.split("/");
                    if (ss != null && ss.length > 2) {
                        String dId;
                        dId = path.substring(path.lastIndexOf(ss[1]) + 3, path.lastIndexOf(ss[2]) - 1);
                        String ddPath = "/dealerMoreDetails.do?dlId=" + dId;
                        RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(ddPath);
                        rd.forward(request, response);
                    } else {
                        LOG.error("Exception occurred " + path);
                    }

                } else if (path.indexOf("/allAds-") > -1) {
                    LOG.debug("dealer All Ads URL change is applying");

                    String[] ss = path.split("/");
                    if (ss != null && ss.length > 2) {
                        String dId1;
                        dId1 = path.substring(path.lastIndexOf(ss[1]) + 7, path.lastIndexOf(ss[2]) - 1);
                        String ddPath = "/dealersAllAds.do?Did=" + dId1;
                        RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(ddPath);
                        rd.forward(request, response);
                    } else {
                        LOG.error("Exception occurred " + path);
                    }

                } else {
                    chain.doFilter(request, response);
                }
            } else {
                if (path.indexOf("/bs/") > -1) {
                    String rdPath = "/moreDetailsEmail.do";
                    if (request.getParameter("adId") == null || request.getParameter("catId") == null) {
                        String pms = null;
                        long catId = 0;
                        long adId = 0;
                        if (path.indexOf("-") > -1 && path.indexOf(".htm") > -1) {
                            pms = path.substring(path.lastIndexOf("-") + 1, path.lastIndexOf(".htm"));
                        }
                        if (pms != null && pms.indexOf("s") > -1) {
                            String catid = pms.substring(0, pms.indexOf("s"));
                            String adid = pms.substring(pms.indexOf("s") + 1, pms.length());
                            if (catid != null && adid != null && catid.trim().length() > 0 && adid.trim().length() > 0 && Character.isDigit(catid.charAt(0)) && Character.isDigit(adid.charAt(0))) {
                                try {
                                    catId = Long.parseLong(catid);
                                    adId = Long.parseLong(adid);
                                } catch (Exception e) {
                                    LOG.error("Exception occurred " + e);
                                }
                            }
                        }
                        if (adId > 0 && catId > 0) {
                            rdPath += "?adId=" + adId + "&catId=" + catId;
                        } else {
                            rdPath = "/tile1.do";
                        }
                    }
                    if (rdPath.contains("moreDetails")) {
                        RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(rdPath);
                        rd.forward(request, response);
                    } else {
                        if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                            rdPath = BuySellProperties.getProperty("localurl") + rdPath;
                        }
                        ((HttpServletResponse) response).sendRedirect(rdPath);
                    }
                } else if (path.indexOf("/bc/") > -1) {
                    String rdu;
                    String catId = "33";
                    if (BuySellProperties.getProperty("localurl") != null && BuySellProperties.getProperty("localurl").trim().length() > 0) {
                        rdu = BuySellProperties.getProperty("localurl") + "/clf.do";
                    } else {
                        rdu = "/clf.do";
                    }
                    if (request.getParameter("subCatId") != null && request.getParameter("subCatId").trim().length() > 0) {
                        catId = request.getParameter("subCatId");
                    } else {
                        if (path.indexOf("-") > -1 && path.indexOf(".htm") > -1) {
                            catId = path.substring(path.lastIndexOf("-") + 1, path.lastIndexOf(".htm"));
                        }
                    }
                    if (catId == null || !Character.isDigit(catId.charAt(0))) {
                        catId = "33";
                    }
                    rdu += "?subCatId=" + catId;
                    ((HttpServletResponse) response).sendRedirect(rdu);
                } else {
                    chain.doFilter(request, response);
                }
            }
        } else {
            String dd = (String) ((HttpServletRequest) request).getSession().getAttribute("dw");
            if (dd == null) {
                RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher("/ws.do?dw=" + subDomain);
                rd.forward(request, response);
            } else {
                chain.doFilter(request, response);
            }
        }
        if (rCity == null) {
            if (city == null) {
                if (ck != null && ck.length > 0) {
                    for (int i = 0; i < ck.length; i++) {
                        Cookie c = ck[i];
                        if (c.getName().equals("presentCity")) {
                            city = c.getValue();
                            session.setAttribute("city", city);
                        }
                    }
                }
            }
//                if (city != null && city.trim().length() > 0) {
//
//
//                } else {
//                    RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(url);
//                    rd.forward(request, response);
//                }
            if (city == null) {
                String fwurl = url;
                if (path != null && path.trim().length() > 0) {
                    fwurl = path;
                }
                RequestDispatcher rd = ((HttpServletRequest) request).getRequestDispatcher(fwurl);
                session.setAttribute("city", "All India");
                rd.forward(request, response);
            }

        } else {
            session.setAttribute("city", rCity);
        }
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
            url = filterConfig.getInitParameter("citiUrl");
            mlnal = filterConfig.getInitParameter("MLNPU");
            StringTokenizer str = new StringTokenizer(mlnal, "|");
            while (str != null && str.hasMoreTokens()) {
                String ul = str.nextToken();
                if (ul != null && ul.trim().length() > 0) {
                    al.add(ul.trim());
                }

            }
            LOG.debug("= blocked urls after registraton = " + al);

        }
    }
}
