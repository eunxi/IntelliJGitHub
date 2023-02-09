<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>Home</title>
    <style>
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

    .wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 10vh;
    }
    </style>
</head>

<body>
<div class="wrapper">
    <div class="user-info row">
        <h3>어서오세요, ${login.user_name} 님</h3>
        최근 로그인 시도 날짜 [<fmt:formatDate value="${login.user_login_day}" pattern="yyyy-MM-dd HH:mm"/>]

        <div class="menu-info wrapper">
            <a href="/index">HOME</a>&nbsp;|&nbsp;
            <a href="/board/board_list">자유게시판</a>&nbsp;|&nbsp;
            <a href="/logout" id="logout">로그아웃</a>
        </div>

    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">















































































</script>
</body>
</html>
