package online;

import common.DatabaseObj;
import manager.Log;

import javax.servlet.ServletContext;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Alias class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Alias.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Alias {

    public String alias_types[];
    public int rgd_id;
    public String notes;
    public String alias_value_lc;
    public String alias_value;
    public String alias_type_name_lc;
    public int alias_key;
    public Log log = new Log();
    public DatabaseObj dbObj;
    public ServletContext mycontext;
//DatabaseObj dbObj = new DatabaseObj("dev_1");

    public Alias() {
    }

    // created for Gene.search_aliases()
    public Alias(ResultSet results)
            throws SQLException {
        alias_key = results.getInt("alias_key");
        alias_type_name_lc = results.getString("alias_type_name_lc");
        alias_value = results.getString("alias_value");
    }

    /* retrieve db handler from servlet context */
    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DEVHDL");
    }

    public int getAlias_key() {
        return alias_key;
    }

    public void setAlias_key(int newAlias_key) {
        alias_key = newAlias_key;
    }

    public String[] getAlias_types() {
        alias_types = dbObj.getTypes("alias_type_name_lc", "alias_types");
        return alias_types;
    }

    public void setAlias_types(String[] newAlias_types) {
        alias_types = newAlias_types;
    }

    public String getAlias_value() {
        return alias_value;
    }

    public void setAlias_value(String newAlias_value) {
        alias_value = newAlias_value;
    }

    public String getAlias_value_lc() {
        return alias_value_lc;
    }

    public void setAlias_value_lc(String newAlias_value_lc) {
        alias_value_lc = newAlias_value_lc;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String newNotes) {
        notes = newNotes;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public String getAlias_type_name_lc() {
        return alias_type_name_lc;
    }

    public void setAlias_type_name_lc(String newAlias_type_name_lc) {
        alias_type_name_lc = newAlias_type_name_lc;
    }

/*---------------------------------------------------
---------------------------------------------------*/

    public boolean createAlias(int rgd_id, String alias_value, String alias_type) {

        String SQLString = "";
        String SQLString1 = "";
        ResultSet rs = null;
        String notes = null;
        int alias_key = 0;

        SQLString = "select count(alias_key) COUNT from aliases where rgd_id=" + rgd_id +
                " and alias_value='" + alias_value + "'";
//System.out.println("check alias= " + SQLString);

        try {
            // first check the unique constrain
            int count = -1;
            rs = dbObj.executeQuery(SQLString);
            while (rs.next()) {
                count = rs.getInt("COUNT");
            }
//System.out.println("dup alias= " + count);
            if (count == 0) {
                String table = "ALIASES";
                String col = "alias_key";
                alias_key = dbObj.generate_key(table, col);

                SQLString1 = "insert into aliases(alias_key, alias_type_name_lc,alias_value,alias_value_lc,notes,rgd_id)" +
                        " values(" + alias_key + "," + dbObj.formatWithTicks(alias_type) +
                        "," + dbObj.formatWithTicks(alias_value) +
                        ", lower(" + dbObj.formatWithTicks(alias_value) +
                        ")," + dbObj.formatWithTicks(notes) +
                        "," + rgd_id + ")";
//System.out.println("SQL insert alias= " + SQLString1 );
                dbObj.executeUpdate(SQLString1);
            }
        } // end try
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
        return true;
    }

/*---------------------------------------------------
---------------------------------------------------*/

}
