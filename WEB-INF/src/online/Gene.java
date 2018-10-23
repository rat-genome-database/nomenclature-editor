package online;

import common.DatabaseObj;
import manager.Log;

import javax.servlet.ServletContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Vector;

/**
 * Gene class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Gene.java,v 1.4 2007/09/10 18:36:00 jdepons Exp $
 * $Revision: 1.4 $
 * $Date: 2007/09/10 18:36:00 $
 */
public class Gene {

    public int gene_key;
    public String gene_type_lc;
    public String full_name_lc;
    public String gene_symbol;
    public String gene_symbol_lc;
    public String full_name;
    public String gene_desc;
    public String product;
    public String function;
    public String notes;
    public int rgd_id;

    public Hashtable geneTypes = null;  //Jiali jan-25-2006
    public String[] gene_type_desc;  //can be deleted
    public String[] gene_types;    //can be deleted

    public DatabaseObj dbObj;
    public ServletContext mycontext;

    public Log log = new Log();
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation2> online.Note
     */
    public Note note[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation1> online.Nomen_event
     */
    public Nomen_event nomen_event[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation3> online.Alias
     */
    public Alias alias[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation5> online.Reference
     */
    public Reference reference[];
    /**
     * <TODO: Comment for Association here>c
     *
     * @association <online.JavaAssociation6> online.Homologs
     */
    public Homologs homologs[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation7> online.Sequence
     */
    public Sequence sequence[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation8> online.XDB
     */
    public XDB xDB[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation9> online.Strain
     */
    public Strain strain[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation10> online.SSLP
     */
    public SSLP sSLP[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation12> online.QTL
     */
    public QTL qTL[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation13> online.Maps
     */
    protected Maps maps[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <online.JavaAssociation14> online.Phenotype
     */
    protected Phenotype phenotype[];

    public Gene() {
    }

    /* retrieve db handler from servlet context */
    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DEVHDL");
//System.out.println("in gene=="+dbObj);
        //pass context to Log.java
        log.setContext(mycontext);
    }

    // -----jan-24-2006
    public Hashtable getGeneTypes() {
        return geneTypes;
    }

    public void setGeneTypes(Hashtable newGeneTypes) {
        geneTypes = newGeneTypes;
    }
    //---------------

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String newFull_name) {
        full_name = newFull_name;
    }

    public String getFull_name_lc() {
        return full_name_lc;
    }

    public void setFull_name_lc(String newFull_name_lc) {
        full_name_lc = newFull_name_lc;
    }

    public String getFunction() {
        return function;
    }

    public void setFunction(String newFunction) {
        function = newFunction;
    }

    public String getGene_desc() {
        return gene_desc;
    }

    public void setGene_desc(String newGene_desc) {
        gene_desc = newGene_desc;
    }

    public int getGene_key() {
        return gene_key;
    }

    public void setGene_key(int newGene_key) {
        gene_key = newGene_key;
    }

    public String getGene_symbol() {
        return gene_symbol;
    }

    public void setGene_symbol(String newGene_symbol) {
        gene_symbol = newGene_symbol;
    }

    public String getGene_symbol_lc() {
        return gene_symbol_lc;
    }

    public void setGene_symbol_lc(String newGene_symbol_lc) {
        gene_symbol_lc = newGene_symbol_lc;
    }

    public String getGene_type_lc() {
        return gene_type_lc;
    }

    public void setGene_type_lc(String newGene_type_lc) {
        gene_type_lc = newGene_type_lc;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String newNotes) {
        notes = newNotes;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String newProduct) {
        product = newProduct;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public Note[] getNote() {
        return note;
    }

    public void setNote(Note[] newNote) {
        note = newNote;
    }

    // following several functions can be replaced with Hashtable geneTypes
    public String[] getGene_types() {
        gene_types = dbObj.getTypes("gene_type_lc", "gene_types");
        return gene_types;
    }

    public void setGene_types(String[] newGene_types) {
        gene_types = newGene_types;
    }

    public String[] getGene_type_desc() {
        gene_type_desc = dbObj.getTypes("gene_type_desc", "gene_types");
        return gene_type_desc;
    }

    public void setGene_type_desc(String[] newGene_type_desc) {
        gene_type_desc = newGene_type_desc;
    }
    // end

    public Nomen_event[] getNomen_event() {
        return nomen_event;
    }

    public void setNomen_event(Nomen_event[] newNomen_event) {
        nomen_event = newNomen_event;
    }

    public Alias[] getAlias() {
        return alias;
    }

    public void setAlias(Alias[] newAlias) {
        alias = newAlias;
    }

    public Reference[] getReference() {
        return reference;
    }

    public void setReference(Reference[] newReference) {
        reference = newReference;
    }

    public Homologs[] getHomologs() {
        return homologs;
    }

    public void setHomologs(Homologs[] newHomologs) {
        homologs = newHomologs;
    }

    /* -------jiali  july-29-2002-----------
     To return a set of object values as an array.
     used in searchGeneset() of Data_set.java
    ------------------------------------*/
    public Gene(ResultSet results)
            throws SQLException {
        gene_key = results.getInt("gene_key");
        rgd_id = results.getInt("rgd_id");
        gene_symbol = results.getString("gene_symbol");
        gene_symbol_lc = results.getString("gene_symbol_lc");
        full_name = results.getString("full_name");
        full_name_lc = results.getString("full_name_lc");
        gene_type_lc = results.getString("gene_type_lc");
        notes = results.getString("notes");
        gene_desc = results.getString("gene_desc");
        if (gene_symbol == null) {
            gene_symbol = "";
        }
        if (full_name == null) {
            full_name = "";
        }
        if (gene_type_lc == null) {
            gene_type_lc = "";
        }
        if (gene_desc == null) {
            gene_desc = "";
        }
        product = results.getString("product");
        if (product == null) {
            product = "";
        }
        function = results.getString("function");
        if (function == null) {
            function = "";
        }
    }


    /*------------------------
    modified by: Jiali @01-25-2006
    function: retrieveGeneTypes
    Description: retrieve Gene type and type description
    This routine is created to replace DatabaseObj.getTypes()
    to make association between gene type and type desc
    -------------------------*/
    public Hashtable retrieveGeneTypes() {

        geneTypes = new Hashtable();
        ResultSet rs = null;

        String sql = "select gene_type_lc,gene_type_desc " +
                " from gene_types order by gene_type_desc";

        try {
            rs = dbObj.executeQuery(sql);
            while (rs.next()) {
                geneTypes.put(rs.getString("gene_type_lc"), rs.getString("gene_type_desc"));
            }
        }
        catch (SQLException e) {
            //System.out.println(e);
            e.printStackTrace();
        }
        return geneTypes;
    }

    /*===============================================
    Function: searchGene
    Description: Retreives Gene info from the database
                 to display on the screen.
    Parms: search key information (sql where clause)
    Returns: boolean (true or false)
    ================================================*/
    public boolean searchGene(String condition) {
        String SQLString = "";
        ResultSet rs = null;

        SQLString = "SELECT * FROM genes g,rgd_ids r" + condition +
                " and g.rgd_id=r.rgd_id and r.object_status='ACTIVE'";
        try {
            rs = dbObj.executeQuery(SQLString);
            if (rs.next()) {
                gene_key = rs.getInt("gene_key");
                rgd_id = rs.getInt("rgd_id");
                gene_symbol = rs.getString("gene_symbol");
                gene_symbol_lc = rs.getString("gene_symbol_lc");
                full_name = rs.getString("full_name");
                full_name_lc = rs.getString("full_name_lc");
                gene_type_lc = rs.getString("gene_type_lc");
                gene_desc = rs.getString("gene_desc");

                if (gene_symbol == null) {
                    gene_symbol = "";
                }
                if (full_name == null) {
                    full_name = "";
                }
                if (gene_desc == null) {
                    gene_desc = "";
                }
                product = rs.getString("product");
                if (product == null) {
                    product = "";
                }
                function = rs.getString("function");
                if (function == null) {
                    function = "";
                }
                if (gene_type_lc == null) {
                    gene_type_lc = "";
                }
                notes = rs.getString("notes");

                // close db
                //dbObj.closeDatabase();
            } else {
                return false;
            }
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
        return true;
    }

/*----------------------------------------------------------------------
  update genes atributes.
------------------------------------------------------------*/

    public boolean updateGenes(int gene_key, String updt_sql, String old_record) {

        String SQLString = "";
        this.gene_key = gene_key;

        SQLString = "update genes set " + updt_sql +
                " where gene_key =" + gene_key;

//System.out.println("SQL update= " + SQLString);
//System.out.println("old=" + old_record);

        try {
            dbObj.executeUpdate(SQLString);
            if (!old_record.equals("")) {
                log.recordAction("update", "genes", SQLString, old_record);
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
---------------------------------------------------*/

    public boolean searchNotes(String condition) {
        String SQLString = "";
        ResultSet rs = null;

        boolean isOK = searchGene(condition);
        if (!isOK) return false;

        SQLString = "SELECT * FROM notes " +
                " WHERE rgd_id = " + rgd_id + " AND public_y_n is not null";

        try {
            rs = dbObj.executeQuery(SQLString);

            Vector v = new Vector();
            while (rs.next())
                v.addElement(new Note(rs));

            note = new Note[v.size()];
            v.copyInto(note);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            //System.out.println(ex.toString());
            ex.printStackTrace();
            return false;
        }

        return true;

    }

/*----------------------------------------------------------------------
  query nomen events status and date of the given rgd id
------------------------------------------------------------*/

    public Nomen_event[] searchNomen_event(int rgd_id) {
        String SQLString = "";
        ResultSet rs = null;
        this.rgd_id = rgd_id;

        SQLString = "SELECT NOMEN_EVENT_KEY,NOMEN_STATUS_TYPE,EVENT_DATE,symbol,name,description FROM nomen_events " +
                " WHERE rgd_id = " + rgd_id;

        try {
            rs = dbObj.executeQuery(SQLString);

            Vector v = new Vector();
            while (rs.next())
                v.addElement(new Nomen_event(rs));

            nomen_event = new Nomen_event[v.size()];
            for (int i = 0; i < nomen_event.length; i++)
                nomen_event[i] = (Nomen_event) v.elementAt(i);
            //dbObj.finalize();
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            //System.out.println(ex.toString());
            ex.printStackTrace();
            //return false;
        }
        //return true;
        return nomen_event;
    }

/*----------------------------------------------------------------------
  query alias symbol and name of the given rgd id
------------------------------------------------------------*/

    public Alias[] search_Aliases(int rgd_id) {

        String SQLString = "";
        ResultSet rs = null;
        this.rgd_id = rgd_id;

        SQLString = "SELECT ALIAS_KEY,ALIAS_TYPE_NAME_LC,ALIAS_VALUE FROM aliases " +
                " WHERE rgd_id = " + rgd_id;

        try {
            rs = dbObj.executeQuery(SQLString);
            Vector v = new Vector();
            while (rs.next())
                // see constructor Alias(java.sql.ResultSet) in Alias.java
                v.addElement(new Alias(rs));

            alias = new Alias[v.size()];
            for (int i = 0; i < alias.length; i++)
                alias[i] = (Alias) v.elementAt(i);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            //System.out.println(ex.toString());
            ex.printStackTrace();
            //return false;
        }
        //return true;
        return alias;
    }

/*------------------------------------------------------------
  retrieve references info based on given rgd ids
  in:  rgd_id
  out: Reference[] array;
  called by Data_set.getRefset()
------------------------------------------------------------*/

    public Reference[] search_reference(int rgd_id) {

        String SQLString = "";
        ResultSet rs = null;
        String SQLString1 = "";
        ResultSet rs1 = null;
        this.rgd_id = rgd_id;
        int ref_key = -1;

        SQLString = "SELECT ref_key FROM rgd_ref_rgd_id " +
                " WHERE rgd_id = " + rgd_id;
        try {
            rs = dbObj.executeQuery(SQLString);
            // store ref_key in keys
            Vector keys = new Vector();
            while (rs.next()) {
                ref_key = rs.getInt("ref_key");
                keys.addElement(new Integer(ref_key));
            }

            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                SQLString1 = "SELECT ref_key,rgd_id,citation from references " +
                        " where ref_key =" + keys.get(i);

                rs1 = dbObj.executeQuery(SQLString1);
                while (rs1.next()) {
                    // see constructor Reference(java.sql.ResultSet) in Reference.java
                    v.addElement(new Reference(rs1));
                }
            }
            reference = new Reference[v.size()];
            v.copyInto(reference);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
//            System.out.println(ex.toString());
            ex.printStackTrace();
            //return false;
        }
        return reference;
    }

/*------------------------------------------------------------
  retrieve homologs info based on given rgd ids
  in:  rgd_id
  out: Homolog[] array;
  called by Data_set.getHmlgset() 
------------------------------------------------------------*/

    public Homologs[] search_homologs(int rgd_id) {

        String SQLString = "";
        ResultSet rs = null;
        String SQLString1 = "";
        ResultSet rs1 = null;
        this.rgd_id = rgd_id;
        int homolog_key = -1;

        /*SQLString = "SELECT homolog_key FROM rgd_hmlg_rgd_id " +
                " WHERE rgd_id = " + rgd_id;*/
        SQLString = "SELECT DEST_RGD_ID FROM GENETOGENE_RGD_ID_RLT " +
        " WHERE SRC_RGD_ID = " + rgd_id;

        //System.out.println(SQLString + "\n\n");

        try {
            rs = dbObj.executeQuery(SQLString);
            Vector keys = new Vector();
            while (rs.next()) {
                //homolog_key = rs.getInt("homolog_key");
                homolog_key = rs.getInt("DEST_RGD_ID");
                //System.out.println("keys==" +homolog_key);
                keys.addElement(new Integer(homolog_key));
            }

            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                /*SQLString1 = "SELECT h.homolog_key,h.homolog_symbol,h.chromosome,ht.organism_species,ht.organism_genus" +
                        " from homologs h, hmlg_organism_types ht" +
                        " where h.hmlg_org_type_key = ht.hmlg_org_type_key" +
                        " and h.homolog_key =" + keys.get(i);*/
                SQLString1 = "SELECT h.rgd_id, h.GENE_SYMBOL,ht.ORGANISM_SPECIES,ht.ORGANISM_GENUS" +
                " from GENES h, SPECIES_TYPES ht, rgd_ids r" +
                " where r.SPECIES_TYPE_KEY = ht.SPECIES_TYPE_KEY" +
                " and h.rgd_id=r.rgd_id and r.rgd_id =" + keys.get(i);
//System.out.println("sql==" + SQLString1); 

                //System.out.println(SQLString1 + "\n\n");

                rs1 = dbObj.executeQuery(SQLString1);
                while (rs1.next())
                    v.addElement(new Homologs(rs1));
            }
//System.out.println("hsize==" + v.size());      
            homologs = new Homologs[v.size()];
            v.copyInto(homologs);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
            //System.out.println(ex.toString());

            //return false;
        }
        return homologs;
    }

/*------------------------------------------------------------
  retrieve External Database info based on given rgd ids
  in:  rgd_id
  out: XDB[] array;
  called by Data_set.getXdbset() 
------------------------------------------------------------*/

    public XDB[] search_xdb(int rgd_id) {

        String SQLString = "";
        ResultSet rs = null;
        this.rgd_id = rgd_id;

        SQLString = "SELECT a.acc_xdb_key,a.xdb_key,a.acc_id, b.xdb_name,a.link_text " +
                " from rgd_acc_xdb a,rgd_xdb b " +
                " WHERE a.xdb_key = b.xdb_key " +
                " and a.rgd_id = " + rgd_id;

        try {
            rs = dbObj.executeQuery(SQLString);
            Vector v = new Vector();
            while (rs.next())
                v.addElement(new XDB(rs));

//System.out.println("xsize==" + v.size());
            xDB = new XDB[v.size()];
            v.copyInto(xDB);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return xDB;
    }

/*------------------------------------------------------------
  retrieve strain info based on given rgd ids
  in:  rgd_id
  out: Strain[] array;
  called by Data_set.getStrainset()   
------------------------------------------------------------*/

    public Strain[] search_strain(int rgd_id) {

        String SQLString = "";
        ResultSet rs = null;
        String SQLString1 = "";
        ResultSet rs1 = null;
        this.rgd_id = rgd_id;
        int strain_key = -1;

        SQLString = "SELECT strain_key FROM rgd_strains_rgd " +
                " WHERE rgd_id = " + rgd_id;
        try {
            rs = dbObj.executeQuery(SQLString);
            Vector keys = new Vector();
            while (rs.next()) {
                strain_key = rs.getInt("strain_key");
                keys.addElement(new Integer(strain_key));
            }

            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                SQLString1 = "SELECT strain_key, strain_symbol from strains" +
                        " where strain_key =" + keys.get(i);

                rs1 = dbObj.executeQuery(SQLString1);
                while (rs1.next())
                    v.addElement(new Strain(rs1));
            }
            strain = new Strain[v.size()];
            v.copyInto(strain);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return strain;

    }

    /*------------------------------------------------------------
      retrieve sslps info based on given rgd ids
      in:  rgd_id
      out: SSLP[] array;
      called by Data_set.getSslpset()
    ------------------------------------------------------------*/
    public SSLP[] search_sslp(int gene_key) {

        String SQLString = "";
        String SQLString1 = "";
        ResultSet rs = null;
        this.gene_key = gene_key;
        int sslp_key = -1;

        SQLString = "SELECT sslp_key FROM rgd_gene_sslp " +
                " WHERE gene_key = " + gene_key;

        String select = "sslp_key";
        Vector keys = dbObj.querykeys(SQLString, select);

        try {
            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                SQLString1 = "SELECT sslp_key, rgd_name from sslps" +
                        " where sslp_key =" + keys.get(i);
                rs = dbObj.executeQuery(SQLString1);
                while (rs.next())
                    v.addElement(new SSLP(rs));
            }
            sSLP = new SSLP[v.size()];
            v.copyInto(sSLP);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return sSLP;
    }

/*------------------------------------------------------------
  retrieve qtl info based on given rgd ids
  in:  rgd_id
  out: QTL[] array;
  called by Data_set.getQtlset()     
------------------------------------------------------------*/

    public QTL[] search_qtl(int gene_key) {

        String SQLString = "";
        String SQLString1 = "";
        ResultSet rs = null;
        ResultSet rs1 = null;
        this.gene_key = gene_key;
        int qtl_key = -1;

        SQLString = "SELECT qtl_key FROM rgd_gene_qtl " +
                " WHERE gene_key = " + gene_key;
//System.out.println("qtl==" +SQLString);
        try {
            rs = dbObj.executeQuery(SQLString);
            Vector keys = new Vector();
            while (rs.next()) {
                qtl_key = rs.getInt("qtl_key");
                keys.addElement(new Integer(qtl_key));
            }

            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                SQLString1 = "SELECT qtl_key, qtl_symbol from qtls" +
                        " where qtl_key =" + keys.get(i);
//System.out.println("ss22==" +SQLString1);
                rs1 = dbObj.executeQuery(SQLString1);
                while (rs1.next())
                    v.addElement(new QTL(rs1));
            }
//System.out.println("size==" +v.size());
            qTL = new QTL[v.size()];
            v.copyInto(qTL);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return qTL;
    }

/*------------------------------------------------------------
  retrieve Maps_data info based on given rgd ids
  in:  rgd_id
  out: Maps[] array;
  called by Data_set.getMapset()    
------------------------------------------------------------*/

    public Maps[] search_maps(int rgd_id) {

        String SQLString = "";
        ResultSet rs = null;
        this.rgd_id = rgd_id;

        SQLString = "SELECT md.maps_data_key,md.chromosome,md.fish_band,md.abs_position,m.map_name " +
                " FROM maps_data md, maps m " +
                " WHERE md.map_key = m.map_key " +
                " and md.rgd_id = " + rgd_id;
//System.out.println("sql==" + SQLString); 
        try {
            rs = dbObj.executeQuery(SQLString);
            Vector v = new Vector();
            while (rs.next())
                v.addElement(new Maps(rs));

            maps = new Maps[v.size()];
            v.copyInto(maps);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return maps;
    }

/*------------------------------------------------------------
  retrieve phenotypes info based on given rgd ids
  in:  rgd_id
  out: Maps[] array;
  called by Data_set.getPheset()     
------------------------------------------------------------*/

    public Phenotype[] search_phenotype(int rgd_id) {

        String SQLString = "";
        String SQLString1 = "";
        ResultSet rs = null;
        this.rgd_id = rgd_id;
        int phe_key = -1;

        SQLString = "SELECT phe_key FROM rgd_ptype_rgd_id " +
                " WHERE rgd_id = " + rgd_id;

        String select = "phe_key";
        Vector keys = dbObj.querykeys(SQLString, select);

        try {
            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                SQLString1 = "SELECT phe_key, phe_symbol, phe_desc from phenotypes" +
                        " where phe_key =" + keys.get(i);
//System.out.println("sql==" + SQLString1); 
                rs = dbObj.executeQuery(SQLString1);
                while (rs.next())
                    v.addElement(new Phenotype(rs));
            }
            phenotype = new Phenotype[v.size()];
            v.copyInto(phenotype);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return phenotype;
    }

/*------------------------------------------------------------
  retrieve Notes info based on given rgd ids
  in:  rgd_id
  out: Note[] array;
  called by Data_set.getNoteset()       
------------------------------------------------------------*/

    public Note[] search_note(int rgd_id) {
        String SQLString = "";
        ResultSet rs = null;
        this.rgd_id = rgd_id;

        SQLString = "SELECT note_key,public_y_n, notes_type_name_lc, notes " +
                " FROM notes " +
                " WHERE rgd_id = " + rgd_id + " and public_y_n is not null";
//System.out.println("sql==" + SQLString); 
        try {
            rs = dbObj.executeQuery(SQLString);
            Vector v = new Vector();
            while (rs.next())
                v.addElement(new Note(rs));
            note = new Note[v.size()];
            v.copyInto(note);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return note;
    }

/*------------------------------------------------------------
  retrieve Sequences info based on given rgd ids
  in:  rgd_id
  out: Sequence[] array;
  called by Data_set.getSeqset()        
  mod: 03/25/03 modified sql 
       get forward, reverse seq if seq_type = 4 or 10
       get clone_name otherwise. 
------------------------------------------------------------*/

    public Sequence[] search_sequence(int rgd_id) {

        String SQLString = "";
        String SQLString1 = "";
        String SQLString2 = "";
        ResultSet rs = null;
        ResultSet rs1 = null;
        this.rgd_id = rgd_id;
        //int phe_key = -1;

        SQLString = "SELECT sequence_key FROM rgd_seq_rgd_id " +
                " WHERE rgd_id = " + rgd_id;

        String select = "sequence_key";
        Vector keys = dbObj.querykeys(SQLString, select);

        try {
            Vector v = new Vector();
            for (int i = 0; i < keys.size(); i++) {
                int seq_type = 0;  // seq clones, otherwise seq_primer_pairs
                int goOn = 1;

                SQLString1 = "SELECT sequence_key,clone_name " +
                        " from seq_clones where sequence_key =" + keys.get(i);
                rs = dbObj.executeQuery(SQLString1);

                while (rs.next()) {
                    v.addElement(new Sequence(rs, seq_type));
                    goOn = 0;
                }
                if (goOn == 1) {
                    seq_type = 1;
                    SQLString2 = "SELECT sequence_key,forward_seq,reverse_seq " +
                            " from seq_primer_pairs where sequence_key =" + keys.get(i);
                    rs1 = dbObj.executeQuery(SQLString2);
                    while (rs1.next()) {
                        v.addElement(new Sequence(rs1, seq_type));
                    }
                }
            }
            sequence = new Sequence[v.size()];
            v.copyInto(sequence);
            //dbObj.closeDatabase();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return sequence;

    }

/*------------------------------------------------------------
  Create history event for Merge process
------------------------------------------------------------*/

    public boolean create_history_event(int old_rgd_id, int new_rgd_id) {

        String SQLString = "";
        String SQLString1 = "";
        String old_record = "";

        try {
            // update rgd_ids
            SQLString = "update RGD_IDS set object_status ='RETIRED' " +
                    " where rgd_id = " + old_rgd_id;
            dbObj.executeUpdate(SQLString);
            old_record = "OBJECT_STATUS==ACTIVE::RGD_ID==" + old_rgd_id;
            log.recordAction("update", "RGD_IDS", SQLString, old_record);

            // create history
            String table = "RGD_ID_HISTORY";
            String col = "history_key";
            int history_key = dbObj.generate_key(table, col);

            SQLString1 = "insert into rgd_id_history (history_key,old_rgd_id,new_rgd_id,last_modified_date,created_date)" +
                    " values(" + history_key + "," + old_rgd_id + "," + new_rgd_id +
                    ", SYSDATE, SYSDATE)";
//System.out.println("SQL insert history= " + SQLString1);
            dbObj.executeUpdate(SQLString1);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
        return true;
    }

/*------------------------------------------------------------
  
------------------------------------------------------------*/


}
