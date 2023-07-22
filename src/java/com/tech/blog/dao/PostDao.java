/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Sneha Kapoor
 */
public class PostDao {
    
    Connection con;
    
    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories() {
        
        ArrayList<Category> list = new ArrayList<>();
        
        String query = "select * from categories";
        try {
            
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(query);
            
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");
                
                Category cat = new Category(cid, name, description);
                list.add(cat);
                
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
        
    }
    
    public boolean savePost(Post p) {
        boolean flag = false;
        
        try {
            
            String q = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) values (?, ?, ?, ?, ?, ?)";
            PreparedStatement psmt = con.prepareStatement(q);
            psmt.setString(1, p.getpTitle());
            psmt.setString(2, p.getpContent());
            psmt.setString(3, p.getpCode());
            psmt.setString(4, p.getpPic());
            psmt.setInt(5, p.getCatId());
            psmt.setInt(6, p.getUserId());
            psmt.executeUpdate();
            
            flag = true;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flag;
    }

    //             get all posts
    public List<Post> getAllPosts() {
        
        List<Post> list = new ArrayList<>();

        //fetch all the post
        try {
            
            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
            
            ResultSet set = p.executeQuery();
            while (set.next()) {
            
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Post> getPostByCatId(int catId) {
        
        List<Post> list = new ArrayList<>();

        //  Fetch all post by id
        
        try {
            
            PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            
            ResultSet set = p.executeQuery();
            while (set.next()) {
                
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userId = set.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
        
    }
    
    public Post getPostByPostId(int postId) {
        Post post = null;
            String query = "select * from posts where pid = ?";
        
        try {
            
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, postId);
            
            ResultSet set = p.executeQuery();
            while(set.next()){
                
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int cid = set.getInt("catId");
                int userId = set.getInt("userId");
                
               post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;
    }
    
    public User getUserbyPostId(int userId){
        
        User user = null;
        String query = "select * from user where id=?";
        
        try{
        
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, userId);
            
            ResultSet set = p.executeQuery();
            if(set.next()){
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
            
        }catch(SQLException e) {    
            e.printStackTrace();
        }      
        return user;
    }
    
}
