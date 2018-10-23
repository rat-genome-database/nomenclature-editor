package online;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Sequence class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Sequence.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Sequence {

    private int sequence_key;
    private int sequence_type_key;
    private int rgd_id;
    private String sequence_desc;
    // seq_types
    private String sequence_type;
    // seq_clones
    private String clone_name;
    // seq_lprimer_pairs
    private String forward_seq;
    private String reverse_seq;
//  DatabaseObj dbObj = new DatabaseObj("dev_1");

    Sequence() {
    }

    public Sequence(ResultSet results, int type)
            throws SQLException {
        sequence_key = results.getInt("sequence_key");
        //sequence_type = results.getString("sequence_type");
        if (type == 1) {
            forward_seq = results.getString("forward_seq");
            reverse_seq = results.getString("reverse_seq");
        } else {
            clone_name = results.getString("clone_name");
        }
    }

    public int getSequence_key() {
        return sequence_key;
    }

    public void setSequence_key(int newSequence_key) {
        sequence_key = newSequence_key;
    }

    public String getClone_name() {
        return clone_name;
    }

    public void setClone_name(String newClone_name) {
        clone_name = newClone_name;
    }

    public String getForward_seq() {
        return forward_seq;
    }

    public void setForward_seq(String newForward_seq) {
        forward_seq = newForward_seq;
    }

    public String getReverse_seq() {
        return reverse_seq;
    }

    public void setReverse_seq(String newReverse_seq) {
        reverse_seq = newReverse_seq;
    }

    public String getSequence_desc() {
        return sequence_desc;
    }

    public void setSequence_desc(String newSequence_desc) {
        sequence_desc = newSequence_desc;
    }

    public String getSequence_type() {
        return sequence_type;
    }

    public void setSequence_type(String newSequence_type) {
        sequence_type = newSequence_type;
    }


}
