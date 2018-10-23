package online;

import common.DatabaseObj;

import javax.servlet.ServletContext;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * XDB class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/XDB.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class XDB {

    private int acc_xdb_key;
    private int xdb_key;
    private String acc_id;
    private int rgd_id;
    private String link_text;
    private String xdb_name;  // rgd_xdb table
//  DatabaseObj dbObj = new DatabaseObj("dev_1");

    public DatabaseObj dbObj;
    public ServletContext mycontext;

    public XDB() {
    }

    /* retrieve db handler from servlet context */
    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DEVHDL");
    }

    public XDB(ResultSet results)
            throws SQLException {
        acc_xdb_key = results.getInt("acc_xdb_key");
        xdb_key = results.getInt("xdb_key");
        acc_id = results.getString("acc_id");
        xdb_name = results.getString("xdb_name");
        link_text = results.getString("link_text");
    }


    public int getAcc_xdb_key() {
        return acc_xdb_key;
    }

    public void setAcc_xdb_key(int newAcc_xdb_key) {
        acc_xdb_key = newAcc_xdb_key;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public int getXdb_key() {
        return xdb_key;
    }

    public void setXdb_key(int newXdb_key) {
        xdb_key = newXdb_key;
    }

    public String getXdb_name() {
        return xdb_name;
    }

    public void setXdb_name(String newXdb_name) {
        xdb_name = newXdb_name;
    }

    public String getAcc_id() {
        return acc_id;
    }

    public void setAcc_id(String newAcc_id) {
        acc_id = newAcc_id;
    }

    public String getLink_text() {
        return link_text;
    }

    public void setLink_text(String newLink_text) {
        link_text = newLink_text;
    }

    /*----------------------------------------------------------------------
    update Link Text field if the gene symbol == the link Text.
    ------------------------------------------------------------*/
    public boolean updateXdbs(String gene_symbol, int acc_xdb_key) {

        String SQLString = "";

        SQLString = "UPDATE rgd_acc_xdb SET link_text='" + gene_symbol + "'" +
                " where acc_xdb_key=" + acc_xdb_key;

        try {
            dbObj.executeUpdate(SQLString);
            return true;
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
    }

    /*----------------------------------------------------------------------
    ------------------------------------------------------------*/

}
