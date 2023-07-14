/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Sneha Kapoor
 */
public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
   public ArrayList<Category> getAllCategories(){
       
       ArrayList<Category> list= new ArrayList<>();
       
       String query= "select * from categories";
       try{
           
           Statement st = this.con.createStatement();
           ResultSet rs = st.executeQuery(query);
           
           while(rs.next()){
               int cid = rs.getInt("cid");
               String name = rs.getString("name");
               String description = rs.getString("description");
               
               Category cat = new Category(cid, name, description);
               list.add(cat);
               
           }
           
       }catch(Exception e){
           e.printStackTrace();
       }
       
       return list;
       
   }
}
