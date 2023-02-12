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
/*            width: 80%;*/
            height: 30px;
            font-size: 15px;
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

        .number-info{
            font-size: small;
            color: darkgray;
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
        <form method="post" action="/register/register_action" name="reg_form">
            <div class="login-form">
                <a href="/"><h3>로그인하러 가기</h3></a>
            </div>

            <div class="register-form">
                <a href="/register/register"><h3>회원가입</h3></a>

                <!-- 회원가입 S -->
                <div style="margin-bottom: 2%;">
                    <label>이름 <input type="text" id="user_name" name="user_name" placeholder="이름"></label>
                </div>

                <div style="margin-bottom: 2%;">
                    <label>아이디 <input id="user_id" name="user_id" placeholder="아이디"></label>
                </div>

                <div style="margin-bottom: 2%;">
                    <label>비밀번호 <input type="password" id="user_password" name="user_password" placeholder="비밀번호"></label>
                </div>

                <div style="margin-bottom: 2%;">
                    <label>비밀번호 확인 <input type="password" id="pw_check" placeholder="비밀번호 확인"></label>
                </div>

                <div style="margin-bottom: 2%;">
                    <label>전화번호 <input type="text" id="user_phone" name="user_phone" placeholder="전화번호"><span class="number-info">&nbsp;&nbsp;"-" 없이 숫자만 입력</span></label>
                </div>

                <div style="margin-bottom: 2%;">
                    <label>이메일 <input type="text" id="user_email" name="user_email" placeholder="이메일"></label>
                </div>
                <!-- 회원가입 E -->

                <div>
                    <button type="button" id="register_btn" onclick="register_check();" style="float: right;">가입</button>
                </div>

                <div class="alert-info">
                    옴뇸뇸
                </div>
            </div>

        </form>
    </div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 유효성 검사
    function register_check() {
        let name = document.getElementById("user_name");
        let id = document.getElementById("user_id");
        let pwd = document.getElementById("user_password");
        let ch_pwd = document.getElementById("pw_check");
        let phone = document.getElementById("user_phone");
        let email = document.getElementById("user_email");
        let email_add = document.getElementById("email_add");

        let number = /^[0-9]+$/;
        let email_valid = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

        if(name.value == ""){
            alert("이름을 입력해주세요.");
            name.focus();
            return false; // 반환 X
        }

        if(id.value == ""){
            alert("아이디를 입력해주세요.");
            id.focus();
            return false;
        }

        if(pwd.value == ""){
            alert("비밀번호를 입력해주세요.");
            pwd.focus();
            return false;
        }

        let pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;

        if (!pwdCheck.test(pwd.value)) {
            alert("비밀번호는 영문, 숫자, 특수문자 조합으로 8~25자리 사용해야 합니다.");
            pwd.focus();
            return false;
        };

        if(ch_pwd.value !== pwd.value){
            alert("비밀번호가 일치하지 않습니다.");
            ch_pwd.focus();
            return false;
        }

        if(phone.value == ""){
            alert("전화번호를 입력해주세요.");
            phone.focus();
            return false;
        }

        if(!number.test(phone.value)){
            alert("전화번호는 숫자만 입력할 수 있습니다.");
            phone.focus();
            return false;
        }

        if(email.value == ""){
            alert("이메일 주소를 입력해주세요.");
            email.focus();
            return false;
        }

        if(!email_valid.test(email.value)){
            alert("이메일 주소가 올바르지 않습니다.");
            email.focus();
            return false;
        }

        // 데이터 전송
        document.reg_form.submit();
    }

/*
    //이메일 옵션 선택후 주소 자동 완성
    function change_email() {
        let email_add = document.getElementById("email_add");
        let email_sel = document.getElementById("email_sel");

        //지금 골라진 옵션의 순서와 값 구하기
        let idx = email_sel.options.selectedIndex;
        let val = email_sel.options[idx].value;

        email_add.value = val;
    }
*/






























</script>
</body>
</html>
