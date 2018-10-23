package manager;

import java.util.Date;

/**
 * Cuation_job class  - POJO
 * $Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/src/manager/Curation_job.java,v 1.2 2007/04/30 19:25:46 gkowalski Exp $
 * $Revision: 1.2 $
 * $Date: 2007/04/30 19:25:46 $
 */
public class Curation_job {

    public String object_name;
    public String curation_status;
    public String data_obj;
    public int rgd_id;
    public Date finish_date;
    public Date assign_date;
    public String job_status;
    public int working_obj_key;
    public int user_key;
    public int cur_idx_key;

    public Curation_job() {
    }

    public Date getAssign_date() {
        return assign_date;
    }

    public void setAssign_date(Date newAssign_date) {
        assign_date = newAssign_date;
    }

    public int getCur_idx_key() {
        return cur_idx_key;
    }

    public void setCur_idx_key(int newCur_idx_key) {
        cur_idx_key = newCur_idx_key;
    }

    public String getCuration_status() {
        return curation_status;
    }

    public void setCuration_status(String newCuration_status) {
        curation_status = newCuration_status;
    }

    public String getData_obj() {
        return data_obj;
    }

    public void setData_obj(String newData_obj) {
        data_obj = newData_obj;
    }

    public Date getFinish_date() {
        return finish_date;
    }

    public void setFinish_date(Date newFinish_date) {
        finish_date = newFinish_date;
    }

    public String getJob_status() {
        return job_status;
    }

    public void setJob_status(String newJob_status) {
        job_status = newJob_status;
    }

    public String getObject_name() {
        return object_name;
    }

    public void setObject_name(String newObject_name) {
        object_name = newObject_name;
    }

    public int getRgd_id() {
        return rgd_id;
    }

    public void setRgd_id(int newRgd_id) {
        rgd_id = newRgd_id;
    }

    public int getUser_key() {
        return user_key;
    }

    public void setUser_key(int newUser_key) {
        user_key = newUser_key;
    }

    public int getWorking_obj_key() {
        return working_obj_key;
    }

    public void setWorking_obj_key(int newWorking_obj_key) {
        working_obj_key = newWorking_obj_key;
    }
}