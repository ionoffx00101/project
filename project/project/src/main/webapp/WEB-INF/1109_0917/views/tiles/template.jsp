<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <tiles:importAttribute name="javascripts"/> --%>
<html>

    <head>
    
    <!-- 메타 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- 제이쿼리 -->
 	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> 
 	
 	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	
 	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script> -->
<!--  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular.min.js"></script> -->
<!--   <script>
        window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"><\/script>')
    </script>  -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    
	
	
    <script src="<c:url value="../resources/js/jquery.cookie.js"/>"></script>
    <script src="<c:url value="../resources/js/waypoints.min.js"/>"></script>
    <script src="<c:url value="../resources/js/jquery.counterup.min.js"/>"></script>
    <script src="<c:url value="../resources/js/jquery.parallax-1.1.3.js"/>"></script>
    <script src="<c:url value="../resources/js/front.js"/>"></script>
    <!-- 홈 -->
	<script src="<c:url value="../resources/js/owl.carousel.min.js"/>"></script>


	<!-- 폰트 -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,500,700,800' rel='stylesheet' type='text/css'>

    <!-- Bootstrap and Font Awesome css -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Css animations  -->
    <link href="<c:url value="../resources/css/animate.css"/>" rel="stylesheet">

    <!-- Theme stylesheet, if possible do not edit this stylesheet -->
    <link href="<c:url value="../resources/css/style.default.css"/>" rel="stylesheet" id="theme-stylesheet">

    <!-- Custom stylesheet - for your changes -->
    <link href="<c:url value="../resources/css/custom.css"/>" rel="stylesheet">

    <!-- Responsivity for older IE -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

    <!-- Favicon and apple touch icons-->
    <link rel="shortcut icon" href="<c:url value="../resources/img/favicon.ico"/>" type="image/x-icon" />
    <link rel="apple-touch-icon" href="<c:url value="../resources/img/apple-touch-icon.png"/>" />
    <link rel="apple-touch-icon" sizes="57x57" href="<c:url value="../resources/img/apple-touch-icon-57x57.png"/>" />
    <link rel="apple-touch-icon" sizes="72x72" href="<c:url value="../resources/img/apple-touch-icon-72x72.png"/>" />
    <link rel="apple-touch-icon" sizes="76x76" href="<c:url value="../resources/img/apple-touch-icon-76x76.png"/>" />
    <link rel="apple-touch-icon" sizes="114x114" href="<c:url value="../resources/img/apple-touch-icon-114x114.png"/>" />
    <link rel="apple-touch-icon" sizes="120x120" href="<c:url value="../resources/img/apple-touch-icon-120x120.png"/>" />
    <link rel="apple-touch-icon" sizes="144x144" href="<c:url value="../resources/img/apple-touch-icon-144x144.png"/>" />
    <link rel="apple-touch-icon" sizes="152x152" href="<c:url value="../resources/img/apple-touch-icon-152x152.png"/>" />

 


    <title><tiles:insertAttribute name="title" ignore="true" /></title> <!--타이틀이 null인 경우에는 무시한다-->
</head>
<body>
    <div class="page">
        <tiles:insertAttribute name="header" />
        <div class="content">
            <tiles:insertAttribute name="menu" />
            <tiles:insertAttribute name="body" />
        </div>
        <tiles:insertAttribute name="footer" />
    </div>
    
</body>
</html>