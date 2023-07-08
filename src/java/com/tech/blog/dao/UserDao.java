/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {
    
    private Connection con;
    
    public UserDao(Connection con) {
        this.con = con;
    }
    
    public boolean saveUser(User user) {
        
        boolean b = false;
        
        try {
            //USER ------>>>>>>>DATABASE

            String query = "insert into user(name, email, password, gender, about) values(?, ?, ?, ?, ?) ";
            
            PreparedStatement stmnt = this.con.prepareStatement(query);
            stmnt.setString(1, user.getName());
            stmnt.setString(2, user.getEmail());
            stmnt.setString(3, user.getPassword());
            stmnt.setString(4, user.getGender());
            stmnt.setString(5, user.getAbout());
            
            stmnt.executeUpdate();
            b = true;
            
        } catch (Exception e) {
            
        }
        return b;
    }

    //********GET USER BY USEREMAIL AND PASSWORD*****************
    public User getUserByEmailandPassword(String email, String password) {
        
        User user = null;
        
        try {

            //Fetch data from database 
            String query = "select * from user where email =? and password=? ";
            PreparedStatement pstmt = con.prepareStatement(query);
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet set = pstmt.executeQuery();
            
            if (set.next()) {
                user = new User();

                //data from database
                String name = set.getString("name");

                //set to user object
                user.setName(name);
                
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
