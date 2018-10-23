package online;

import common.DatabaseObj;
import manager.Log;

import javax.servlet.ServletContext;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Note class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Note.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Note {

    public int note_key;
    public String public_y_n;
    public String notes_type_name_lc;
    public String notes;
    public Date creation_date;
    public int rgd_id;
    public String note_types[];

    public Log log = new Log();
    public DatabaseObj dbObj;
    public ServletContext mycontext;


    public Note() {
        //dbObj = new DatabaseObj("dev_1");
    }

    public Note(ResultSet results)
            throws SQLException {
        note_key = results.getInt("note_key");
        public_y_n = results.getString("public_y_n");
        notes_type_name_lc = results.getString("notes_type_name_lc");
        notes = results.getString("notes");
        //creation_date = results.getDate("creation_date");
    }

    /* retrieve db handler from servlet context */
    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DEVHDL");
    }

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date newCreation_date) {
        creation_date = newCreation_date;
    }

    public int getNote_key() {
        return note_key;
    }

    public void setNote_key(int newNote_key) {
        note_key = newNote_key;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String newNotes) {
        notes = newNotes;
    }

    public String getNotes_type_name_lc() {
        return notes_type_name_lc;
    }

    public void setNotes_type_name_lc(String newNotes_type_name_lc) {
        notes_type_name_lc = newNotes_type_name_lc;
        System.out.println("note type" + notes_type_name_lc);
    }

    public String getPublic_y_n() {
        return public_y_n;
    }

    public void setPublic_y_n(String newPublic_y_n) {
        public_y_n = newPublic_y_n;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public void setNote_types(String[] newNote_types) {
        note_types = newNote_types;
    }

    public String[] getNote_types() {
        note_types = dbObj.getTypes("notes_type_name_lc", "note_types");
        return note_types;
    }


    ///////////////////////////////////////////////////////////////////////
    public boolean createNote() {

        String SQLString1 = "";
        String SQLString2 = "";
        String SQLString3 = "";
        String notes2 = "";
        ResultSet rs1 = null;
        ResultSet rs2 = null;

        SQLString1 = "select MAX(note_key) from notes";
        SQLString2 = "select notes from notes " +
                "where rgd_id =" + rgd_id +
                " AND notes_type_name_lc =" + dbObj.formatWithTicks(notes_type_name_lc);

        try {
            rs1 = dbObj.executeQuery(SQLString1);
            while (rs1.next()) {
                note_key = rs1.getInt("MAX(note_key)") + 1;
            }

            rs2 = dbObj.executeQuery(SQLString2);
            while (rs2.next()) {
                notes2 = rs2.getString("notes");
            }

            if ((notes2 != null) && (notes2.equals(notes))) {
                return false;
            } else {
                SQLString3 = "insert into notes(note_key, notes, creation_date, " +
                        "rgd_id, notes_type_name_lc, public_y_n)" +
                        " values(" + note_key + "," + dbObj.formatWithTicks(notes) +
                        ", SYSDATE ," + rgd_id +
                        "," + dbObj.formatWithTicks(notes_type_name_lc) +
                        "," + dbObj.formatWithTicks(public_y_n) + ")";

                dbObj.executeUpdate(SQLString3);

                //record action into Log
                log.recordAction("insert", "notes", SQLString3, null);
            }
            return true;
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }

    }

///////////////////////////////////////////////////////////////////

    public boolean updateNote(int note_key) {

        String SQLString = "";
        String SQLString2 = "";
        String p = null;
        String public_y_n2 = null;
        String notes_type_name_lc2 = null;
        String notes2 = null;
        ResultSet rs = null;
        this.note_key = note_key;

        SQLString = "update notes set " +
                "public_y_n =" + dbObj.formatWithTicks(public_y_n) + "," +
                "notes_type_name_lc =" + dbObj.formatWithTicks(notes_type_name_lc) + "," +
                "notes =" + dbObj.formatWithTicks(notes) + "," +
                "creation_date = SYSDATE " +
                "where note_key =" + note_key;
        SQLString2 = "select * from notes where note_key =" + note_key;

        //System.out.println("SQL update= " + SQLString);
        try {
            rs = dbObj.executeQuery(SQLString2);
            while (rs.next()) {
                public_y_n2 = rs.getString("public_y_n");
                notes_type_name_lc2 = rs.getString("notes_type_name_lc");
                notes2 = rs.getString("notes");
            }
            String old_record = "PUBLIC_Y_N==" + public_y_n2 + "::" +
                    "NOTES_TYPE_NAME_LC==" + notes_type_name_lc2 + "::" +
                    "NOTES==" + notes2 + "::";

            //int rs2 = dbObj.executeUpdate(SQLString);
            dbObj.executeUpdate(SQLString);
            if (!(public_y_n2.equalsIgnoreCase(public_y_n) && notes2.equalsIgnoreCase(notes)))
                log.recordAction("update", "notes", SQLString, old_record);

            return true;
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
    }
///////////////////////////////////////////////////////////////////

}