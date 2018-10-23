package common;

/**
 * @version : 1.0
 * @Description : This is a simple common class for the switch property path
 * @Author : Henry Fan
 * @Date : 01/2004
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/common/ChoosePropertyFile.java,v 1.3 2007/04/30 19:26:15 gkowalski Exp $
 * $Revision: 1.3 $
 * $Date: 2007/04/30 19:26:15 $
 */
public class ChoosePropertyFile {

    //final String property_path="C://property_file//rgd_config.properties";
    private static final String property_path = "rgd_config.properties";

    public static String getPropertyFile() {
        return property_path;
    }
}
