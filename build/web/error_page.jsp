<%-- 
    Document   : error_page
    Created on : 6 Jul, 2023, 3:14:16 PM
    Author     : Sneha Kapoor
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! something went wrong...</title>
        
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
        
        <div class="container text-center">
            <img src="img/errortb.png" class="img-fluid "/>  
            <h3 class="display-3">Sorry! Something went wrong...</h3>
            <%= exception %>
            <br>
            <a href= "index.jsp" class="btn secondary-background btn-lg text-white mt-3">Home</a>
        </div>        
        
        
    </body>
</html>
