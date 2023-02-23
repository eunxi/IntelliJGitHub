<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>은팡! | </title>
    <style>
        h1, h2, h3, h4, h5, h6 { margin:0; padding:0; }

        a {
            text-decoration: none;
        }

        a:link {
            color: black;
        }

        a:visited {
            color: black;
        }

        a:hover {
            color: darkgray;
        }

        a:active {
            color: black;
        }

        #header{
            width:100%;
            height:80px;
        }

        #menu{
            width:50%;
            height:700px;
            float:left;
            background-color: lightpink;
        }

        #content{
            width:50%;
            float:right;
            height:700px;
            background-color: lightgray;
        }

        #footer{
            width:100%;
            height:1500px;
            background-color: lightskyblue;
        }
    </style>
</head>
<body>
<div>
    <div id="header">
        <h1><a href="/eunpang/" style="margin-left: 2%;">은팡</a></h1>
        <span style="margin-left: 2%;">로그인한 사용자 : ${session}</span>
        <p></p>
    </div>

    <div id="menu">
        <div>
            <p style="float: right;"><img src="${detail.p_image1}" width=300px, height=300px /></p>
        </div>
    </div>

    <div id="content">
        <div>
            <p>${detail.p_name}</p>
        </div>
    </div>

    <div id="footer">
    </div>







</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">


















</script>
</body>
</html>
