<%-- 
    Document   : profile
    Created on : 7 Jul, 2023, 2:54:35 PM
    Author     : Sneha Kapoor
--%>



<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>

<%

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 93%, 89% 100%, 71% 96%, 43% 100%, 21% 96%, 0 100%);
            }
        </style>

    </head>
    <body>

        <!--************navbar****************-->


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

        <!--profile modal-->


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
                            <img src="pics/ <%= user.getProfile()%>">
                            <%= user.getProfile()%>
                            <h5 class="modal-title" id="body"> <%= user.getName()%> </h5>

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

                                <form action="EditServlet" method="POST">

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
                                                <textarea rows="3" class="form-control" name="user-about" >
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


        <!--javascript-->
        <script
            src="https://code.jquery.com/jquery-3.7.0.min.js"
            integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
        crossorigin="anonymous"></script>
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

    </body>
</html>