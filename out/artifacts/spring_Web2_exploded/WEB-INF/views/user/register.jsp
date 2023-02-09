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
            width: 80%;
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
        <form method="post" action="/register/register_action">
            <div class="login-form">
                <a href="/"><h3>로그인하러 가기</h3></a>
            </div>

            <div class="register-form">
                <a href="/register/register"><h3>회원가입</h3></a>

                <!-- 회원가입 S -->
                <table width="500px">
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
                        <td>비밀번호 확인</td> "-" 없이 숫자만 입력
                        <td><input type="password" id="pw_check" placeholder="비밀번호 확인"></td>
                    </tr>
                    <tr>
                        <td>전화번호</td>
                        <td><input type="text" id="user_phone" name="user_phone" placeholder="전화번호"></td>
                    </tr>
                    <tr>
                        <td>이메일</td>
                        <td>
                            <input type="email" id="user_email" name="user_email" placeholder="이메일">@<input

                        </td>
                    </tr>
                </table>
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
    function register_check(){
        let name = document.getElementById("user_name");

        console.log(name);
        // let repwd = document.getElementById("repwd");
        // let uname = document.getElementById("uname");
        // let female = document.getElementById("female");
        // let male = document.getElementById("male");
        // let mobile = document.getElementById("mobile");
        // let email_id = document.getElementById("email_id");
        // let agree = document.getElementById("agree");
    }

    //joinform_check 함수로 유효성 검사
    function joinform_check() {
        //변수에 담아주기
        var uid = document.getElementById("uid");
        var pwd = document.getElementById("pwd");
        var repwd = document.getElementById("repwd");
        var uname = document.getElementById("uname");
        var female = document.getElementById("female");
        var male = document.getElementById("male");
        var mobile = document.getElementById("mobile");
        var email_id = document.getElementById("email_id");
        var agree = document.getElementById("agree");

        if (uid.value == "") { //해당 입력값이 없을 경우 같은말: if(!uid.value)
            alert("아이디를 입력하세요.");
            uid.focus(); //focus(): 커서가 깜빡이는 현상, blur(): 커서가 사라지는 현상
            return false; //return: 반환하다 return false:  아무것도 반환하지 말아라 아래 코드부터 아무것도 진행하지 말것
        };

        if (pwd.value == "") {
            alert("비밀번호를 입력하세요.");
            pwd.focus();
            return false;
        };

        //비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
        var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;

        if (!pwdCheck.test(pwd.value)) {
            alert("비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야 합니다.");
            pwd.focus();
            return false;
        };

        if (repwd.value !== pwd.value) {
            alert("비밀번호가 일치하지 않습니다..");
            repwd.focus();
            return false;
        };

        if (uname.value == "") {
            alert("이름을 입력하세요.");
            uname.focus();
            return false;
        };

        if (!female.checked && !male.checked) { //둘다 미체크시
            alert("성별을 선택해 주세요.");
            female.focus();
            return false;
        }

        var reg = /^[0-9]+/g; //숫자만 입력하는 정규식

        if (!reg.test(mobile.value)) {
            alert("전화번호는 숫자만 입력할 수 있습니다.");
            mobile.focus();
            return false;
        }

        if (email_id.value == "") {
            alert("이메일 주소를 입력하세요.");
            email_id.focus();
            return false;
        }

        //입력 값 전송
        document.join_form.submit(); //유효성 검사의 포인트
    }

    //이메일 옵션 선택후 주소 자동 완성
    function change_email() {
        var email_add = document.getElementById("email_add");
        var email_sel = document.getElementById("email_sel");

        //지금 골라진 옵션의 순서와 값 구하기
        var idx = email_sel.options.selectedIndex;
        var val = email_sel.options[idx].value;

        email_add.value = val;
    }

    // 회원 가입
/*    $("#register_btn").click(function(){
        if($("#user_name").val() == ""){
            alert("이름을 입력해주세요.");
            $("#user_name").focus();

            return false;
        }
        if($("#user_id").val() == ""){
            alert("아이디를 입력해주세요.");
            $("#user_id").focus();

            return false;
        }
        if($("#user_password").val() == ""){
            alert("비밀번호를 입력해주세요.");
            $("#user_password").focus();

            return false;
        }
        if($("#pw_check").val() == ""){
            alert("확인 비밀번호를 입력해주세요.");
            $("#pw_check").focus();

            return false;
        }
        if($("#user_phone").val() == ""){
            alert("전화번호를 입력해주세요.");
            $("#user_phone").focus();

            return false;
        }
        if($("#user_email").val() == ""){
            alert("이메일을 입력해주세요.");
            $("#user_email").focus();

            return false;
        }

    })*/






























</script>
</body>
</html>
