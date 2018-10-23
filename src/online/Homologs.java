package online;

import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Homologs class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Homologs.java,v 1.4 2007/09/10 18:36:00 jdepons Exp $
 * $Revision: 1.4 $
 * $Date: 2007/09/10 18:36:00 $
 */
public class Homologs {

    public int homolog_key;
    public String homolog_symbol;
    public String homolog_name;
    public String chromosome;
    public int rgd_id;
    public int hmlg_org_type_key;
    //String homolog_product;
    //String homolog_function;
    //String position;
    //String notes;
    // from hmlg_organism_types table
    public String organism_genus;
    public String organism_species;

//  DatabaseObj dbObj = new DatabaseObj("dev_1");

    public Homologs(ResultSet results)
            throws SQLException {
        //homolog_key = results.getInt("homolog_key");
        homolog_key = results.getInt("rgd_id");
        homolog_symbol = results.getString("gene_symbol");
        //chromosome = results.getString("chromosome");
        organism_genus = results.getString("organism_genus");
        organism_species = results.getString("organism_species");
    }

    public String getChromosome() {
        return chromosome;
    }

    public void setChromosome(String newChromosome) {
        chromosome = newChromosome;
    }

    public String getHomolog_symbol() {
        return homolog_symbol;
    }

    public void setHomolog_symbol(String newHomolog_symbol) {
        homolog_symbol = newHomolog_symbol;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public int getHmlg_org_type_key() {
        return hmlg_org_type_key;
    }

    public void setHmlg_org_type_key(int newHmlg_org_type_key) {
        hmlg_org_type_key = newHmlg_org_type_key;
    }

    public String getOrganism_genus() {
        return organism_genus;
    }

    public void setOrganism_genus(String newOrganism_genus) {
        organism_genus = newOrganism_genus;
    }

    public String getOrganism_species() {
        return organism_species;
    }

    public void setOrganism_species(String newOrganism_species) {
        organism_species = newOrganism_species;
    }

    public int getHomolog_key() {
        return homolog_key;
    }

    public void setHomolog_key(int newHomolog_key) {
        homolog_key = newHomolog_key;
    }


}