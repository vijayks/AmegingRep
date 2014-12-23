/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.io.Serializable;
import java.util.Date;
import java.util.StringTokenizer;

/**
 *
 * @author bbsadmin
 */
public class Article implements Serializable {

    String title;
    String uuid;
    String message;
    Date cDate;
    String userId;
    String status;
    String sdate;
    String points;
    String coments;

    public String getComents() {
        return coments;
    }

    public void setComents(String coments) {
        this.coments = coments;
    }

    public String getPoints() {
        return points;
    }

    public void setPoints(String points) {
        this.points = points;
    }



    public String getSdate() {
        return sdate;
    }

    public void setSdate(String sdate) {
        this.sdate = sdate;
    }



    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getcDate() {
        return cDate;
    }

    public void setcDate(Date cDate) {
        this.cDate = cDate;
    }

    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @Override
    public String toString() {
        return uuid+"$^"+userId+"$^"+title+"$^"+message+"$^"+String.valueOf(cDate)+"$^"+points+"$^"+coments;
    }

    public Article(String article) {
        StringTokenizer st = new StringTokenizer(article,"$^");
        if(st != null && st.hasMoreTokens()){
            String uuid = st.nextToken();
            if(uuid != null && uuid.trim().length() >0){
                this.uuid = uuid;
            }
            String userId  = st.nextToken();
            if(userId != null && userId.trim().length() > 0){
                this.userId = userId;
            }
            String title = st.nextToken();
            if(title != null && title.trim().length() > 0){
                this.title = title;
            }
            String message = st.nextToken();
            if(message != null && message.trim().length() >0){
                this.message = message;
            }
            String date = st.nextToken();
            if(date != null && date.trim().length() >0){
                this.sdate = date;
            }
            String points = st.nextToken();
            if(points != null && points.trim().length() >0){
                this.points = points;
            }
            String coments = st.nextToken();
            if(coments != null && coments.trim().length() >0){
                this.coments = coments;
            }
        }
    }

    public Article() {
    }


    
}
