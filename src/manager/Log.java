package manager;


import common.DatabaseObj;

import javax.servlet.ServletContext;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Log Class - Logs results to logs database table
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/manager/Log.java,v 1.3 2007/04/30 19:25:46 gkowalski Exp $
 * $Revision: 1.3 $
 * $Date: 2007/04/30 19:25:46 $
 */
public class Log {
    public int user_key;
    public Date last_mod_date;
    public String old_record;
    public String db_action;
    public String sql_stmt;
    public String data_obj;
    public String rgd_table;
    public String source_type = "online";
    public int log_key;
//DatabaseObj dbObj = new DatabaseObj("dss");
    public ServletContext mycontext;
    public DatabaseObj dbObj;

    public Log() {
    }

    public Log(ResultSet results) throws SQLException {
        user_key = results.getInt("user_key");
        last_mod_date = results.getDate("last_mod_date");
        old_record = results.getString("old_record");
        db_action = results.getString("db_action");
        sql_stmt = results.getString("sql_stmt");
        data_obj = results.getString("data_obj");
        rgd_table = results.getString("rgd_table");
        source_type = results.getString("source_type");
        log_key = results.getInt("log_key");
    }

    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DSSHDL");
    }

    public String getData_obj() {
        return data_obj;
    }

    public void setData_obj(String newData_obj) {
        data_obj = newData_obj;
//  System.out.println("data_obj_" + data_obj);
    }

    public String getDb_action() {
        return db_action;
    }

    public void setDb_action(String newDb_action) {
        db_action = newDb_action;
    }

    public Date getLast_mod_date() {
        return last_mod_date;
    }

    public void setLast_mod_date(Date newLast_mod_date) {
        last_mod_date = newLast_mod_date;
    }

    public int getLog_key() {
        return log_key;
    }

    public void setLog_key(int newLog_key) {
        log_key = newLog_key;
    }

    public String getOld_record() {
        return old_record;
    }

    public void setOld_record(String newOld_record) {
        old_record = newOld_record;
    }

    public String getRgd_table() {
        return rgd_table;
    }

    public void setRgd_table(String newRgd_table) {
        rgd_table = newRgd_table;
    }

    public String getSource_type() {
        return source_type;
    }

    public void setSource_type(String newSource_type) {
        source_type = newSource_type;
    }

    public String getSql_stmt() {
        return sql_stmt;
    }

    public void setSql_stmt(String newSql_stmt) {
        sql_stmt = newSql_stmt;
    }

    public int getUser_key() {
        return user_key;
    }

    public void setUser_key(int newUser_key) {
        user_key = newUser_key;
//    System.out.println("user_key_" + user_key);
    }

    public DatabaseObj getDbObj() {
        return dbObj;
    }

    public void setDbObj(DatabaseObj newDbObj) {
        dbObj = newDbObj;
    }

    ///////////////////////////////////////////////////////////////////////////

    public void recordAction(String db_action, String rgd_table,
                             String sql_stmt, String old_record) {
        this.db_action = db_action;
        this.rgd_table = rgd_table;
        this.sql_stmt = sql_stmt;
        this.old_record = old_record;

        String SQLString1 = "";
        String SQLString2 = "";
        ResultSet rs = null;

        SQLString1 = "select MAX(log_key) from logs";

        try {
            rs = dbObj.executeQuery(SQLString1);
            while (rs.next()) {
                log_key = rs.getInt("MAX(log_key)") + 1;
            }

            SQLString2 = "insert into logs(log_key, source_type, rgd_table, " +
                    "data_obj, sql_stmt, db_action, old_record, last_mod_date, user_key)" +
                    " values(" + log_key + "," + dbObj.formatWithTicks(source_type) +
                    "," + dbObj.formatWithTicks(rgd_table) +
                    "," + dbObj.formatWithTicks(data_obj) +
                    "," + dbObj.formatWithTicks(sql_stmt) +
                    "," + dbObj.formatWithTicks(db_action) +
                    "," + dbObj.formatWithTicks(old_record) +
                    ", SYSDATE ," + user_key + ")";
//System.out.println("SQL log= " + SQLString2 );      
            //int rs2 = dbObj.executeUpdate(SQLString2);
            dbObj.executeUpdate(SQLString2);
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
        }

    }

}