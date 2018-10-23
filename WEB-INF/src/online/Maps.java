package online;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * maps class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/online/Maps.java,v 1.2 2007/04/30 19:29:34 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:29:34 $
 */
public class Maps {

    //from maps_data table
    private int maps_data_key;
    private String chromosome;
    private String fish_band;
    private int abs_position;
    private int rgd_id;

    // from maps table
    private int map_key;
    private String map_name;

//  DatabaseObj dbObj = new DatabaseObj("dev_1");

    public Maps() {
    }

    // created for Gene.search_aliases()
    public Maps(ResultSet results)
            throws SQLException {
        maps_data_key = results.getInt("maps_data_key");
        chromosome = results.getString("chromosome");
        fish_band = results.getString("fish_band");
        abs_position = results.getInt("abs_position");
        map_name = results.getString("map_name");
    }

    public int getAbs_position() {
        return abs_position;
    }

    public void setAbs_position(int newAbs_position) {
        abs_position = newAbs_position;
    }

    public String getChromosome() {
        return chromosome;
    }

    public void setChromosome(String newChromosome) {
        chromosome = newChromosome;
    }

    public String getFish_band() {
        return fish_band;
    }

    public void setFish_band(String newFish_band) {
        fish_band = newFish_band;
    }

    public int getMap_key() {
        return map_key;
    }

    public void setMap_key(int newMap_key) {
        map_key = newMap_key;
    }

    public String getMap_name() {
        return map_name;
    }

    public void setMap_name(String newMap_name) {
        map_name = newMap_name;
    }

    public int getMaps_data_key() {
        return maps_data_key;
    }

    public void setMaps_data_key(int newMaps_data_key) {
        maps_data_key = newMaps_data_key;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }


}