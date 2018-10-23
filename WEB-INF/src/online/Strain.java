package online;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Strain class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Strain.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Strain {

    public int strain_key;
    public String strain_symbol;

    public Strain() {
    }

    public Strain(ResultSet results)
            throws SQLException {
        strain_key = results.getInt("strain_key");
        strain_symbol = results.getString("strain_symbol");
    }

    public int getStrain_key() {
        return strain_key;
    }

    public void setStrain_key(int newStrain_key) {
        strain_key = newStrain_key;
    }

    public String getStrain_symbol() {
        return strain_symbol;
    }

    public void setStrain_symbol(String newStrain_symbol) {
        strain_symbol = newStrain_symbol;
    }


}