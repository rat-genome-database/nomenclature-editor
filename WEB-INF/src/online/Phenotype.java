package online;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Phenotype class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Phenotype.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Phenotype {

    private int phe_key;
    private String phe_symbol;
    private String phe_desc;
//  private String history;        
//  private String notes;          
//  private int rgd_id;         
//  DatabaseObj dbObj = new DatabaseObj("dev_1");

    public Phenotype() {
    }

    // created for Gene.search_aliases()
    public Phenotype(ResultSet results)
            throws SQLException {
        phe_key = results.getInt("phe_key");
        phe_symbol = results.getString("phe_symbol");
        phe_desc = results.getString("phe_desc");
    }


    public int getPhe_key() {
        return phe_key;
    }

    public void setPhe_key(int newPhe_key) {
        phe_key = newPhe_key;
    }

    public String getPhe_desc() {
        return phe_desc;
    }

    public void setPhe_desc(String newPhe_desc) {
        phe_desc = newPhe_desc;
    }

    public String getPhe_symbol() {
        return phe_symbol;
    }

    public void setPhe_symbol(String newPhe_symbol) {
        phe_symbol = newPhe_symbol;
    }


}