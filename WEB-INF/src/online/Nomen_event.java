package online;

import common.DatabaseObj;
import manager.Log;

import javax.servlet.ServletContext;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Nomen_event class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Nomen_event.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Nomen_event {

    public int orginal_rgd_id;
    public String notes;
    public Date event_date;
    public String description;
    public String descriptions[];
    public String nomen_status_type;
    public String nomen_status_types[];
    public String the_nomen_status[];
    public int ref_key;
    public String name;
    public String symbol;
    public String rgd_id;
    public int nomen_event_key;
    Log log = new Log();
    public DatabaseObj dbObj;
    public ServletContext mycontext;
//DatabaseObj dbObj = new DatabaseObj("dev_1");

    public Nomen_event() {
    }

    public Nomen_event(ResultSet results)
            throws SQLException {
        nomen_event_key = results.getInt("nomen_event_key");
        nomen_status_type = results.getString("nomen_status_type");
        event_date = results.getDate("event_date");
        symbol = results.getString("symbol");
        name = results.getString("name");
        description = results.getString("description");
    }

    /* retrieve db handler from servlet context */
    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DEVHDL");
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String newDescription) {
        description = newDescription;
    }

    public Date getEvent_date() {
        return event_date;
    }

    public void setEvent_date(Date newEvent_date) {
        event_date = newEvent_date;
    }

    public String getName() {
        return name;
    }

    public void setName(String newName) {
        name = newName;
    }

    public int getNomen_event_key() {
        return nomen_event_key;
    }

    public void setNomen_event_key(int newNomen_event_key) {
        nomen_event_key = newNomen_event_key;
    }

    public String getNomen_status_type() {
        return nomen_status_type;
    }

    public void setNomen_status_type(String newNomen_status_type) {
        nomen_status_type = newNomen_status_type;
    }

    public String[] getNomen_status_types() {
        nomen_status_types = dbObj.getTypes("nomen_status_key", "nomen_status_types");
        return nomen_status_types;
    }

    public void setNomen_status_types(String[] newNomen_status_types) {
        nomen_status_types = newNomen_status_types;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String newNotes) {
        notes = newNotes;
    }

    public int getOrginal_rgd_id() {
        return orginal_rgd_id;
    }

    public void setOrginal_rgd_id(int newOrginal_rgd_id) {
        orginal_rgd_id = newOrginal_rgd_id;
    }

    public int getRef_key() {
        return ref_key;
    }

    public void setRef_key(int newRef_key) {
        ref_key = newRef_key;
    }

    public String getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(String newRgd_id) {
        rgd_id = newRgd_id;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String newSymbol) {
        symbol = newSymbol;
    }

    public String[] getDescriptions() {
        descriptions = dbObj.getTypes("description", "nomen_status_types");
        return descriptions;
    }

    public void setDescriptions(String[] newDescriptions) {
        descriptions = newDescriptions;
    }

    /*---------------------------------------------------
    ---------------------------------------------------*/
    public boolean Create_NomenEvent(String sql) {
        String SQLString = "";
        int nomen_event_key = 0;
        try {
            String table = "NOMEN_EVENTS";
            String col = "nomen_event_key";
            nomen_event_key = dbObj.generate_key(table, col);

            SQLString = "insert into nomen_events(nomen_event_key,symbol,name,previous_symbol,previous_name,ref_key,nomen_status_type," +
                    "description,notes,rgd_id,original_rgd_id,event_date)" +
                    " values(" + nomen_event_key + sql +
                    ", SYSDATE)";
//System.out.println("SQL insert nomen= " + SQLString);
            dbObj.executeUpdate(SQLString);
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
        return true;
    }

/*----------------------------------
-----------------------------------*/



}