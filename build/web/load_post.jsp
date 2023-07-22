<%-- 
    Document   : load_post
    Created on : 19 Jul, 2023, 1:29:59 PM
    Author     : Sneha Kapoor
--%>

<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">

    <%
//        for slowing down the loader
        //Thread.sleep(1000);
         User uuu = (User) session.getAttribute("currentUser");
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;

        if (cid == 0) {

            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }

        // IF NO POST IN A CATEGORY
        if (posts.size() == 0) {
            out.println("<h3 class= 'display-3 text-center text-white'> No Posts in this Category </h3>");
            return;
        }

        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%=  p.getpPic()%>" alt="Card image cap">
            
            <div class="card-body">
                <b> <%= p.getpTitle()%></b>
                <p><%= p.getpContent()%></p>
                <!--<pre><%= p.getpCode()%></pre>-->
            </div>
            
            <div class="card-footer secondary-background text-center">
                <%  LikeDao ld = new LikeDao(ConnectionProvider.getConnection()); %>
                <a href="#!" onclick="doLike(<%= p.getPid()%>, <%= uuu.getId()%>)"  class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"><span class="like-counter"> <%= ld.countLikesOnPost(p.getPid()) %> </span></i></a>
                <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read more...</a>
                <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"><span>20</span></i></a>
            </div>
        </div>

    </div>

    <%
        }
    %>
</div>

