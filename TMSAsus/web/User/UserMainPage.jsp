<%@ page session="true" %>
<%@page import="java.sql.Connection"%>
<%@page import="dbConnection.DBConnect"%>
<%@page import="System.Verifier"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<!--<//jsp:useBean id="user" class="beans.User" scope="session"><//jsp:useBean> -->

<% 
    Cookie [] cookies = request.getCookies();
    String lastLogin = null;
    if (cookies!= null)
        for (Cookie ck : cookies){
            if(ck.getName().equals("lastLogin"));
                lastLogin = ck.getValue();
                break;
        }
    
    int staffID = 0;
    if(Verifier.isLoggedIn(request))
        staffID = Verifier.getStaffID(request);
    else
        response.sendRedirect("../login.jsp");
    Verifier.checkPrivelage(request,response,"staff", "head of dept.");
    
    DBConnect db = new DBConnect();
    db.loadConnection();
    Connection con = db.getConnection();
%>
<!DOCTYPE html>
<html lang="en">
<title>User </title>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <link rel="icon" type="image/ico" href="../image/favicon.ico"/>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="../css/sb-admin-2.css" rel="stylesheet">
    <link href="../font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="../css/datepicker.css" rel="stylesheet" type="text/css"/>
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/bootstrap-dialog.js" type="text/javascript"></script>
    <link href="../css/bootstrap-dialog.css" rel="stylesheet" type="text/css"/>
    
    <!-- Toastr -->
    <script src="../js/toastr.js" type="text/javascript"></script>
    <link href="../css/toastr.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        toastr.options.progressBar = true; 
        toastr.options.closeButton = true;  
    </script>
    

</head>
<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="MainPage.jsp"><img src="../image/logo.jpg" width="150%" height="150%"></a>
                <h3>&nbsp;&nbsp;TRAINING MANAGEMENT SYSTEM</h3>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li class="divider"></li>
                        <li><a href="../logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                            <!-- /input-group -->
                        </li>                     
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jqBootstrapValidation.js"></script>
    <script src="../js/plugins/metisMenu/metisMenu.min.js"></script>
    <script src="../js/sb-admin-2.js"></script>
    <script src="../js/validator.js"></script>

