<%-- 
    Document   : load_post
    Created on : 19 Jul, 2023, 1:29:59 PM
    Author     : Sneha Kapoor
--%>

<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
    
    <%
//        for slowing down the loader
        //Thread.sleep(1000);
        
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        
        if (cid == 0) {

            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        
        // IF NO POST IN A CATEGORY
        if(posts.size() == 0){
        out.println("<h3 class= 'display-3 text-center'> No Posts in this Category </h3>");
        return;
        }
        
        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card" >
            <img class="card-img-top" src="blog_pics/<%=  p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b> <%= p.getpTitle()%></b>
                <p><%= p.getpContent()%></p>
                <pre><%= p.getpCode()%></pre>
            </div>
        </div>

    </div>

    <%
        }
    %>
</div>

