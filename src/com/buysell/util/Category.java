/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author bbsadmin
 */
public class Category implements Serializable {

    String name;
    String description;
    String imagePath;
    int id;
    int templateId;
    Date creationDate;
    int displayOrder;
    List tags;
    int parent;
    List subCategories;
    int postAd;


    Map totalSubCatAdCount= new HashMap();
    Map cc = new HashMap();
     public int getPostAd() {
        return postAd;
    }

    public void setPostAd(int postAd) {
        this.postAd = postAd;
    }

    public void setCityCount(String city,int count){
        cc.put(city, count);
    }

    public int getCityCount(String city){
        Integer c = (Integer)cc.get(city);
        return c != null ? c :0;
    }

    public int getTotalSubCatAdCount(String city) {

        Integer c = (Integer)totalSubCatAdCount.get(city);
        return c != null ? c :0;

    }

    public void setTotalSubCatAdCount(String city,int count){
            totalSubCatAdCount.put(city, count);
    }

    

    public void addSubCategory(Category cat) {
        if (subCategories == null) {
            subCategories = new ArrayList();
        }
        subCategories.add(cat);
    }

    public List getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List subCategories) {
        this.subCategories = subCategories;
    }

    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List getTags() {
        return tags;
    }

    public void setTags(List tags) {
        this.tags = tags;
    }

    public int getTemplateId() {
        return templateId;
    }

    public void setTemplateId(int templateId) {
        this.templateId = templateId;
    }

    public Category() {
    }

    public Category(String name, String description, String imagePath, int id, int templateId, Date creationDate, int displayOrder, List tags, int parent ,int postAd) {
        this.name = name;
        this.description = description;
        this.imagePath = imagePath;
        this.id = id;
        this.templateId = templateId;
        this.creationDate = creationDate;
        this.displayOrder = displayOrder;
        this.tags = tags;
        this.parent = parent;
        this.postAd= postAd;
    }

    @Override
    public String toString() {
        return name;
    }
}