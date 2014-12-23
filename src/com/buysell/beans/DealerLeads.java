/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.util.Date;

/**
 *
 * @author srikanth
 * /*DEALER_LEADS_T
 +---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| LEAD_ID       | int(11)      | NO   | PRI | NULL    | auto_increment |
| TYPE          | varchar(20)  | YES  |     | NULL    |                |
| DELIVERY_DATE | datetime     | YES  |     | NULL    |                |
| CATEGORY_ID   | int(11)      | YES  |     | NULL    |                |
| LEAD_USER_ID  | int(11)      | YES  |     | NULL    |                |
| SOURCE        | varchar(10)  | YES  |     | NULL    |                |
| STATUS        | int(11)      | YES  |     | NULL    |                |
| COMMENTS      | varchar(250) | YES  |     | NULL    |                |
| DEALER_ID     | int(11)      | NO   |     |         |                |
| USER_CONTACT  | varchar(50)  | YES  |     | NULL    |                |
| LAST_MOD_DATE | datetime     | YES  |     | NULL    |                |
| CITY          | varchar(50)  | YES  |     | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+


 */
public class DealerLeads {

    long id;
    String type;
    String deliveryDate;
    int catID;
    String userId;
    String source;
    String status;
    String comments;
    long delearId;
    String uContact;
    Date lMDate;
    String city;

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public long getDelearId() {
        return delearId;
    }

    public void setDelearId(long delearId) {
        this.delearId = delearId;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getlMDate() {
        return lMDate;
    }

    public void setlMDate(Date lMDate) {
        this.lMDate = lMDate;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getuContact() {
        return uContact;
    }

    public void setuContact(String uContact) {
        this.uContact = uContact;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public DealerLeads(long id, String type, String deliveryDate, int catID, String userId, String source, String status, String comments, long delearId, String uContact, Date lMDate, String city) {
        this.id = id;
        this.type = type;
        this.deliveryDate = deliveryDate;
        this.catID = catID;
        this.userId = userId;
        this.source = source;
        this.status = status;
        this.comments = comments;
        this.delearId = delearId;
        this.uContact = uContact;
        this.lMDate = lMDate;
        this.city = city;
    }

    public DealerLeads() {
    }
    
    

}
