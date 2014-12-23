/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.siteAdds;

import java.util.List;

/**
 *S_AD_ID         | int(5)       | YES  |     | NULL    |       |
| S_AD_START_DATE | datetime     | YES  |     | NULL    |       |
| S_AD_EXP_DATE   | datetime     | YES  |     | NULL    |       |
| S_PERDAY        | int(3)       | YES  |     | NULL    |       |
| S_STATUS        | int(2)       | YES  |     | NULL    |       |
| S_POSTED_BY     | varchar(20)  | YES  |     | NULL    |       |
| S_APPROVED_BY   | varchar(20)  | YES  |     | NULL    |       |
| S_PLACE         | int(2)       | YES  |     | NULL    |       |
| S_DURATION      | int(3)       | YES  |     | NULL    |       |
| S_IMAGE         | varchar(100) | YES  |     | NULL    |       |
| S_URL           | varchar(100) | YES  |     | NULL    |       |
| S_PAGE          | varchar(20)  | YES  |     | NULL    |       |
| S_CITIES        | v
 * @author bbsadmin
 */
public class SiteAdd {

long id;
int sPlace;
int duration;
String img;
String url;
int page;
List cities;
int type;

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
    
    public List getCities() {
        return cities;
    }

    public void setCities(String cities) {
        //this.cities = cities;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getSPlace() {
        return sPlace;
    }

    public void setSPlace(int sPlace) {
        this.sPlace = sPlace;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }


}
