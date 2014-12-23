/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.beans;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author bbsadmin
 */
public class PostAdFormBean extends com.buysell.beans.RegisterFormBean {

//sharable field names
    private String name;// shared for books.tile(name of book)
    private String condition;//shared for books.tile,automobile.tile
    private String yearsOld;//shared for books.tile,automobile.tile

 // selectedCategory.jsp  form elements
    private  int catId;
    private String adType;

// general.jsp form elements
    private String adTitle;
    private String description;
    private String country;
    private String state;
    private String city;
    private String area;
    private String locality;
    private String address;
    private FormFile image1;
    private FormFile image2;
    private FormFile image3;


//price.jsp form elements
    private float price;
    private String cfp;
    private float max;
    private float min;
    private String neg;

//footer.jsp form elements
    private String fname;
    private String lname;
    private String email;
    private String ph1;
    private String ph2;

 //additionalContent.jsp form elements

   private String additionalContent;

//autoMobiles.tile form elements
    
    private String model;
    private String regNo;
    private String color;
    private String ownership;
    private String insurance;
    private int kmRun;
    private String specialOffer;
    private String SOFrom;
    private String SOTo;

//books.tile form elements
    private String author;
    private String language;
    private String publication;
//


   /***************************************************/
    private String brand;
    private String material;
    private String type;
   
    private String measurement;
    private int weight;
    private int height;
    private String note;
    private String pet;
    private String breed;
    private String objects;
    private String collectables;
    private String qualification;
    private String skillSet;
    private String industary;
    private String prefLocation;
    private float currentSalary;
    private float expectedSalary;
    private int noticePeriod;
    private String qualityDiamond;
    private int rentMonth;
    private int noBedRooms;
    private int floorNum;
    private int totalFloors;
    private String facing;
    private String furnished;
    private String facilities;
    private int sponsType;
    private String videoUrl;

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }
      public int getSponsType() {
        return sponsType;
    }

    public void setSponsType(int sponsType) {
        this.sponsType = sponsType;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public String getCollectables() {
        return collectables;
    }

    public void setCollectables(String collectables) {
        this.collectables = collectables;
    }

    public float getCurrentSalary() {
        return currentSalary;
    }

    public void setCurrentSalary(float currentSalary) {
        this.currentSalary = currentSalary;
    }

    public float getExpectedSalary() {
        return expectedSalary;
    }

    public void setExpectedSalary(float expectedSalary) {
        this.expectedSalary = expectedSalary;
    }

    public String getFacilities() {
        return facilities;
    }

    public void setFacilities(String facilities) {
        this.facilities = facilities;
    }

    public String getFacing() {
        return facing;
    }

    public void setFacing(String facing) {
        this.facing = facing;
    }

    public int getFloorNum() {
        return floorNum;
    }

    public void setFloorNum(int floorNum) {
        this.floorNum = floorNum;
    }

    public String getFurnished() {
        return furnished;
    }

    public void setFurnished(String furnished) {
        this.furnished = furnished;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getIndustary() {
        return industary;
    }

    public void setIndustary(String industary) {
        this.industary = industary;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getMeasurement() {
        return measurement;
    }

    public void setMeasurement(String measurement) {
        this.measurement = measurement;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNoBedRooms() {
        return noBedRooms;
    }

    public void setNoBedRooms(int noBedRooms) {
        this.noBedRooms = noBedRooms;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getNoticePeriod() {
        return noticePeriod;
    }

    public void setNoticePeriod(int noticePeriod) {
        this.noticePeriod = noticePeriod;
    }

    public String getObjects() {
        return objects;
    }

    public void setObjects(String objects) {
        this.objects = objects;
    }

    public String getPet() {
        return pet;
    }

    public void setPet(String pet) {
        this.pet = pet;
    }

    public String getPrefLocation() {
        return prefLocation;
    }

    public void setPrefLocation(String prefLocation) {
        this.prefLocation = prefLocation;
    }

    public String getPublication() {
        return publication;
    }

    public void setPublication(String publication) {
        this.publication = publication;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getQualityDiamond() {
        return qualityDiamond;
    }

    public void setQualityDiamond(String qualityDiamond) {
        this.qualityDiamond = qualityDiamond;
    }

    public int getRentMonth() {
        return rentMonth;
    }

    public void setRentMonth(int rentMonth) {
        this.rentMonth = rentMonth;
    }

    public String getSkillSet() {
        return skillSet;
    }

    public void setSkillSet(String skillSet) {
        this.skillSet = skillSet;
    }

    public int getTotalFloors() {
        return totalFloors;
    }

    public void setTotalFloors(int totalFloors) {
        this.totalFloors = totalFloors;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }




    

    public String getSOFrom() {
        return SOFrom;
    }

    public void setSOFrom(String SOFrom) {
        this.SOFrom = SOFrom;
    }

    public String getSOTo() {
        return SOTo;
    }

    public void setSOTo(String SOTo) {
        this.SOTo = SOTo;
    }

    public String getAdTitle() {
        return adTitle;
    }

    public void setAdTitle(String adTitle) {
        this.adTitle = adTitle;
    }

    public String getAdType() {
        return adType;
    }

    public void setAdType(String adType) {
        this.adType = adType;
    }

    public String getAdditionalContent() {
        return additionalContent;
    }

    public void setAdditionalContent(String additionalContent) {
        this.additionalContent = additionalContent;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getCfp() {
        return cfp;
    }

    public void setCfp(String cfp) {
        this.cfp = cfp;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public FormFile getImage1() {
        return image1;
    }

    public void setImage1(FormFile image1) {
        this.image1 = image1;
    }

    public FormFile getImage2() {
        return image2;
    }

    public void setImage2(FormFile image2) {
        this.image2 = image2;
    }

    public FormFile getImage3() {
        return image3;
    }

    public void setImage3(FormFile image3) {
        this.image3 = image3;
    }

    

    public String getInsurance() {
        return insurance;
    }

    public void setInsurance(String insurance) {
        this.insurance = insurance;
    }

    public int getKmRun() {
        return kmRun;
    }

    public void setKmRun(int kmRun) {
        this.kmRun = kmRun;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }

    public float getMax() {
        return max;
    }

    public void setMax(float max) {
        this.max = max;
    }

    public float getMin() {
        return min;
    }

    public void setMin(float min) {
        this.min = min;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getNeg() {
        return neg;
    }

    public void setNeg(String neg) {
        this.neg = neg;
    }

    public String getOwnership() {
        return ownership;
    }

    public void setOwnership(String ownership) {
        this.ownership = ownership;
    }

    public String getPh1() {
        return ph1;
    }

    public void setPh1(String ph1) {
        this.ph1 = ph1;
    }

    public String getPh2() {
        return ph2;
    }

    public void setPh2(String ph2) {
        this.ph2 = ph2;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public String getSpecialOffer() {
        return specialOffer;
    }

    public void setSpecialOffer(String specialOffer) {
        this.specialOffer = specialOffer;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getYearsOld() {
        return yearsOld;
    }

    public void setYearsOld(String yearsOld) {
        this.yearsOld = yearsOld;
    }
   
   
    
    




    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();

        return errors;
    }
}
