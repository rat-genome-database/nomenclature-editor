package manager;

import common.DatabaseObj;

import javax.servlet.ServletContext;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * User class
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/manager/User.java,v 1.2 2007/04/30 19:25:46 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:25:46 $
 */
public class User {
    public int user_key;
    public String username;
    public String password;
    public String first_name;
    public String last_name;
    public String email;
    public String phone;
    public String institute;
    public String address1;
    public String address2;
    public String city;
    public String state;
    public String zip_code;
    public String country;
    public String active_yn;
    public String privilege;
    public String user_group;
    public Date register_date;
    public String user_groups[];
    public ServletContext mycontext;
    public DatabaseObj dbObj;

// DatabaseObj dbObj = new DatabaseObj("dss");  
    /**
     * <TODO: Comment for Association here>
     *
     * @association <manager.JavaAssociation3> manager.Curation_job
     */
    public Curation_job curation_job[];

    public User() {
    }

    public User(ResultSet results)
            throws SQLException {
        user_key = results.getInt("user_key");
        username = results.getString("username");
        password = results.getString("password");
        first_name = results.getString("first_name");
        last_name = results.getString("last_name");
        email = results.getString("email");
        phone = results.getString("phone");
        institute = results.getString("institute");
        address1 = results.getString("address1");
        address2 = results.getString("address2");
        city = results.getString("city");
        state = results.getString("state");
        zip_code = results.getString("zip_code");
        country = results.getString("country");
        active_yn = results.getString("active_yn");
        privilege = results.getString("privilege");
        user_group = results.getString("user_group");
        register_date = results.getDate("register_date");
    }

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

    public int getUser_key() {
        return user_key;
    }

    public void setUser_key(int newUser_key) {
        user_key = newUser_key;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String newUserName) {
        username = newUserName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String newPassword) {
        password = newPassword;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String newFirst_name) {
        first_name = newFirst_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String newLast_name) {
        last_name = newLast_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String newEmail) {
        email = newEmail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String newPhone) {
        phone = newPhone;
    }

    public String getInstitute() {
        return institute;
    }

    public void setInstitute(String newInstitute) {
        institute = newInstitute;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String newAddress1) {
        address1 = newAddress1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String newAddress2) {
        address2 = newAddress2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String newCity) {
        city = newCity;
    }

    public String getState() {
        return state;
    }

    public void setState(String newState) {
        state = newState;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String newZip_code) {
        zip_code = newZip_code;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String newCountry) {
        country = newCountry;
    }

    public String getActive_yn() {
        return active_yn;
    }

    public void setActive_yn(String newActive_yn) {
        active_yn = newActive_yn;
    }

    public String getPrivilege() {
        return privilege;
    }

    public void setPrivilege(String newPrivilege) {
        privilege = newPrivilege;
    }

    public String getUser_group() {
        return user_group;
    }

    public void setUser_group(String newUser_group) {
        user_group = newUser_group;
    }

    public Date getRegister_date() {
        return register_date;
    }

    public void setRegister_date(Date newRegister_date) {
        register_date = newRegister_date;
    }

    public String[] getUser_groups() {
        user_groups = dbObj.getTypes("user_group", "users");
        return user_groups;
    }

    public void setUser_groups(String[] newUser_groups) {
        user_groups = newUser_groups;
    }

    //---------------Verify User username and password ------------------------//

    public boolean verifyUser(String username, String password) {

        this.username = username;
        this.password = password;

        String SQLString = "";
        ResultSet rs = null;

        SQLString = "SELECT username, password, user_group, user_key" +
                " FROM USERS " +
                " WHERE username =" + dbObj.formatWithTicks(username) +
                " AND password =" + dbObj.formatWithTicks(password);

//		System.out.println("SQL = " + SQLString );
        try {
            rs = dbObj.executeQuery(SQLString);

            while (rs.next()) {
                username = rs.getString("username");
                user_group = rs.getString("user_group");
                user_key = rs.getInt("user_key");

                return true;
            }
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
            return false;
        }
        return false;
    }

    // -------------- Update User information ---------------//
    public void updateUser() {
        String sql = "";
        //int rs;
        sql = " UPDATE users set " +
                "username=" + dbObj.formatWithTicks(username) + "," +
                "first_name=" + dbObj.formatWithTicks(first_name) + "," +
                "last_name=" + dbObj.formatWithTicks(last_name) + "," +
                "user_group=" + dbObj.formatWithTicks(user_group) + "," +
                "privilege=" + dbObj.formatWithTicks(privilege) + "," +
                "email=" + dbObj.formatWithTicks(email) + "," +
                "active_yn=" + dbObj.formatWithTicks(active_yn) +
                " where user_key=" + user_key;
//    System.out.println("sql="+sql);

        try {
            dbObj.executeUpdate(sql);
        }
        catch (Exception ex) {
            System.out.println(ex.toString());
        }
    }


}