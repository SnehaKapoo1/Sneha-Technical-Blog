<%-- 
    Document   : show_blog_page
    Created on : 20 Jul, 2023, 4:16:56 PM
    Author     : Sneha Kapoor
--%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--validation for checking user login or not-->
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao dao = new PostDao(ConnectionProvider.getConnection());
    Post post = dao.getPostByPostId(postId);

%>

<!--css-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    .banner-background{
        clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 93%, 89% 100%, 71% 96%, 43% 100%, 21% 96%, 0 100%);
    }

    .post-title{
        font-weight: 100;
        font-size: 30px;
    }

    .post-content{
        font-weight: 100;
        font-size: 25px;
    }

    .post-user-info{
        font-size: 20px;
    }

    .post-date{
        font-style: italic;
        font-weight: bold;
    }

    .row-user{
        border: 1px  solid #e2e2e2;
        padding-top: 15px;
    }

    body{
        background: url(img/bgth.png);
        background-size: cover;
        background-attachment: fixed;
    }
</style>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> <%= post.getpTitle()%> </title>
    </head>
    <body>

        <!--********Start Of navbar***********-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" style="color: #EF5350" href="index.jsp"> <span class="fa fa-asterisk"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link"  style="color: #EF5350" href="#"> <span class="fa fa-user-circle-o"></span> Learn code with sneha <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-tasks"></span>  Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Program Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Database Management System</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"> <span class="fa fa-address-book-o"></span> Contact</a>
                    </li>

                    <!--************Button Start trigger post modal********-->
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-asterisk"></span> Do Post</a>
                    </li>
                    <!--************Button End for post model********-->
                </ul>

                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="login_page.jsp" data-toggle ="modal" data-target="#profile-modal" style="color: #EF5350"> <span class="fa fa-user-circle  "></span> <%= user.getName()%></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet" style="color: #EF5350"> <span class="fa fa-user-plus  "></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--************end of the navbar**********-->

        <!--start of main content of the body-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header secondary-background text-white">
                            <h4 class="post-title"> <%= post.getpTitle()%> </h4>
                        </div>
                        <div class="card-body">
                            <img class="card-img-top my-2" src="blog_pics/<%=  post.getpPic()%>" alt="Card image cap">
                            <div class="row my-3 row-user">
                                <div class="col md-8">
                                    <%  UserDao ud = new UserDao(ConnectionProvider.getConnection()); %>
                                    
                                    <p class="post-user-info"><a href="#" ><%=  ud.getUserbyUserId(post.getUserId()).getName() %></a> has posted: </p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"> <%= DateFormat.getDateTimeInstance().format(post.getpDate())  %></p>
                                </div>
                            </div>

                            <p class="post-content"> <%= post.getpContent()%> </p>
                            <br>
                            <br>
                            <div class="post-code">
                                <pre> <%= post.getpCode() %> </pre>
                            </div>
                        </div>
                        <div class="card-footer secondary-background text-center">
                            <% LikeDao ld = new LikeDao(ConnectionProvider.getConnection()); %>
                            <a href="#!"  onclick="doLike(<%= post.getPid()%>, <%= user.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikesOnPost(post.getPid()) %></span></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"></i> <span>20</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end of main content of the body-->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Technical Blog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="container text-center">
                            <img src="pictures/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 150px;">
                            <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%> </h5>

                            <!--user details-->

                            <div id="profile-details">

                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td> <%=user.getId()%> </td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td> <%= user.getEmail()%> </td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender</th>
                                            <td> <%= user.getGender()%> </td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td> <%= user.getAbout()%> </td>                      
                                        </tr>

                                        <tr>
                                            <th scope="row">Registered on :</th>
                                            <td> <%= user.getDateTime().toLocalDateTime()%> </td>                      
                                        </tr>

                                    </tbody>
                                </table>

                            </div>

                            <!--profile edit-->

                            <div id="profile-edit" style="display: none">
                                <h3 class="mt-2">Please Edit Carefully</h3>

                                <!--enctype attribute because of file uploading or audio or video or image-->
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">

                                    <table class="table">

                                        <tr>
                                            <td>ID :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>

                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" name="user_email" value="<%= user.getEmail()%>" class="form-control"></td>
                                        </tr>

                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" name="user_name" value="<%= user.getName()%>" class="form-control"></td>
                                        </tr>

                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" name="user_password" value="<%= user.getPassword()%>" class="form-control"></td>
                                        </tr>

                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>

                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about" >
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>New Profile:</td>
                                            <td>
                                                <input type="file" name="image" class="form-control">
                                            </td>
                                        </tr>
                                    </table>

                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save changes</button>
                                    </div>

                                </form>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary secondary-background">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--******END OF THE PROFILE MODAL********-->

        <!--******START OF POST MODAL*******-->
        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id = "add-post-form" action="AddPostServlet" method="post">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---select Category---</option>

                                    <%
                                        PostDao postD = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list1 = postD.getAllCategories();
                                        for (Category c : list1) {
                                    %>
                                    <option value="<%= c.getCid()%>"> <%= c.getName()%></option>
                                    <%
                                        }
                                    %>

                                </select>
                            </div>

                            <div class="form-group">
                                <input type="text" class= "form-control" name="post_title" placeholder="Enter post title">
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" style="height: 200px" name="post_content" placeholder="Enter your content"></textarea>
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" style="height: 200px" name="post_code" placeholder="Enter your program (if any)"></textarea>
                            </div>

                            <div class="form-group">
                                <label>Select your pic :</label>
                                <br>
                                <input type="file" name ="post_pic">
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--******END OF POST MODAL*******-->

        <!--javascript-->
        <script
            src="https://code.jquery.com/jquery-3.7.0.min.js"
            integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
       <script src="js/myjs.js" type="text/javascript"></script>


        <!--JQuery-->
        <script>
            $(document).ready(function () {
                //variable
                let editStatus = false;

                $("#edit-profile-button").click(function () {
                    //  alert("button clicked");
                    if (editStatus === false) {

                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        $(this).text("Back");
                        editStatus = true;
                    } else {

                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        $(this).text("Edit");
                    }
                });
            });
        </script>

        <!--now add post Javascript-->
        <script>
            $(document).ready(function (e) {

                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted
                    event.preventDefault(); //stops normal behaviour of form 

                    console.log("you have submitted");
                    let form = new FormData(this);

                    //sending form data to servlet through ajax
                    $.ajax({

                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success

                            console.log(data);

                            if (data.trim() === 'DONE') {
                                swal("Good job!", "saved successfully", "success");
                            } else {
                                swal("Error!", "something went wrong", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error
                            swal("Error!", "something went wrong", "error");
                        },

                        processData: false,
                        contentType: false

                    });

                });
            });
        </script>    
    </body>
</html>