/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.beans.Article;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class AtricleManagerUtil {

    static String buySellUrl = BuySellProperties.getProperty("articleurl") == null ? "http://localhost/bs" : BuySellProperties.getProperty("articleurl");
    private final static Logger LOG = Logger.getLogger(AtricleManagerUtil.class);

    public static String sendCommand(String command) {
        String response = null;
        LOG.debug("Sending command " + command);
        try {
            HttpClient hc = new HttpClient();
            GetMethod gm = new GetMethod(buySellUrl.trim() + "?act=" + command);
            LOG.debug("Before sending command " + gm.toString());
            hc.executeMethod(gm);
            response = gm.getResponseBodyAsString();

            LOG.info(" Got response from " + buySellUrl + " for " + command + " is " + response);
            gm.releaseConnection();

        } catch (Exception ex) {
            LOG.error("Error while sending the command :" + buySellUrl + " for " + command + " \n ERROR is " + ex);
        }
        return response;
    }

    private static List getArticles(String articles) {
        List ll = new ArrayList();
        if (articles != null) {
            String body = articles.substring(articles.indexOf("<ARTICLES>") + 10, articles.indexOf("</ARTICLES>"));
            if (body != null && body.trim().length() > 0) {
                String[] sBody = body.split("<ART>");
                for (int i = 0; i < sBody.length; i++) {
                    if (sBody[i] != null && sBody[i].trim().length() > 0) {
                        Article art = new Article(sBody[i].substring(0, sBody[i].indexOf("</ART>")));
                        ll.add(art);
                    }
                }
            }
        }
        return ll;
    }

    public static List getAllArticles() {
        List ll = new ArrayList();
        String s = sendCommand("all");
        if (s != null) {
            ll = getArticles(s);
            LOG.debug(" Size of all articles is " + ll.size());
        }
        return ll;
    }

    public static List getAllArticlesByUser(String userId) {
        List ll = new ArrayList();
        String s = sendCommand("user&uId=" + userId);
        if (s != null) {
            ll = getArticles(s);
            LOG.debug(" Size of all user articles is " + ll.size());
        }
        return ll;
    }

    public static List getArticlesByStatus(String status) {
        List ll = new ArrayList();
        String s = sendCommand("sts&status=" + status);
        if (s != null) {
            ll = getArticles(s);
            LOG.debug(" Size of all articles by status " + status + " is " + ll.size());
        }
        return ll;
    }

    public static String deleteArticle(String userId, String uuid) {
        String response = sendCommand("del&uuid=" + uuid + "&uId=" + userId);
        LOG.debug(" Response after deleting the article is " + response);
        return response;
    }

    public static String updateArticle(String userId, String uuid, String coments, String points) {
        String response = null;
        try {
            String command = URLEncoder.encode(coments, "UTF-8");
            response = sendCommand("upd&uuid=" + uuid + "&uId=" + userId + "&points=" + points + "&coment=" + command);
            LOG.debug(" Response after updating the article is " + response);
            return response;
        } catch (UnsupportedEncodingException ex) {
            LOG.error("Error while encoding in to utf-8 " + ex);
        }
        return response;
    }

    public static String createArticle(Article art) {
        LOG.debug("Sending create blog Command "+art.getUserId()+" title "+ art.getTitle());
        return sendPostCommand(art.getUserId(), art.getTitle(), art.getMessage(), art.getStatus(), art.getComents(), art.getPoints(),null,"cre");
    }

     public static String postUpdateArticle(Article art) {
        LOG.debug("Sending update blog Command "+art.getUserId()+" title "+ art.getTitle());
        return sendPostCommand(art.getUserId(), art.getTitle(), art.getMessage(), art.getStatus(), art.getComents(), art.getPoints(),art.getUuid(),"updui");
    }

    private static String sendPostCommand(String userId, String title, String message, String status, String coments, String points,String uuid, String act) {
        LOG.debug("Sending post command to Blog application ..... ");
        String response = null;
        try {
            HttpClient hc = new HttpClient();
            PostMethod p = new PostMethod(buySellUrl.trim());
            p.addParameter("act", act);
            p.addParameter("usrId", userId);
            if(uuid != null)
            p.addParameter("uuid", uuid);
            p.addParameter("title", title);
            p.addParameter("message", message);
            p.addParameter("status", status);
            p.addParameter("comments", coments);
            p.addParameter("points", points);
            hc.executeMethod(p);
            response = p.getResponseBodyAsString();
            LOG.info("Article "+title+" created successfuly for user "+userId);
        } catch (IllegalArgumentException e) {
            LOG.error("Error while executing Post method" + e);
        } catch (IOException e) {
            LOG.error("Error while executing Post method" + e);
        }
        return response;
    }
}
