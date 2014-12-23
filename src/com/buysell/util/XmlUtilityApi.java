/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.apache.log4j.Logger;
import org.exolab.castor.mapping.Mapping;
import org.exolab.castor.xml.Marshaller;
import org.exolab.castor.xml.Unmarshaller;

/**
 * User: Siddiq
 * Date: Jun 19, 2007
 */
public class XmlUtilityApi {

    private static Logger LOG = Logger.getLogger(XmlUtilityApi.class);
    private List allCities = new ArrayList();
    public static XmlUtilityApi xmlApi = null;

    private XmlUtilityApi() {

        mappingXMLFileLocation = BuySellProperties.getProperty("mappingFilePath");
        mappingXMLFileName = BuySellProperties.getProperty("mappingFileName");
        xmlFileName = BuySellProperties.getProperty("xmlFileName");
        xmlFileLocation = BuySellProperties.getProperty("xmlFilePath");
        absoluteMappingFilePath = Thread.currentThread().getContextClassLoader().getResource(mappingXMLFileName).getPath();
        CitiesThread citiesThread = new CitiesThread();
        citiesThread.setDaemon(true);
        citiesThread.start();


    }

    public static XmlUtilityApi getXMLUtil() {
        if (xmlApi == null) {
            xmlApi = new XmlUtilityApi();
        }
        return xmlApi;
    }

    public XmlUtilityApi(String mappingXMLFileLocation, String mappingXMLFileName, String xmlFileName, String xmlFileLocation) {

        this.mappingXMLFileLocation = mappingXMLFileLocation;
        this.mappingXMLFileName = mappingXMLFileName;
        this.xmlFileName = xmlFileName;
        this.xmlFileLocation = xmlFileLocation;
        //absoluteXmlFilePath = this.xmlFileLocation.concat(this.xmlFileName);
        absoluteMappingFilePath = this.mappingXMLFileLocation.concat(this.mappingXMLFileName);

    }
    String mappingXMLFileLocation;
    String mappingXMLFileName;
    String xmlFileName;
    String xmlFileLocation;
    String absoluteXmlFilePath;
    String absoluteMappingFilePath;
    long sleepTime = Long.parseLong(BuySellProperties.getProperty("citi.thread.sleepTIme"));
    public static boolean run = true;

    public void createXML(Object obj, String country, String state) {
        FileWriter fw = null;
        try {
            fw = new FileWriter(xmlFileLocation + "/" + country + "/" + state + "/" + xmlFileName);
            Marshaller marshaller = new Marshaller(fw);
           
            Mapping mapping = new Mapping();
            mapping.loadMapping(absoluteMappingFilePath);
            marshaller.setMapping(mapping);
            marshaller.marshal(obj);

        } catch (Exception e) {
            LOG.error("Exception occured " + e);
        } finally {
            try {
                if (fw != null) {
                    fw.close();
                }
            } catch (IOException ex) {
                LOG.error("Error while closing file writer" + ex);
            }
        }
    }

    public Object readXML(Class classObject, String country, String state) {

        Object unmarshalledObject = null;
        FileReader fr = null;
        try {
            fr = new FileReader(xmlFileLocation + "/" + country + "/" + state + "/" + xmlFileName);
            Unmarshaller unmarshaller = new Unmarshaller(classObject);
            if (absoluteMappingFilePath != null) {
              
                Mapping mapping = new Mapping();
                mapping.loadMapping(absoluteMappingFilePath);
                unmarshaller.setMapping(mapping);
            }
            unmarshalledObject = unmarshaller.unmarshal(fr);
        } catch (Exception e) {
            LOG.error("Following exception occured while trying to read from XML File " + e);
            return null;
        } finally {
            if (fr != null) {
                try {
                    fr.close();
                } catch (IOException ex) {
                    LOG.error("Exception in closing file reader " + ex);
                }
            }
        }

        return unmarshalledObject;
    }

    public boolean updateXML(Object modifiedObj, String country, String state) {

        Object unmarshalledObject = null;
        FileReader fr = null;
        FileWriter fw = null;
        try {
            fr = new FileReader(xmlFileLocation + "/" + country + "/" + state + "/" + xmlFileName);
            Unmarshaller unmarshaller = new Unmarshaller(modifiedObj.getClass());
            if (absoluteMappingFilePath != null) {
                LOG.info("Mapping file being used " + absoluteMappingFilePath);
                Mapping mapping = new Mapping();
                mapping.loadMapping(absoluteMappingFilePath);
                unmarshaller.setMapping(mapping);
            }
            unmarshalledObject = unmarshaller.unmarshal(fr);
            unmarshalledObject = modifiedObj;

            fw = new FileWriter(xmlFileLocation + "/" + country + "/" + state + "/" + xmlFileName);
            Marshaller marshaller = new Marshaller(fw);
            if (absoluteMappingFilePath != null) {
           
                Mapping mapping = new Mapping();
                mapping.loadMapping(absoluteMappingFilePath);
                marshaller.setMapping(mapping);
            }
            marshaller.marshal(unmarshalledObject);
            fw.close();
            fr.close();
        } catch (Exception e) {
            LOG.error("Following exception occured while trying to read from / write to XML File " + e);
            return false;
        } finally {
            if (fw != null) {
                try {
                    fw.close();
                } catch (IOException ex) {
                    LOG.error("Exception in closing file writer " + ex);
                }
            }
            if (fr != null) {
                try {
                    fr.close();
                } catch (IOException ex) {
                    LOG.error("Exception in closing file reader " + ex);
                }
            }
        }
        return true;
    }

    public boolean deleteXML(Object objToDelete, String country, String state) {


        boolean fileDeleted = false;
        File f = new File(xmlFileLocation + "/" + country + "/" + state + "/" + xmlFileName);
        if (f.exists()) {
            fileDeleted = f.delete();
        } else {
            LOG.error("File denoted by " + absoluteXmlFilePath + " doesnot exist");
        }
        return fileDeleted;
    }

    public List getAllcities() {
        if (allCities.size() > 0) {
                 
            return allCities;
        } else {
            try {
                LOG.info(" Sleeping for 1 sec before fetching the cities ");
                Thread.sleep(1000);
            } catch (InterruptedException ie) {
                LOG.error("Error while sleeping for 1 sec to fetch all cities " + ie);
            }
        }
        return allCities;
    }

    private class CitiesThread extends Thread {

        @Override
        public void run() {
            while (run) {
                List ll = new ArrayList();
                LOG.info("Starting the city UPDATER thread .....");
                File dir = new File(xmlFileLocation);
                if (dir != null && dir.exists() && dir.isDirectory()) {
                    String[] countries = dir.list();
                    if (countries != null && countries.length > 0) {
                        for (int i = 0; i < countries.length; i++) {
                            File states = new File(xmlFileLocation + "/" + countries[i]);
                            if (states != null && states.exists() && states.isDirectory()) {
                                String stat[] = states.list();
                                if (stat != null && stat.length > 0) {
                                    for (int j = 0; j < stat.length; j++) {
                                        String stName = stat[j];
                                        LOG.debug("Finding the cities for country " + countries[i] + " and the state " + stName);
                                        Address allCities = (Address) readXML(Address.class, countries[i], stName);
                                        if (allCities != null) {
                                            List cl = allCities.getCities();

                                            if (cl != null && cl.size() > 0) {
                                                LOG.debug("Total number of cities available for " + stName + " are " + cl.size());
                                                Iterator itr = cl.iterator();
                                                while (itr.hasNext()) {
                                                    City c = (City) itr.next();
                                                    c.setCountry(countries[i]);
                                                    c.setState(stName);
                                                    ll.add(c);
                                                }
                                            }
                                        }

                                    }
                                }
                            }

                        }
                    }
                    Collections.sort(ll, new CityComparator());
                    allCities = ll;

                }
                LOG.info("City UPDATER thread isfinished the TASK..... and sleeping for " + sleepTime);
                try {
                    sleep(sleepTime);
                } catch (InterruptedException ie) {
                    LOG.error(" Exception while sleeping " + ie);
                }
            }

        }
    }
}
