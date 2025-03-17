package com.TaskManagement.Model;

import java.sql.ResultSet;

public interface DAOService {
    public void DBconnect();
    public int verify(String name, String username, String mobile, String email, String password); // Updated
    public int logincreditial(String username, String password);
    
    public int savetask(String title, String tasktime, String duetime,String taskDate, String endDate,String userId,String status);
    public boolean adminlogin(String username,String password); // Updated
    
    ResultSet getDetails();
    
   

}
