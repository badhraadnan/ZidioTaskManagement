package com.TaskManagement.Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;

import javax.servlet.RequestDispatcher;

public class DAOServiceImpl implements DAOService {

	Connection cn;
	PreparedStatement st;
	@Override
	public void DBconnect() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/todoapp","root", "Adnan");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	
	@Override
	public int verify(String name, String username, String mobile, String email, String password) {
	    int uid = 1; // Default to 1 if no existing users
	    try {
	        // Fetch max uid from the user table
	        PreparedStatement st = cn.prepareStatement("SELECT MAX(uid) AS max_uid FROM user");
	        ResultSet rs = st.executeQuery();

	        if (rs.next()) {
	            uid = rs.getInt("max_uid") + 1;
	        }

	        // Insert new user data into the table
	        PreparedStatement stmt = cn.prepareStatement(
	            "INSERT INTO user (uid, name, username, mobile, email, password) VALUES (?, ?, ?, ?, ?, ?)");
	        stmt.setInt(1, uid);
	        stmt.setString(2, name);
	        stmt.setString(3, username);
	        stmt.setString(4, mobile);
	        stmt.setString(5, email);
	        stmt.setString(6, password);

	        int result = stmt.executeUpdate();
	        return result;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return 0; // Return 0 if there was an error
	}


	
//	@Override
//	public boolean logincreditial(String username, String password) {
//	    try {
//	        PreparedStatement st = cn.prepareStatement("SELECT * FROM user WHERE username = ? AND password = ?");
//	        st.setString(1, username);
//	        st.setString(2, password);
//	        ResultSet rs = st.executeQuery();
//	        return rs.next();
//	       
//	    } catch (SQLException e) {
//	        e.printStackTrace();
//	    }
//	    return false;
//	}

	@Override
	public int logincreditial(String username, String password) {
	    try {
	        PreparedStatement st = cn.prepareStatement("SELECT uid FROM user WHERE username = ? AND password = ?");
	        st.setString(1, username);
	        st.setString(2, password);
	        ResultSet rs = st.executeQuery();

	        if (rs.next()) {
	            return rs.getInt("uid"); // Return user ID if login is successful
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return -1; // Return -1 if login fails
	}

	@Override
	public int savetask(String title,String tasktime, String taskDate, String endDate,String userId,String status,String priority) {
		int tid=1;
		
		LocalTime time=LocalTime.now();
		try {
			PreparedStatement st=cn.prepareStatement("select max(tid) as TaskId from task");
			ResultSet rs = st.executeQuery();
			
			if(rs.next()) {
				tid=rs.getInt("TaskId")+1;
			}
			
			PreparedStatement stmt=cn.prepareStatement("insert into task values(?,?,?,?,?,?,?,?)");
			stmt.setInt(1, tid);
			stmt.setString(2, title);
			stmt.setString(3, tasktime);			
			stmt.setString(4, taskDate);
			stmt.setString(5, endDate);
			stmt.setString(6, userId);
			stmt.setString(7, status);
			stmt.setString(8, priority);
			
			int result = stmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}


	@Override
	public boolean adminlogin(String username, String password) {
	    try {
	        // Use parameterized query to prevent SQL injection
	        String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
	        PreparedStatement st = cn.prepareStatement(query);
	        st.setString(1, username);
	        st.setString(2, password);
	        
	        ResultSet result = st.executeQuery();

	        if (result.next()) {
	            return true; // Login successful
	        }
	    } catch (SQLException e) {            
	        e.printStackTrace();
	    }
	    
	    return false; // Login failed
	}



//	@Override
//	public ResultSet getDetails() {
//		try {
//			PreparedStatement st=cn.prepareStatement(" select title,status from task");
//			
//			return st.executeQuery();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return null;
//	}

	@Override
    public ResultSet getDetails() {
        ResultSet result = null;
        try {
            String query = "select * from task";
           st = cn.prepareStatement(query);
            result = st.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }


	


	


	

	





}
