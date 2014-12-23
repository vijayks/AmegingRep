/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 */

package com.buysell.beans;

/**
 * +-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| ID          | int(11)      | NO   | PRI | NULL    | auto_increment |
| SOURCE      | varchar(50)  | YES  |     | NULL    |                |
| DESTINATION | varchar(50)  | NO   |     |         |                |
| CONTENT     | varchar(200) | YES  |     | NULL    |                |
| STARTMIN    | int(10)      | YES  |     | NULL    |                |
| EXPIRE_DATE | datetime     | YES  |     | NULL    |                |
| INSERT_DATE | datetime     | YES  |     | NULL    |                |
| USER_ID     | int(11)      | YES  |     | NULL    |                |
| AD_ID       | int(11)      | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+

 *
 * @author bbsadmin
 */
public class SmsAlertsPendingListBean {


    private int id=0;
    private String source=null;
    private String destination=null;
    private String content=null;
    private String startMin=null;
    private int userId=0;
    private int adId=0;

    public int getAdId() {
        return adId;
    }

    public void setAdId(int adId) {
        this.adId = adId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getStartMin() {
        return startMin;
    }

    public void setStartMin(String startMin) {
        this.startMin = startMin;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}
