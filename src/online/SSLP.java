package online;

import manager.Log;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * SSLP class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/SSLP.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class SSLP {

    private int sslp_key;
    private String rgd_name;
    private String rgd_name_lc;
    private int rgd_id;
    private int expected_size;
    private String notes;

    public Log log = new Log();
//  DatabaseObj dbObj = new DatabaseObj("dev_1");

    public SSLP() {
    }

    public SSLP(ResultSet results)
            throws SQLException {
        sslp_key = results.getInt("sslp_key");
        rgd_name = results.getString("rgd_name");
    }


    public int getSslp_key() {
        return sslp_key;
    }

    public void setSslp_key(int newSslp_key) {
        sslp_key = newSslp_key;
    }

    public String getRgd_name() {
        return rgd_name;
    }

    public void setRgd_name(String newRgd_name) {
        rgd_name = newRgd_name;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }


}