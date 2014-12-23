/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.buysell.beans;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author bbsadmin
 */
public class BodyBean implements Serializable {
    private int catId;
    private String catName;
    private String imagePath;
    private int parentId;
    private ArrayList subCategory;

    public ArrayList getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(ArrayList subCategory) {
        this.subCategory = subCategory;
    }

    


    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    

}
