package manager;

import common.DatabaseObj;

import javax.servlet.ServletContext;
import java.sql.ResultSet;
import java.util.Vector;

/**
 * Management
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/manager/Management.java,v 1.2 2007/04/30 19:25:46 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:25:46 $
 */
public class Management {

    //DatabaseObj dbObj = new DatabaseObj("dss");
    public ServletContext mycontext;
    public DatabaseObj dbObj;

    public Management() {
    }

    /**
     * <TODO: Comment for Association here>
     *
     * @association <manager.JavaAssociation1> manager.Curation_job
     */
    public Curation_job curation_job[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <manager.JavaAssociation2> manager.User
     */
    public User user[];
    /**
     * <TODO: Comment for Association here>
     *
     * @association <manager.JavaAssociation4> manager.Log
     */
    protected Log log[];

    public void setContext(ServletContext svltctx) {
        mycontext = svltctx;
        dbObj = (DatabaseObj) mycontext.getAttribute("DSSHDL");
    }

    public Curation_job[] getCuration_job() {
        return curation_job;
    }

    public void setCuration_job(Curation_job[] newCuration_job) {
        curation_job = newCuration_job;
    }

    public User[] getUser() {
        return user;
    }

    public void setUser(User[] newUser) {
        user = newUser;
    }

    public boolean getAllUser() {
        String SQLString;
        ResultSet rs;

        SQLString = "SELECT * FROM users";
        System.out.println("SQL = " + SQLString);

        try {
            rs = dbObj.executeQuery(SQLString);

            Vector v = new Vector();
            while (rs.next())
                v.addElement(new User(rs));

            user = new User[v.size()];
            for (int i = 0; i < user.length; i++)
                user[i] = (User) v.elementAt(i);
            //System.out.println("OK");
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
        return true;

    }
}