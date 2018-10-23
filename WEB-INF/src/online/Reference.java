package online;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Phenotype class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Reference.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Reference {

    private int ref_key;
    private int rgd_id;
    private String citation;

    public Reference(ResultSet results)
            throws SQLException {
        ref_key = results.getInt("ref_key");
        rgd_id = results.getInt("rgd_id");
        citation = results.getString("citation");

    }

    public int getRef_key() {
        return ref_key;
    }

    public void setRef_key(int newRef_key) {
        ref_key = newRef_key;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public String getCitation() {
        return citation;
    }

    public void setCitation(String newCitation) {
        citation = newCitation;
    }

}