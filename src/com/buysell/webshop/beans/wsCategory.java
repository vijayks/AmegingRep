/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.webshop.beans;

import java.io.Serializable;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class wsCategory implements Serializable{
private String name;
private String shrtDesc;
private String cImg;
private long parentId;
private long catId;
private long id;
private int status;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    public long getCatId() {
        return catId;
    }

    public void setCatId(long catId) {
        this.catId = catId;
    }

    public long getParentId() {
        return parentId;
    }

    public void setParentId(long parentId) {
        this.parentId = parentId;
    }


    public String getcImg() {
        return cImg;
    }

    public void setcImg(String cImg) {
        this.cImg = cImg;
    }
   

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShrtDesc() {
        return shrtDesc;
    }

    public void setShrtDesc(String shrtDesc) {
        this.shrtDesc = shrtDesc;
    }



}
