/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.buysell.util;

import com.buysell.beans.Article;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Level;
import javax.jcr.Credentials;
import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.Property;
import javax.jcr.Repository;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.SimpleCredentials;
import javax.jcr.Workspace;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.apache.jackrabbit.core.jndi.RegistryHelper;
import org.apache.jackrabbit.value.DateValue;
import org.apache.jackrabbit.value.StringValue;
import org.apache.log4j.Logger;

/**
 *
 * @author bbsadmin
 */
public class BlogUtil {

    private static BlogUtil blogUtil;
    private static final Logger LOG = Logger.getLogger(BlogUtil.class);
    //URL url = Thread.currentThread().getContextClassLoader().getResource("repository.xml");
    private String CONFIG_FILE;// = url.getPath();
    //The directory for the repository files.
    private static final String REPO_HOME_DIR = BuySellProperties.getProperty("jackrabbit.home");
    //The repository's JNDI name
    private static final String REPO_NAME = "repo";
    //User ID and password to log into the repository
    private static final char[] PASSWORD = "".toCharArray();
    private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy  HH:mm");
    private static Context ctx = null;
    Repository r;
    private BlogUtil() {
        try {
            //  RepoTest rp = new RepoTest();
            //rp.main(null);
            URL url = Thread.currentThread().getContextClassLoader().getResource("repository.xml");
            URL jsu = Thread.currentThread().getContextClassLoader().getResource("jaas.config");
            System.setProperty("org.apache.jackrabbit.repository.jaas.config", jsu.getPath());
            CONFIG_FILE = url.getPath();
            LOG.info("inside constructor");
            Hashtable environment = new Hashtable();
            environment.put(Context.INITIAL_CONTEXT_FACTORY, "org.apache.jackrabbit.core.jndi.provider.DummyInitialContextFactory");
            LOG.info("1");
            environment.put(Context.PROVIDER_URL, "localhost");
            LOG.info("2");
            ctx = new InitialContext(environment);
            LOG.info("3");
            RegistryHelper.registerRepository(ctx, REPO_NAME, CONFIG_FILE, REPO_HOME_DIR, true);
            LOG.info("4");
             r = (Repository) ctx.lookup(REPO_NAME);
        } catch (NamingException namingException) {
            LOG.error(" Exception while creatign jcr repository " + namingException);
        } catch (RepositoryException repositoryException) {
            LOG.error("Repository Exception while creatign jcr repository " + repositoryException);
        }

    }    

    public static BlogUtil getBlogUtil() {
        LOG.info("getBlogutil");
        if (blogUtil == null) {
            LOG.info("inside if");
             blogUtil =  new BlogUtil();
        }

        return blogUtil ;
    }

    public boolean postArticle(String userId, Article art) {
        Session session = null;
        try {
            

            Credentials credentials = new SimpleCredentials(userId, PASSWORD);
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);

            session = r.login(credentials);


            //Find if the blog entry already exists. If so, indicate that with an exception
            Workspace workspace = session.getWorkspace();

            NodeIterator results = findBlog(workspace, userId, art.getTitle());
            if (results.hasNext()) {

                throw new IllegalArgumentException("A blog entry with uuid " + art.getUuid() +
                        " and title " + art.getTitle() + " already exists. Try updating it.");
            }

            Node rootNode = session.getRootNode();
            Node n = rootNode.addNode("blog");
            n.addMixin("mix:versionable");
            n.setProperty("blogtitle", new StringValue(art.getTitle()));
            n.setProperty("blogauthor", userId);
            n.setProperty("blogdate", new DateValue(Calendar.getInstance()));
            n.setProperty("blogtext", new StringValue(art.getMessage()));
            n.setProperty("blogStatus", new StringValue(art.getStatus()));
            n.setProperty("coments", new StringValue(art.getComents()));
            n.setProperty("points", new StringValue(art.getPoints()));

            session.save();
            n.checkin();

            LOG.info("Entered blog for : " + userId);
            LOG.info(art.getTitle() + ": " + art.getMessage());


        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        }catch (RepositoryException e) {
            throw new RuntimeException("A RepositoryException occured", e);
        } finally {
            if (session != null) {
                session.logout();
            }
        }
        return true;
    }

    private static NodeIterator findBlog(Workspace workspace, String blogAuthor, String blogTitle)
            throws RepositoryException {
        if (workspace == null || blogAuthor == null || blogTitle == null) {
            throw new NullPointerException();
        }
        QueryManager queryMan = workspace.getQueryManager();

        //Specify an XPATH query. SQL could be used as well.
        StringBuffer qstr = new StringBuffer("//blog[@blogauthor = '");
        qstr.append(blogAuthor);
        qstr.append("' and @blogtitle = '");
        qstr.append(blogTitle);
        qstr.append("']");
        Query q = queryMan.createQuery(qstr.toString(), Query.XPATH);
        QueryResult results = q.execute();
        NodeIterator iterator = results.getNodes();
        return iterator;
    }

    private List printEntriesByBlogAuthor(String blogAuthor) {
        List ll = new ArrayList();
        Session session = null;
        try {
            
            Credentials credentials = new SimpleCredentials(blogAuthor, PASSWORD);
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);
            session = r.login(credentials);

            System.out.println("Blog entries by " + blogAuthor + ": ");

            Workspace workspace = session.getWorkspace();
            QueryManager queryMan = workspace.getQueryManager();

            //Specify an XPATH query. SQL could be used as well.
            StringBuffer qstr = new StringBuffer("//blog[@blogauthor = '");
            qstr.append(blogAuthor);
            qstr.append("']");
            Query q = queryMan.createQuery(qstr.toString(), Query.XPATH);
            QueryResult results = q.execute();
            NodeIterator it = results.getNodes();
            while (it.hasNext()) {
                 Article art = new Article();
                Node node = it.nextNode();
                Property blogtitle = node.getProperty("blogtitle");
                Property blogtext = node.getProperty("blogtext");
                Property blogdate = node.getProperty("blogdate");
                Property blogStatus = node.getProperty("blogStatus");
                try {
                    Property coments = node.getProperty("coments");
                    art.setComents(coments.getString());
                    Property points = node.getProperty("points");
                    art.setPoints(points.getString());
                } catch (RepositoryException repositoryException) {
                    //NOTHING IS REQUIRED
                }
               
                art.setMessage(blogtext.getString());
                art.setTitle(blogtitle.getString());
                art.setUuid(node.getUUID());
                art.setcDate(blogdate.getDate().getTime());
                art.setStatus(blogStatus.getString());
                ll.add(art);
            }
        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RepositoryException e) {
            throw new RuntimeException("A RepositoryException occured", e);
        } finally {
            if (session != null) {
                session.logout();
            }
        }
        return ll;
    }

    public boolean deleteArticle(String userId, Article art) {
        Session s = null;
        try {
            Credentials credentials = new SimpleCredentials(userId, PASSWORD);
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);
            s = r.login(credentials);
            Node node = s.getNodeByUUID(art.getUuid());
            node.remove();
            LOG.info("Removed the blog  " + art.getUserId() + " and the title is " + art.getTitle());
            s.save();
        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RepositoryException ex) {
            LOG.error("RepositoryException  in getting all the blogs " + ex);
        } finally {
            if (s != null) {
                s.logout();
            }
        }

        return true;
    }



    public boolean updateArticle(String userId, Article art) {
        boolean flag = false;
         Session s = null;
        try {
            Credentials credentials = new SimpleCredentials(userId, PASSWORD);
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);
            s = r.login(credentials);
            Node n = s.getNodeByUUID(art.getUuid());
            if (n != null) {
                n.checkout();
                n.setProperty("blogtitle", new StringValue(art.getTitle()));
                n.setProperty("blogauthor", userId);
//                Calendar cal = Calendar.getInstance();
//                cal.setTime(art.getcDate());
//                n.setProperty("blogdate", new DateValue(cal));
                n.setProperty("blogtext", new StringValue(art.getMessage()));
                n.setProperty("blogStatus", new StringValue(art.getStatus()));
                n.setProperty("coments", new StringValue(art.getComents()));
                n.setProperty("points", new StringValue(art.getPoints()));
                s.save();
                flag = true;
                n.checkin();
                
                
            }

        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RepositoryException ex) {
            LOG.error("Repository Exception in getting all the blogs " + ex);
        }finally {
            if (s != null) {
                s.logout();
            }
        }
        return flag;
    }

    public List getArticlesByUserid(String userId) {
        return printEntriesByBlogAuthor(userId);
    }

    public List getAllArticles() {
        List ll = new ArrayList();
        Session s = null;
        try {
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);
            s = r.login();
            Workspace ws = s.getWorkspace();
            QueryManager queryMan = ws.getQueryManager();

            //Specify an XPATH query. SQL could be used as well.
            StringBuffer qstr = new StringBuffer("//blog");
//            qstr.append(blogAuthor);
//            qstr.append("']");
            Query q = queryMan.createQuery(qstr.toString(), Query.XPATH);
            QueryResult results = q.execute();
            NodeIterator it = results.getNodes();
            while (it.hasNext()) {
                Node node = it.nextNode();
                Property blogtitle = node.getProperty("blogtitle");
                Property blogtext = node.getProperty("blogtext");
                Property blogdate = node.getProperty("blogdate");
                Property blogAuther = node.getProperty("blogauthor");
                Property blogStatus = node.getProperty("blogStatus");
                Article art = new Article();
                try {
                    Property coments = node.getProperty("coments");
                    art.setComents(coments.getString());
                    Property points = node.getProperty("points");
                    art.setPoints(points.getString());
                } catch (RepositoryException repositoryException) {
                    //NOTHING IS REQUIRED
                }
                art.setMessage(blogtext.getString());
                art.setTitle(blogtitle.getString());
                art.setUuid(node.getUUID());
                art.setUserId(blogAuther.getString());
                art.setStatus(blogStatus.getString());
                if (blogdate != null) {
                    art.setcDate(blogdate.getDate().getTime());
                }
                LOG.info(" Article is " + art);
                ll.add(art);
            }
        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RepositoryException ex) {
            LOG.error("Repository Exception in getting all the blogs " + ex);
        } finally {
            if (s != null) {
                s.logout();
            }
        }

        return ll;

    }

    public List getArticlesByRange(int start, int end) {
        return null;
    }

    public List getArticlesByStatus(String status) {
        List ll = new ArrayList();
        Session s = null;
        try {
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);
            s = r.login();
            Workspace ws = s.getWorkspace();
            QueryManager queryMan = ws.getQueryManager();

            //Specify an XPATH query. SQL could be used as well.
            StringBuffer qstr = new StringBuffer("//blog[@blogStatus = '");
            qstr.append(status);
            qstr.append("']");
            Query q = queryMan.createQuery(qstr.toString(), Query.XPATH);
            QueryResult results = q.execute();
            NodeIterator it = results.getNodes();
            while (it.hasNext()) {
                Node node = it.nextNode();
                Property blogtitle = node.getProperty("blogtitle");
                Property blogtext = node.getProperty("blogtext");
                Property blogdate = node.getProperty("blogdate");
                Property blogAuther = node.getProperty("blogauthor");
                Property blogStatus = node.getProperty("blogStatus");
                Article art = new Article();
                try {
                    Property coments = node.getProperty("coments");
                    art.setComents(coments.getString());
                    Property points = node.getProperty("points");
                    art.setPoints(points.getString());
                } catch (RepositoryException repositoryException) {
                    //NOTHING IS REQUIRED
                }
                art.setMessage(blogtext.getString());
                art.setTitle(blogtitle.getString());
                art.setUuid(node.getUUID());
                art.setUserId(blogAuther.getString());
                art.setStatus(blogStatus.getString());
                if (blogdate != null) {
                    art.setcDate(blogdate.getDate().getTime());
                }
                LOG.info(" Article is " + art);
                ll.add(art);
            }
        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RepositoryException ex) {
            LOG.error("Repository Exception in getting all the blogs " + ex);
        } finally {
            if (s != null) {
                s.logout();
            }
        }
        return ll;
    }

    public Article getArticleByUUID(String userId,String uuid){
          Article art =null;
           Session s = null;
        try {
            Credentials credentials = new SimpleCredentials(userId, PASSWORD);
            if(r == null)
                r = (Repository) ctx.lookup(REPO_NAME);
            s  = r.login(credentials);
            Node node = s.getNodeByUUID(uuid);
            if (node != null) {
               Property blogtitle = node.getProperty("blogtitle");
                Property blogtext = node.getProperty("blogtext");
                Property blogdate = node.getProperty("blogdate");
                Property blogAuther = node.getProperty("blogauthor");
                Property blogStatus = node.getProperty("blogStatus");
                art = new Article();
                try {
                    Property coments = node.getProperty("coments");
                    art.setComents(coments.getString());
                    Property points = node.getProperty("points");
                    art.setPoints(points.getString());
                } catch (RepositoryException repositoryException) {
                    //NOTHING IS REQUIRED
                }
                art.setMessage(blogtext.getString());
                art.setTitle(blogtitle.getString());
                art.setUuid(node.getUUID());
                art.setUserId(blogAuther.getString());
                art.setStatus(blogStatus.getString());
            }

        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(BlogUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RepositoryException ex) {
            LOG.error("Repository Exception in getting all the blogs " + ex);
        }finally{
            if(s != null){
                s.logout();
            }
        }
        return art;
    }
}
