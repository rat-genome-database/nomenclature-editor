package online;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * QTL class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/QTL.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class QTL {

    private int qtl_key;
    private String qtl_symbol;
/*
  Log log;
  String qtl_name;
  String qtl_symbol_lc;
  String qtl_name_lc;
  int peak_offset;
  String chromosome;
  int lod;
  int p_value;
  int variance;
  String notes;
  int rgd_id;
  int trait_key;
  int flank_1_rgd_id;
  int flank_2_rgd_id;
  int peak_rgd_id;
  String inheritance_type;
*/
    // DatabaseObj dbObj = new DatabaseObj("dev_1");

    public QTL() {
    }

    public QTL(ResultSet results)
            throws SQLException {
        qtl_key = results.getInt("qtl_key");
        qtl_symbol = results.getString("qtl_symbol");
    }


    public int getQtl_key() {
        return qtl_key;
    }

    public void setQtl_key(int newQtl_key) {
        qtl_key = newQtl_key;
    }

    public String getQtl_symbol() {
        return qtl_symbol;
    }

    public void setQtl_symbol(String newQtl_symbol) {
        qtl_symbol = newQtl_symbol;
    }

}