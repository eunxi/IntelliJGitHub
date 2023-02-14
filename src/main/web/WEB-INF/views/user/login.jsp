<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login</title>

    <style>
        .wrapper{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 60vh;
        }

        .login-form input {
            width: 80%;
            height: 30px;
            font-size: 18px;
        }

        #login_btn {
            font-size: 15px;
            border: none;
            background-color: black;
            width: 60px;
            height: 30px;
            border-radius: 15px;
            color: #fff;
            cursor: pointer;
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

    </style>
</head>
<body>

    <div class="wrapper">
        <form method="post" action="/user/login">
            <div class="board-form">
                <a href="/board/board_list"><h3>자유게시판</h3></a>
            </div>
            <div class="register-form">
                <a href="/register/register"><h3>회원가입하러 가기</h3></a>
            </div>
            <div class="login-form">
                <a href="/"><h3>로그인</h3></a>

                <table width="450px">
                    <tr>
                        <td>아이디</td>
                        <td><input id="user_id" name="user_id"></td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" id="user_password" name="user_password"></td>
                    </tr>
                </table>
                <div>
                    <button type="submit" id="login_btn" style="float: right;">로그인 </button>
                </div>
            </div>

        </form>
    </div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 메세지 출력
    let msg = "${msg}";
    if(msg === "SUCCESS"){
        alert("회원가입 완료! 로그인해주세요.");
    }else if(msg == "ERROR"){
        alert("아이디 또는 비밀번호가 일치하지 않습니다.");
    }else if(msg == "LOGIN_FAILED"){
        alert("로그인 사용자만 이용할 수 있습니다.");
    }

    // 로그인 버튼
    $("#login_btn").click(function(){
        if($("#user_id").val() == ""){
            alert("아이디를 입력해주세요.");
            $("#user_id").focus();

            return;
        }
        if($("#user_password").val() == ""){
            alert("비밀번호를 입력해주세요.");
            $("#user_password").focus();

            return;
        }

    })






























</script>
</body>
</html>
