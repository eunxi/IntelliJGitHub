<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HOME</title>
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
    <a href="/">HOME</a>&nbsp;|&nbsp;
    <a href="/board/board_list.do">자유게시판</a>&nbsp;|&nbsp;
    <a href="#" id="logout">로그아웃</a>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

  // 로그아웃
  $("#logout").click(function(){
    alert("로그아웃");
    location.href = "/";
  })















































































</script>
</body>
</html>
