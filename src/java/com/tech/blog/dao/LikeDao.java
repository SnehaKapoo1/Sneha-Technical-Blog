package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Sneha Kapoor
 */
public class LikeDao {

    private Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean insertLike(int pid, int uid) {

        boolean f = false;
        try {
            String query = "insert into likes (pid, uid) values(?, ?)";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, pid);
            p.setInt(2, uid);

            p.executeUpdate();
            f = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    //count likes of posts
    public int countLikesOnPost(int pid) {

        int count = 0;
        try {
            String query = "select count(*) from likes where pid=?";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, pid);
            ResultSet set = p.executeQuery();

            if (set.next()) {

                count = set.getInt("count(*)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean isLikedByUser(int uid, int pid) {
        boolean f = false;
        try {

            String query = "select * from likes where pid = ? and uid = ?";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, pid);
            p.setInt(2, uid);
            ResultSet set = p.executeQuery();

            if (set.next()) {
                f = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }
    public boolean deleteLike(int uid, int pid) {
        boolean f = false;
        try {

            String query = "delete from likes where pid = ? and uid = ?";
            PreparedStatement p = this.con.prepareStatement(query);
            p.setInt(1, pid);
            p.setInt(2, uid);
           p.executeUpdate();

           f =true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }
}
