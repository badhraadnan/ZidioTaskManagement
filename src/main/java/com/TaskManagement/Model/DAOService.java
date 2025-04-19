//package com.TaskManagement.Model;
//
//import java.sql.ResultSet;
//
//public interface DAOService {
//    public void DBconnect();
//    public int verify(String name, String username, String mobile, String email, String password); // Updated
//    public int logincreditial(String username, String password);
//    
//    public int savetask(String title, String tasktime, String taskDate, String endDate, String userId, String status, String priority);
//    public boolean adminlogin(String username, String password); // Updated
//    
//    ResultSet getDetails();
//    
//    public int saveproject(String title, String description, int created_by, String deadline);
//    
//}


package com.TaskManagement.Model;

import java.sql.ResultSet;

public interface DAOService {
    public void DBconnect();
    public int verify(String name, String username, String mobile, String email, String password);
    public int logincreditial(String username, String password);
    
    public int savetask(String title, String tasktime, String taskDate, String endDate, String userId, String status, String priority);
    public boolean adminlogin(String username, String password);
    
    ResultSet getDetails();
    
    public int saveproject(String title, String description, int created_by, String deadline,String status);
    
    // Add method to insert team members
    public int addTeamMember(int projectId, String username, String role);
    
    public ResultSet getProjectDetails(String username);
    
    public int saveProjectUpdates(int projectId, int userId, String workDon);
}
