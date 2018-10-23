package common;

import oracle.jdbc.driver.OracleConnection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * DBconnectedForMerge class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/common/DBconnectedForMerge.java,v 1.2 2007/04/30 19:26:15 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:26:15 $
 */
public class DBconnectedForMerge {

    final String propertyFile = new ChoosePropertyFile().getPropertyFile();

    private static Properties prop;
    protected static String url = null;
    protected static String uid = null;
    protected static String pwd = null;
    private static String dss_url = null;
    private static String dss_uid = null;
    private static String dss_pwd = null;
    private static String db_instance = null;

    String db_switcher = null;

    protected static String connection_way = null;

    public DBconnectedForMerge() {
    }

    public DBconnectedForMerge(String DB_switcher) {
        initializeProps();
        setDb_switcher(DB_switcher);
        // properties();
    }

    public void setDb_switcher(String DB_switcher) {
        db_switcher = DB_switcher;
    }

    public String getProperty(String key) {
        return prop.getProperty(key);
    }

    /**
     * Load  properties file from /properties file relative to Tomcat installation directory. Specific to Tomcat !
     */
    private static void initializeProps() {
        try {
            if (null == prop) {
                Properties prop = new Properties();
                System.out.println("catalina.home = " + System.getProperty("catalina.home"));
                File catalinaHome = new File(System.getProperty("catalina.home"));
                InputStream is = null;
                String filePath = catalinaHome.getCanonicalFile() + "/properties/" + ChoosePropertyFile.getPropertyFile();
                try {
                    is = new FileInputStream(filePath);
                } catch (IOException e) {
                    System.out.println("ERROR Loading properties file " + filePath + " Error : " + e);
                }

                prop.load(is);

                // prop = PropertyLoader.loadProperties(ChoosePropertyFile.getPropertyFile());
                url = prop.getProperty("URL");
                uid = prop.getProperty("UID");
                pwd = prop.getProperty("PWD");
                dss_url = prop.getProperty("DSSURL");
                dss_uid = prop.getProperty("DSSUID");
                dss_pwd = prop.getProperty("DSSPWD");
                connection_way = prop.getProperty("CONNECTION_WAY");
                db_instance = prop.getProperty("DB_INSTANCE");
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }

    }

    public static synchronized java.sql.Connection getConnection() {
        initializeProps();
        java.sql.Connection jdbcConn = null;
        if (connection_way.equals("manu")) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                jdbcConn = (OracleConnection) java.sql.DriverManager.getConnection(url, uid, pwd);
            }
            catch (SQLException e) {
                System.out.println(e);
            }
            catch (ClassNotFoundException ee) {
                System.out.println(ee);
            }
            catch (IllegalAccessException eee) {
                System.out.println(eee);
            }
            catch (InstantiationException eeee) {
                System.out.println(eeee);
            }
        } else {
            try {
                Context ic = new InitialContext();
                DataSource ds = (DataSource) ic.lookup(db_instance);
                jdbcConn = ds.getConnection();
            }
            catch (NamingException eee) {
                System.out.println(eee);
            }
            catch (SQLException se) {
                System.out.println(se);
            }
        }
        return jdbcConn;
    }

    public static synchronized java.sql.Connection getDSSConnection() {
        initializeProps();
        java.sql.Connection jdbcConn = null;
        if (connection_way.equals("manu")) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                jdbcConn = (OracleConnection) java.sql.DriverManager.getConnection(dss_url, dss_uid, dss_pwd);
            }
            catch (SQLException e) {
                System.out.println(e);
            }
            catch (ClassNotFoundException ee) {
                System.out.println(ee);
            }
            catch (IllegalAccessException eee) {
                System.out.println(eee);
            }
            catch (InstantiationException eeee) {
                System.out.println(eeee);
            }
        } else {
            try {
                Context ic = new InitialContext();
                DataSource ds = (DataSource) ic.lookup(db_instance);
                jdbcConn = ds.getConnection();
            }
            catch (NamingException eee) {
                System.out.println(eee);
            }
            catch (SQLException se) {
                System.out.println(se);
            }
        }
        return jdbcConn;
    }

    /**
     * ******************************************
     */
    public void properties() {
        try {
            initializeProps();
            prop.load(new FileInputStream(propertyFile));
            connection_way = getProperty("CONNECTION_WAY");

            if (db_switcher.equals("dev_1")) {//for mergergd properties
                url = getProperty("URL_MERGERGD");
                uid = getProperty("UID_MERGERGD");
                pwd = getProperty("PWD_MERGERGD");
                db_instance = getProperty("DB_INSTANCE_MERGERGD");
            } else if (db_switcher.equals("dss")) {//for mergesub properties
                url = getProperty("URL_DSS");
                uid = getProperty("UID_DSS");
                pwd = getProperty("PWD_DSS");
                db_instance = getProperty("DB_INSTANCE_MERGESUB");
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }

    public void closeConnection(PreparedStatement ps, ResultSet rs, Connection con) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        catch (SQLException ignored) {
        }
    }

    public void closeConnection(Statement st, ResultSet rs, Connection con) {
        try {
            if (st != null) st.close();
            if (rs != null) rs.close();
            if (con != null) con.close();
        }
        catch (SQLException ignored) {
        }
    }
}
