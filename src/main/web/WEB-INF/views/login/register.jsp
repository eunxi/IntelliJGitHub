<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Register</title>

    <style>
        .wrapper{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 60vh;
        }

        .register-form input {
            width: 90%;
            height: 30px;
            font-size: 18px;
        }

        #register_btn {
            margin-top: 2%;
            font-size: 15px;
            border: none;
            background-color: black;
            width: 50px;
            height: 30px;
            border-radius: 15px;
            color: #fff;
            cursor: pointer;
        }

        .login_btn {
            font-size: 18px;
            border: none;
            background-color: darkgray;
            width: 50px;
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
        <form method="post" action="/register_action">
            <div class="login-form">
                <a href="/"><h3>로그인하러 가기</h3></a>
            </div>

            <div class="register-form">
                <a href="/register"><h3>회원가입</h3></a>

                <!-- 회원가입 S -->
                <table width="450px">
                    <tr>
                        <td>이름</td>
                        <td><input type="text" id="user_name" name="user_name" placeholder="이름">
                        </td>
                    </tr>
                    <tr>
                        <td>아이디</td>
                        <td><input id="user_id" name="user_id" placeholder="아이디"></td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" id="user_password" name="user_password" placeholder="비밀번호"></td>
                    </tr>
                    <tr>
                        <td>비밀번호 확인</td>
                        <td><input type="password" id="pw_check" placeholder="비밀번호 확인"></td>
                    </tr>
                    <tr>
                        <td>전화번호</td>
                        <td><input type="text" id="user_phone" name="user_phone" placeholder="전화번호"></td>
                    </tr>
                    <tr>
                        <td>이메일</td>
                        <td><input type="email" id="user_email" name="user_email" placeholder="이메일"></td>
                    </tr>
                </table>
                <!-- 회원가입 E -->

                <div>
                    <button type="submit" id="register_btn" style="float: right;">가입</button>
                </div>
            </div>

        </form>
    </div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 회원 가입
    $("#register_btn").click(function(){
        if($("#user_name").val() == ""){
            alert("이름을 입력해주세요.");
            $("#user_name").focus();

            return;
        }
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
        if($("#pw_check").val() == ""){
            alert("확인 비밀번호를 입력해주세요.");
            $("#pw_check").focus();

            return;
        }
        if($("#user_phone").val() == ""){
            alert("전화번호를 입력해주세요.");
            $("#user_phone").focus();

            return;
        }
        if($("#user_email").val() == ""){
            alert("이메일을 입력해주세요.");
            $("#user_email").focus();

            return;
        }

    })






























</script>
</body>
</html>
