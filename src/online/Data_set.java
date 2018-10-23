package online;

import common.DatabaseObj;
import manager.Log;

import javax.servlet.ServletContext;
import java.sql.ResultSet;
import java.util.StringTokenizer;
import java.util.Vector;


/**
 * Data_set class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Data_set.java,v 1.3 2007/09/10 18:36:00 jdepons Exp $
 * $Revision: 1.3 $
 * $Date: 2007/09/10 18:36:00 $
 */
public class Data_set {

    public DatabaseObj dbObj;
    public ServletContext mycontext;

    public Data_set() {
    }

    public Log log = new Log();

    /* retrieve db handler from servlet context */
    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DEVHDL");
        // pass servlet context to log.java
        log.setContext(mycontext);
    }

    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation4> online.Gene
     */
    private Gene gene[];
    /*
    * Define a double-subscripted Array of Reference type
    * to handle multiple genes in case of Merge
    */
    private Reference reference[][];

    // Define a double-subscripted Array of Alias type
    private Alias alias[][];

    // an array of Homologs type
    private Homologs homologs[][];

    // an array of XDB type
    private XDB xdb[][];

    // an array of Strain type
    private Strain strain[][];

    // an array of SSLP type
    private SSLP sslp[][];

    // an array of QTL type
    private QTL qtl[][];

    // an array of Maps type
    private Maps maps[][];

    // an array of Phenotype type
    private Phenotype phenotype[][];

    // an array of Note type
    private Note note[][];

    // an array of Sequence type
    private Sequence sequence[][];

    // an array of Nomen_event type
    private Nomen_event nomen_event[][];

    public Gene[] getGene() {
        return gene;
    }

    public void setGene(Gene[] newGene) {
        gene = newGene;
    }

    public Reference[][] getReference() {
        return reference;
    }

    public void setReference(Reference[][] newReference) {
        reference = newReference;
    }

    public Phenotype[][] getPhenotype() {
        return phenotype;
    }

    public void setPhenotype(Phenotype[][] newPhenotype) {
        phenotype = newPhenotype;
    }

    public Alias[][] getAlias() {
        return alias;
    }

    public void setAlias(Alias[][] newAlias) {
        alias = newAlias;
    }

    public Homologs[][] getHomologs() {
        return homologs;
    }

    public void setHomologs(Homologs[][] newHomologs) {
        homologs = newHomologs;
    }

    public Maps[][] getMaps() {
        return maps;
    }

    public void setMaps(Maps[][] newMaps) {
        maps = newMaps;
    }

    public Nomen_event[][] getNomen_event() {
        return nomen_event;
    }

    public void setNomen_event(Nomen_event[][] newNomen_event) {
        nomen_event = newNomen_event;
    }

    public Note[][] getNote() {
        return note;
    }

    public void setNote(Note[][] newNote) {
        note = newNote;
    }

    public QTL[][] getQtl() {
        return qtl;
    }

    public void setQtl(QTL[][] newQtl) {
        qtl = newQtl;
    }

    public Sequence[][] getSequence() {
        return sequence;
    }

    public void setSequence(Sequence[][] newSequence) {
        sequence = newSequence;
    }

    public SSLP[][] getSslp() {
        return sslp;
    }

    public void setSslp(SSLP[][] newSslp) {
        sslp = newSslp;
    }

    public Strain[][] getStrain() {
        return strain;
    }

    public void setStrain(Strain[][] newStrain) {
        strain = newStrain;
    }

    public XDB[][] getXdb() {
        return xdb;
    }

    public void setXdb(XDB[][] newXdb) {
        xdb = newXdb;
    }


    /*---------------------------------------------------
     This method returns boolean based on the object
     status of given gene symbols or rgd_ids
    ---------------------------------------------------*/
    public boolean checkStatus(String SQLString) {
        ResultSet rs = null;
        int count = -1;

        try {
            rs = dbObj.executeQuery(SQLString);
            while (rs.next()) {
                count = rs.getInt("COUNT");
            }
            if (count == 2) {
                return true;
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
        return false;
    }

    /*---------------------------------------------------
     This method returns multiple Genes value set only
     if results found on both given rgd_ids or gene_symbols
     Returns false otherwise.
    ---------------------------------------------------*/
    public boolean searchGeneset(String SQLString) {
        ResultSet rs = null;
        try {
            rs = dbObj.executeQuery(SQLString);

            Vector v = new Vector();
            while (rs.next())
                v.addElement(new Gene(rs));

            if (v.size() > 1) {
                // do following only if both records are found in the database
                gene = new Gene[v.size()];
                v.copyInto(gene);
            } else {
                return false;
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
        return true;
    }

    /*---------------------------------------------------
    Filled with contents in the pre_defined two dimensional array
    returned from Gene.search_reference()
    in:  an array of gene Type
    out: Reference[][]
    ---------------------------------------------------*/
    public Reference[][] getRefset(Gene[] geneAry) {
        reference = new Reference[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            reference[i] = geneAry[i].search_reference(geneAry[i].getRgd_id());
        }
        return reference;
    }


    /*---------------------------------------------------
    Filled with contents in the pre_defined two dimensional array
    returned from Gene.search_Aliases()
    in:  an array of gene Type
    out: Alias[][]
    ---------------------------------------------------*/
    public Alias[][] getAliasset(Gene[] geneAry) {
        // initialize first dimession
        alias = new Alias[geneAry.length][];
        // define second dimession through looping
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            // return an array of Alias each time from search_Aliases()
            alias[i] = geneAry[i].search_Aliases(geneAry[i].getRgd_id());
        }
        return alias;
    }

    /*---------------------------------------------------
    in: an array of gene Type
    out: Homologs[][]
    ---------------------------------------------------*/
    public Homologs[][] getHmlgset(Gene[] geneAry) {
        homologs = new Homologs[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            homologs[i] = geneAry[i].search_homologs(geneAry[i].getRgd_id());
        }
        return homologs;
    }

    /*---------------------------------------------------
    in: an array of gene Type
    out: XDB[][]
    ---------------------------------------------------*/
    public XDB[][] getXdbset(Gene[] geneAry) {
        xdb = new XDB[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            xdb[i] = geneAry[i].search_xdb(geneAry[i].getRgd_id());
        }
        return xdb;
    }

    /*---------------------------------------------------
    in: an array of gene Type
    out: Strain[][]
    ---------------------------------------------------*/
    public Strain[][] getStrainset(Gene[] geneAry) {
        strain = new Strain[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            strain[i] = geneAry[i].search_strain(geneAry[i].getRgd_id());
        }
        return strain;
    }

    /*---------------------------------------------------
    in: an array of gene Type
    out: SSLP[][]
    ---------------------------------------------------*/
    public SSLP[][] getSslpset(Gene[] geneAry) {
        sslp = new SSLP[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            // pass gene_key instead of rgd_id
            sslp[i] = geneAry[i].search_sslp(geneAry[i].getGene_key());
        }
        return sslp;
    }

    /*---------------------------------------------------
     in: an array of gene Type
     out: QTL[][]
    ---------------------------------------------------*/
    public QTL[][] getQtlset(Gene[] geneAry) {
        qtl = new QTL[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            qtl[i] = geneAry[i].search_qtl(geneAry[i].getGene_key());
        }
        return qtl;
    }

    /*---------------------------------------------------
     in: an array of gene Type
     out: Maps[][]
    ---------------------------------------------------*/
    public Maps[][] getMapset(Gene[] geneAry) {
        maps = new Maps[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            maps[i] = geneAry[i].search_maps(geneAry[i].getRgd_id());
        }
        return maps;
    }

    /*---------------------------------------------------
     in: an array of gene Type
     out: Phenotype[][]
    ---------------------------------------------------*/
    public Phenotype[][] getPheset(Gene[] geneAry) {
        phenotype = new Phenotype[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            phenotype[i] = geneAry[i].search_phenotype(geneAry[i].getRgd_id());
        }
        return phenotype;
    }

    /*---------------------------------------------------
     in: an array of gene Type
     out: Note[][]
    ---------------------------------------------------*/
    public Note[][] getNoteset(Gene[] geneAry) {
        note = new Note[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            note[i] = geneAry[i].search_note(geneAry[i].getRgd_id());
        }
        return note;
    }

/*---------------------------------------------------
  in: an array of gene Type
  out: Sequence[][] 
 ---------------------------------------------------*/

    public Sequence[][] getSeqset(Gene[] geneAry) {
        sequence = new Sequence[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            sequence[i] = geneAry[i].search_sequence(geneAry[i].getRgd_id());
        }
        return sequence;
    }

/*---------------------------------------------------
  in: an array of gene Type
  out: Nomen_event[][] 
 ---------------------------------------------------*/

    public Nomen_event[][] getNomenset(Gene[] geneAry) {
        nomen_event = new Nomen_event[geneAry.length][];
        for (int i = 0; i < geneAry.length; i++) {
            geneAry[i].setContext(mycontext);
            nomen_event[i] = geneAry[i].searchNomen_event(geneAry[i].getRgd_id());
        }
        return nomen_event;

    }

    /*---------------------------------------------------
     This function returns true
     if found a match in a str for the given key
     return false otherwise.
    ---------------------------------------------------*/
    public boolean get_token(String str, int key) {

        String delim = "#";
        int n_key = 0;
        int flag = 0;
        StringTokenizer st = new StringTokenizer(str);
        while (st.hasMoreTokens()) {
            n_key = Integer.parseInt(st.nextToken(delim));
            if (n_key == key) {
                flag = 1;
                break;
            }
        }
        if (flag == 1) {
            return true;
        }
        return false;
    }

/*---------------------------------------------------
  This function performs actual database action
 ---------------------------------------------------*/

    public boolean db_action(String sql, String old_record, String table) {
//System.out.println("SQL = " + sql);
//System.out.println("old_record = " + old_record);    
        try {
            dbObj.executeUpdate(sql);

            if (!old_record.equals("")) {
                log.recordAction("update or delete", table, sql, old_record);
            }
            return true;
        }
        catch (Exception ex) {
            //System.out.println(ex.toString());
            ex.printStackTrace();

            return false;
        }
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's reference association
    ---------------------------------------------------*/
    public String merge_references(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Reference[][] refAry = getReference();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_REF_RGD_ID";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < refAry[0].length; i++) {
                flag = get_token(n_str, refAry[0][i].getRef_key());
                if (flag) {
                    sql = "UPDATE rgd_ref_rgd_id set rgd_id =" + geneAry[1].getRgd_id() +
                            " where ref_key =" + refAry[0][i].getRef_key() +
                            " and rgd_id =" + geneAry[0].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::REF_KEY==" + refAry[0][i].getRef_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < refAry[1].length; j++) {
                flag2 = get_token(d_str, refAry[1][j].getRef_key());
                if (flag2) {
                    sql = "DELETE from rgd_ref_rgd_id " +
                            " where ref_key =" + refAry[1][j].getRef_key() +
                            " and rgd_id=" + geneAry[1].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::REF_KEY==" + refAry[1][j].getRef_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating Reference association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting Reference association";
        }
        return err_msg;
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Aliases association
    ---------------------------------------------------*/
    public String merge_aliases(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Alias[][] aliasAry = getAlias();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "ALIASES";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < aliasAry[0].length; i++) {
                flag = get_token(n_str, aliasAry[0][i].getAlias_key());
                if (flag) {
                    sql = "UPDATE aliases SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where alias_key=" + aliasAry[0][i].getAlias_key();

                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::ALIAS_KEY==" + aliasAry[0][i].getAlias_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < aliasAry[1].length; j++) {
                flag2 = get_token(d_str, aliasAry[1][j].getAlias_key());
                if (flag2) {
                    sql = "DELETE FROM aliases " +
                            " where alias_key =" + aliasAry[1][j].getAlias_key();

                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::ALIAS_KEY==" + aliasAry[1][j].getAlias_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating Aliases association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting Aliases association";
        }
        return err_msg;
    }

/*---------------------------------------------------
 This function performs update and delete for
 the merged gene's XDBs association
---------------------------------------------------*/

    public String merge_xdbs(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        XDB[][] xdbAry = getXdb();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_ACC_XDB";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < xdbAry[0].length; i++) {
                flag = get_token(n_str, xdbAry[0][i].getAcc_xdb_key());
                if (flag) {

                    sql = "UPDATE rgd_acc_xdb SET rgd_id=" + geneAry[1].getRgd_id();

                    //need to update link text if link_text == gene_symbol
                    if (xdbAry[0][i].getLink_text().equals(geneAry[0].getGene_symbol())) {
                        sql += ", link_text='" + geneAry[1].getGene_symbol() + "'";
                    }

                    sql += " where acc_xdb_key=" + xdbAry[0][i].getAcc_xdb_key();

                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::ACC_XDB_KEY==" + xdbAry[0][i].getAcc_xdb_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < xdbAry[1].length; j++) {
                flag2 = get_token(d_str, xdbAry[1][j].getAcc_xdb_key());
                if (flag2) {
                    sql = "DELETE FROM rgd_acc_xdb where acc_xdb_key=" + xdbAry[1][j].getAcc_xdb_key();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::ACC_XDB_KEY==" + xdbAry[1][j].getAcc_xdb_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating XDB association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting XDB association";
        }
        return err_msg;
    }


/*---------------------------------------------------
 This function performs update and delete for
 the merged gene's Homologs association
---------------------------------------------------*/

    public String merge_hmlgs(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Homologs[][] hmlgAry = getHomologs();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_HMLG_RGD_ID";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < hmlgAry[0].length; i++) {
                flag = get_token(n_str, hmlgAry[0][i].getHomolog_key());
                if (flag) {
                    //sql = "UPDATE rgd_hmlg_rgd_id SET rgd_id=" + geneAry[1].getRgd_id() +
                    //        " where homolog_key=" + hmlgAry[0][i].getHomolog_key() +
                    //        " and rgd_id =" + geneAry[0].getRgd_id();
                    sql = "update genetogene_rgd_id_rlt set src_rgd_id=" +  geneAry[1].getRgd_id() +
                          " where dest_rgd_id=" + hmlgAry[0][i].getHomolog_key() +
                          " and src_rgd_id=" + geneAry[0].getRgd_id();

                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::HOMOLOG_KEY==" + hmlgAry[0][i].getHomolog_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < hmlgAry[1].length; j++) {
                flag2 = get_token(d_str, hmlgAry[1][j].getHomolog_key());
                if (flag2) {
                    //sql = "DELETE FROM rgd_hmlg_rgd_id where homolog_key=" + hmlgAry[1][j].getHomolog_key() +
                    //        " and rgd_id =" + geneAry[1].getGene_key();
                    sql = "DELETE FROM GENETOGENE_RGD_ID_RLT where dest_rgd_id=" + hmlgAry[1][j].getHomolog_key() +
                            " and src_rgd_id =" + geneAry[1].getGene_key();


                    old_record = "GENE_KEY==" + geneAry[1].getGene_key();
                    old_record += "::HOMOLOG_KEY==" + hmlgAry[1][j].getHomolog_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating HOMOLOGs association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting HOMOLOGs association";
        }
        return err_msg;
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Maps_Data association
    ---------------------------------------------------*/
    public String merge_maps(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Maps[][] mapsAry = getMaps();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "MAPS_DATA";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < mapsAry[0].length; i++) {
                flag = get_token(n_str, mapsAry[0][i].getMaps_data_key());
                if (flag) {
                    sql = "UPDATE maps_data SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where maps_data_key=" + mapsAry[0][i].getMaps_data_key();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::MAPS_DATA_KEY==" + mapsAry[0][i].getMaps_data_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < mapsAry[1].length; j++) {
                flag2 = get_token(d_str, mapsAry[1][j].getMaps_data_key());
                if (flag2) {
                    sql = "DELETE FROM maps_data where maps_data_key=" + mapsAry[1][j].getMaps_data_key();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::MAPS_DATA_KEY==" + mapsAry[1][j].getMaps_data_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating MAPS_DATA association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting MAPS_DATA association";
        }
        return err_msg;
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Nomen_events association
    ---------------------------------------------------*/
    public String merge_nomen(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Nomen_event[][] nomenAry = getNomen_event();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "NOMEN_EVENTS";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < nomenAry[0].length; i++) {
                flag = get_token(n_str, nomenAry[0][i].getNomen_event_key());
                if (flag) {
                    sql = "UPDATE nomen_events SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where nomen_event_key=" + nomenAry[0][i].getNomen_event_key();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::NOMEN_EVENT_KEY==" + nomenAry[0][i].getNomen_event_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < nomenAry[1].length; j++) {
                flag2 = get_token(d_str, nomenAry[1][j].getNomen_event_key());
                if (flag2) {
                    sql = "DELETE FROM nomen_events where nomen_event_key=" + nomenAry[1][j].getNomen_event_key();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::NOMEN_EVENT_KEY==" + nomenAry[1][j].getNomen_event_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating NOMEN_EVENT association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting NOMEN_EVENT association";
        }
        return err_msg;
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Notes association
    ---------------------------------------------------*/
    public String merge_notes(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Note[][] noteAry = getNote();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "NOTES";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < noteAry[0].length; i++) {
                flag = get_token(n_str, noteAry[0][i].getNote_key());
                if (flag) {
                    sql = "UPDATE notes SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where note_key=" + noteAry[0][i].getNote_key();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::NOTE_KEY==" + noteAry[0][i].getNote_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < noteAry[1].length; j++) {
                flag2 = get_token(d_str, noteAry[1][j].getNote_key());
                if (flag2) {
                    sql = "DELETE FROM notes where note_key=" + noteAry[1][j].getNote_key();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::NOTE_KEY==" + noteAry[1][j].getNote_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating NOTES association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting NOTES association";
        }
        return err_msg;
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Phenotypes association
    ---------------------------------------------------*/
    public String merge_phenotypes(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Phenotype[][] pheAry = getPhenotype();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_PTYPE_RGD_ID";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < pheAry[0].length; i++) {
                flag = get_token(n_str, pheAry[0][i].getPhe_key());
                if (flag) {
                    sql = "UPDATE rgd_ptype_rgd_id SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where phe_key =" + pheAry[0][i].getPhe_key() +
                            " and rgd_id =" + geneAry[0].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::PHE_KEY==" + pheAry[0][i].getPhe_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < pheAry[1].length; j++) {
                flag2 = get_token(d_str, pheAry[1][j].getPhe_key());
                if (flag2) {
                    sql = "DELETE FROM rgd_ptype_rgd_id where phe_key=" + pheAry[1][j].getPhe_key() +
                            " and rgd_id =" + geneAry[1].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::PHE_KEY==" + pheAry[1][j].getPhe_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating PHENOTYPES association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting PHENOTYPES association";
        }
        return err_msg;
    }

    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's QTLs association
    ---------------------------------------------------*/
    public String merge_qtls(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        QTL[][] qtlAry = getQtl();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_GENE_QTL";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < qtlAry[0].length; i++) {
                flag = get_token(n_str, qtlAry[0][i].getQtl_key());
                if (flag) {
                    sql = "UPDATE rgd_gene_qtl SET gene_key=" + geneAry[1].getGene_key() +
                            " where qtl_key =" + qtlAry[0][i].getQtl_key() +
                            " and gene_key =" + geneAry[0].getGene_key();
                    old_record = "GENE KEY==" + geneAry[0].getGene_key();
                    old_record += "::QTL_KEY==" + qtlAry[0][i].getQtl_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < qtlAry[1].length; j++) {
                flag2 = get_token(d_str, qtlAry[1][j].getQtl_key());
                if (flag2) {
                    sql = "DELETE FROM rgd_gene_qtl where qtl_key=" + qtlAry[1][j].getQtl_key() +
                            " and gene_key =" + geneAry[1].getGene_key();
                    old_record = "GENE_KEY==" + geneAry[1].getGene_key();
                    old_record += "::QTL_KEY==" + qtlAry[1][j].getQtl_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating QTLs association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting QTLs association";
        }
        return err_msg;
    }


    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's SSLPs association
    ---------------------------------------------------*/
    public String merge_sslps(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        SSLP[][] sslpAry = getSslp();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_GENE_SSLP";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < sslpAry[0].length; i++) {
                flag = get_token(n_str, sslpAry[0][i].getSslp_key());
                if (flag) {
                    sql = "UPDATE rgd_gene_sslp SET gene_key=" + geneAry[1].getGene_key() +
                            " where sslp_key =" + sslpAry[0][i].getSslp_key() +
                            " and gene_key =" + geneAry[0].getGene_key();
                    old_record = "GENE KEY==" + geneAry[0].getGene_key();
                    old_record += "::SSLP_KEY==" + sslpAry[0][i].getSslp_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < sslpAry[1].length; j++) {
                flag2 = get_token(d_str, sslpAry[1][j].getSslp_key());
                if (flag2) {
                    sql = "DELETE FROM rgd_gene_sslp where sslp_key=" + sslpAry[1][j].getSslp_key() +
                            " and gene_key =" + geneAry[1].getGene_key();
                    old_record = "GENE_KEY==" + geneAry[1].getGene_key();
                    old_record += "::SSLP_KEY==" + sslpAry[1][j].getSslp_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating SSLPs association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting SSLPs association";
        }
        return err_msg;
    }


    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Strains association
    ---------------------------------------------------*/
    public String merge_strains(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Strain[][] strainAry = getStrain();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_STRAIN_RGD";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < strainAry[0].length; i++) {
                flag = get_token(n_str, strainAry[0][i].getStrain_key());
                if (flag) {
                    sql = "UPDATE rgd_strains_rgd SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where strain_key =" + strainAry[0][i].getStrain_key() +
                            " and rgd_id=" + geneAry[0].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::STRAIN_KEY==" + strainAry[0][i].getStrain_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < strainAry[1].length; j++) {
                flag2 = get_token(d_str, strainAry[1][j].getStrain_key());
                if (flag2) {
                    sql = "DELETE FROM rgd_strains_rgd where strain_key=" + strainAry[1][j].getStrain_key() +
                            " and rgd_id =" + geneAry[1].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::STRAIN_KEY==" + strainAry[1][j].getStrain_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating STRAINS association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting STRAINS association";
        }
        return err_msg;
    }


    /*---------------------------------------------------
     This function performs update and delete for
     the merged gene's Sequences association
    ---------------------------------------------------*/
    public String merge_sequences(String n_str, String d_str) {

        Gene[] geneAry = getGene();
        Sequence[][] seqAry = getSequence();
        String sql = "";
        String old_record = "";
        String err_msg = "";
        boolean updt = true;
        boolean del = true;
        String table = "RGD_SEQ_RGD_ID";
        boolean flag = false;
        boolean flag2 = false;

        if (!n_str.equals("")) {
            for (int i = 0; i < seqAry[0].length; i++) {
                flag = get_token(n_str, seqAry[0][i].getSequence_key());
                if (flag) {
                    sql = "UPDATE rgd_seq_rgd_id SET rgd_id=" + geneAry[1].getRgd_id() +
                            " where sequence_key =" + seqAry[0][i].getSequence_key() +
                            " and rgd_id=" + geneAry[0].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[0].getRgd_id();
                    old_record += "::SEQUENCE_KEY==" + seqAry[0][i].getSequence_key();
                    updt = db_action(sql, old_record, table);
                }
            }
        }
        if (!d_str.equals("") && updt) {
            for (int j = 0; j < seqAry[1].length; j++) {
                flag2 = get_token(d_str, seqAry[1][j].getSequence_key());
                if (flag2) {
                    sql = "DELETE FROM rgd_seq_rgd_id where sequence_key=" + seqAry[1][j].getSequence_key() +
                            " and rgd_id =" + geneAry[1].getRgd_id();
                    old_record = "RGD_ID==" + geneAry[1].getRgd_id();
                    old_record += "::SEQUENCE_KEY==" + seqAry[1][j].getSequence_key();
                    del = db_action(sql, old_record, table);
                }
            }
        }
        if (!updt) {
            err_msg = "Error occurred while updating SEQUENCES association";
        }
        if (!del) {
            err_msg = "Error occurred while deleting SEQUENCES association";
        }
        return err_msg;
    }

/*---------------------------------------------------

---------------------------------------------------*/


}
