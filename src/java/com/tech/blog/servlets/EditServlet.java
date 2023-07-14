/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Sneha Kapoor
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            // Fetching all editied data 
            String uName = request.getParameter("user_name");
            String uEmail = request.getParameter("user_email");
            String uPassword = request.getParameter("user_password");
            String uAbout = request.getParameter("user_about");

            //upload image or file
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            //get image name from the session
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setEmail(uEmail);
            user.setName(uName);
            user.setPassword(uPassword);
            user.setAbout(uAbout);
            
            String oldFile = user.getProfile();
            user.setProfile(imageName);

            //Update database
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = dao.updateUser(user);
            
            if (ans) {
                //  out.println("updated to db");
// path of profile picture
                String path = request.getRealPath("/") + "pictures" + File.separator + user.getProfile();

                //*********start of photo work*****
                // delete old file for storing updated file
                String pathOfOldFile = request.getRealPath("/") + "pictures" + File.separator + oldFile;
                
                if (!oldFile.equals("default.png")) {
                    Helper.deleteFile(pathOfOldFile);
                }
                
                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.println("Profile updated........................!!!!!!!!!!");
                    
                    Message msg = new Message("Profile details updated....", "success", "alert-success");
                    s.setAttribute("msg", msg);
                    
                } else {
                    Message msg = new Message("Something went wrong", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }
                
            } else {
                out.println("not updated");
                Message msg = new Message("Something went wrong", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }
            
            response.sendRedirect("profile.jsp");
            
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
