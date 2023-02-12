<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>To Do List</title>
    <style>
        .table-wrap {
            margin: 50px 50px 50px 300px;
        }

        .doList-form{
            border: 1px solid;
            width: 1100px;
            height: 700px;
        }

        .doList-add{
            margin-left: 80%;
        }

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

        #do_add_btn{
            font-size: 20px;
            border: none;
            background-color: black;
            width: 40px;
            height: 30px;
            border-radius: 15px;
            color: #fff;
            cursor: pointer;
        }

    </style>
</head>
<body>
<div class="table-wrap">
    <div class="menu-info">
        <h3><a href="/index">HOME</a></h3>
        <h3><a href="/board/board_list">자유게시판</a></h3>
    </div>

    <div class="doList-form">
        <h3><a href="/do/doList">To Do List</a></h3>
        <hr>

        <div class="d-list-date">
            ${today_info.search_year}.
            <c:if test="${today_info.search_month < 10}">0</c:if>${today_info.search_month}
        </div>

        <div class="doList-content">
            <c:forEach items="${doList}" var="list">
                <c:if test="${list.user_id == login.user_id}">

                <div>
                    사용자 : ${list.user_id}
                    할 일 : ${list.d_content}
                    상태 : ${list.d_state}
                    시작날짜 : ${list.d_start_date}
                    마감날짜 : ${list.d_end_date}
<%--
                    시작날짜 : <fmt:formatDate value="${list.d_start_date}" pattern="yyyy-MM-dd"/>
                    마감날짜 : <fmt:formatDate value="${list.d_end_date}" pattern="yyyy-MM-dd"/>
--%>
                    <hr>
                </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="input-tags">
            <input type="hidden" value="${login.user_id}" id="user_id"/>
        </div>
    </div>

    <div class="doList-add">
        <button type="button" id="do_add_btn" onclick="do_add();">+</button>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 할 일 추가 버튼
    function do_add(){
        let url = "/do/doAdd";
        let name = "doList_popup";
        let option = "width = 600, height = 400, left = 500, top = 300, location = no";
        window.open(url, name, option);
    }

    // alert
    let msg = "${msg}";
    if(msg === "SUCCESS"){
        alert("일정 추가 성공!");
    }

















































</script>
</body>
</html>