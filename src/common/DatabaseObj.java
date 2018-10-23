package common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

/**
 * DatabaseObj
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/common/DatabaseObj.java,v 1.3 2007/04/30 19:26:15 gkowalski Exp $
 * $Revision: 1.3 $
 * $Date: 2007/04/30 19:26:15 $
 */
public class DatabaseObj {

    private Connection connection = null;
    private Statement statement = null;
    private ResultSet rs = null;
    private String types[];

    public DatabaseObj() {

    }

    public DatabaseObj(String db) {

        // DBconnectedForMerge dbcon=new DBconnectedForMerge(db);
        try {
            if (db != null && db.equals("dss")) {
                connection = new DBconnectedForMerge(db).getDSSConnection();
            } else {
                connection = new DBconnectedForMerge(db).getConnection();
            }
            statement = connection.createStatement();
        }
        catch (SQLException ee) {
            System.out.println("Exception in DatabaseObj : " + ee.getMessage());
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public void closeDatabase() {
        new DBconnectedForMerge().closeConnection(statement, rs, connection);
    }

    public ResultSet executeQuery(String sql) throws SQLException {
        rs = statement.executeQuery(sql);
        return rs;
    }

    public void executeUpdate(String sql) throws SQLException {
        int n = statement.executeUpdate(sql);
    }


    public String formatWithTicks(String string) {
        if ((string == null) || (string.equals(""))) {
            return "null";
        } else {
            char[] in = string.toCharArray();
            StringBuffer out = new StringBuffer((int) (in.length * 1.1));

            if (in.length > 0)
                out.append("'");
            for (int i = 0; i < in.length; i++) {
                out.append(in[i]);
                if (in[i] == '\'')
                    out.append(in[i]);
            }
            if (in.length > 0)
                out.append("'");
            return out.toString();
        }
    }


    public String[] getTypes(String columnName, String Table) {

        String sql = "";
        ResultSet rs = null;

        sql = " select DISTINCT " + columnName + " from " + Table;
        try {
            rs = executeQuery(sql);

            Vector v = new Vector();
            while (rs.next())
                v.addElement(new String(rs.getString(columnName)));

            types = new String[v.size()];
            v.copyInto(types);

        }
        catch (SQLException e) {
        }
        return types;
    }


    public Vector querykeys(String sql, String col_nm) {

        ResultSet rs = null;
        int id = -1;
        Vector keys = new Vector();

        try {
            rs = executeQuery(sql);
            while (rs.next()) {
                id = rs.getInt(col_nm);
                keys.addElement(new Integer(id));
            }

        }
        catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return keys;
    }


    public int generate_key(String table, String key_name) {

        String SQLString = "";
        ResultSet rs = null;
        int nextkey = -1;

        SQLString = "select MAX(" + key_name + ") KEY from " + table;

        try {
            rs = executeQuery(SQLString);
            while (rs.next()) {
                nextkey = rs.getInt("KEY") + 1;
            }

        }
        catch (Exception ex) {
            System.out.println(ex.toString());
        }
        return nextkey;
    }


}
