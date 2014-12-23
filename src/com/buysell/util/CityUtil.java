/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author srikanth
 */
public class CityUtil {

    private static Logger LOG = Logger.getLogger(CityUtil.class);
    XmlUtilityApi xmlutil = XmlUtilityApi.getXMLUtil();

    public void addCity(City c) {
        boolean flag = false;
        Address addresses = (Address) xmlutil.readXML(Address.class,c.getCountry(),c.getState());
        if (addresses != null) {
            addresses.addCity(c);
            LOG.debug("Adding city to existing addresses");
            flag = xmlutil.updateXML( addresses,c.getCountry(),c.getState());
            if (flag) {
                LOG.info("City added successfully " + c.getName());
            } else {
                LOG.error("Unable to add city " + c.getName());
            }
        } else {
            LOG.error("Unable to read cities from xml file");
            addresses = new Address();
            addresses.addCity(c);
            LOG.debug("Created new Addresses");
            xmlutil.createXML(addresses,c.getCountry(),c.getState());
        }
    }

    public City readCity(String name,String country,String state) {
            City fcity = null;
            Address alertsChannels = (Address) xmlutil.readXML( Address.class,country,state);
            if(alertsChannels != null) {
                List cities = alertsChannels.getCities();
                if(cities.size() > 0) {
                    for(Iterator itr = cities.iterator(); itr.hasNext(); ) {
                         City city = (City) itr.next();
                        if(city.getName().equals(name)) {
                           LOG.debug("City found in XML "+city.getName());
                           fcity = city;
                           break;
                        }
                    }

                } else {
                    LOG.error("No Channels available in Xml file cities.xml");
                }
            } else {
                LOG.error("Unable to read channels from xml file");
            }
        return fcity;

    }

    public boolean deleteCity(String name,String country,String state) {
        boolean channelDeleted = false;
            Address address = new Address();
            City city = null;
            Address alertsChannels = (Address) xmlutil.readXML(Address.class,country,state);
            if(alertsChannels != null) {
                List cities = alertsChannels.getCities();
                if(cities.size() > 0) {
                    for(Iterator itr = cities.iterator(); itr.hasNext(); ) {
                         city = (City) itr.next();
                        if(!city.getName().equals(name)) {
                            address.addCity(city);
                        }
                    }
                    channelDeleted = xmlutil.updateXML(address,country,state);
                    if(channelDeleted) {
                        LOG.info("City deleted successfully " + city.getName());
                    } else {
                        LOG.error("Unable to delete city " + city.getName());
                    }
                } else {
                    LOG.error("No Channels available in Xml file cities.xml");
                }
            } else {
                LOG.error("Unable to read channels from xml file");
            }

        return true;
    }

    public boolean editCity(City c) {

        boolean channelUpdated = false;
        Address address = new Address();
        Address foundAddress = (Address) xmlutil.readXML( Address.class,c.getCountry(),c.getState());
        if(foundAddress != null) {
            List cities = foundAddress.getCities();
            if(cities.size() > 0) {
                for(Iterator itr = cities.iterator(); itr.hasNext(); ) {
                    City  city = (City) itr.next();
                    if(!city.getName().equals(c.getName())) {
                        address.addCity(city);
                    } else {
                        address.addCity(c);
                    }
                }
                channelUpdated = xmlutil.updateXML(address,c.getCountry(),c.getState());
                if(channelUpdated) {
                    LOG.info("City updated successfully " + c.getName());
                } else {
                    LOG.error("Unable to update city " + c.getName());
                }
            } else {
                LOG.error("No Channels available in Xml file city.xml" );
            }
        } else {
            LOG.error("Unable to read channels from xml file");
        }

        return true;
    }

    public List viewAllCities(String country,String state){
         Address alertsChannels = (Address) xmlutil.readXML( Address.class,country,state);
         if(alertsChannels != null){
            return alertsChannels.getCities();
         }else{
             return null;
         }

    }

    public List viewAllLocal(String con, String stt, String ct) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    public List viewAllCities(){
        return xmlutil.getAllcities();
    }

    public City getCityByName(String cityName) {
        City cityObj;
        List cityClassList = viewAllCities();
        if (cityName != null && cityClassList.size() > 0) {
            Iterator itr = cityClassList.iterator();
            while (itr.hasNext()) {
                City c = (City) itr.next();
                if (c.getName().equals(cityName.trim())) {
                    return c;
                }
            }
        }
        cityObj = new City();
        cityObj.setName("All India");
        return cityObj;

    }
}
