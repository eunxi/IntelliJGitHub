<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <title>Add Do List</title>
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

        textarea{
            width: 90%;
            height: 10em;
            resize: none;
        }

        #sub_btn{
            font-size: 15px;
            width: 50px;
            height: 30px;
            border-radius: 10px;
            cursor: pointer;
        }

        #can_btn{
            font-size: 15px;
            border: black 2px solid;
            width: 50px;
            height: 30px;
            border-radius: 10px;
            cursor: pointer;
        }

    </style>
</head>
<body>

<div>
    <div class="doList-head">
        <h3>할 일 추가</h3>
        <hr>
    </div>

    <form action="/do/doAdd_action" id="add_form" method="post">
        <div class="doList-form">
            <div class="d-list-date" style="margin-bottom: 2%;">
                <div style="margin-left: 2%; margin-top: 3%;">
                    날짜 선택
                </div>

                <div style="margin-left: 2%; margin-top: 1%;">
                    <input type="text" id="start_date" style="width: 200px; height: 25px;"/> ~
                    <input type="text" id="end_date" style="width: 200px; height: 25px;"/>
                </div>
            </div>

            <div class="doList-content" style="margin-left: 2%; margin-top: 3%;">
                <textarea id="do_content" rows="5" cols="20" placeholder="할 일을 추가해주세요."></textarea>
            </div>

            <div class="doList-btn" style="margin: 2% 0 0 40%;">
                <button type="button" id="sub_btn" onclick="submit_btn();">추가</button>
                <button type="button" id="can_btn" onclick="cancel_btn();">취소</button>
            </div>
        </div>

        <input type="hidden" value="${login.user_id}" id="user_id"/>
    </form>
</div>

<!-- datapicker -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

    // DatePicker setting
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
    });

    $(function(){
        $("#start_date, #end_date").datepicker();
    });

    // 시작 ~ 끝 날짜 지정
    $('#start_date').datepicker();
    $('#start_date').datepicker("option", "maxDate", $("#end_date").val());
    $('#start_date').datepicker("option", "onClose", function ( selectedDate ) {
        $("#end_date").datepicker( "option", "minDate", selectedDate );
    });

    $('#end_date').datepicker();
    $('#end_date').datepicker("option", "minDate", $("#start_date").val());
    $('#end_date').datepicker("option", "onClose", function ( selectedDate ) {
        $("#start_date").datepicker( "option", "maxDate", selectedDate );
    });

    // 일정 추가
    function submit_btn(){

        if(confirm("일정을 추가하시겠습니까?") == true){
            // 유효성 검사
            if($("#start_date").val() == ""){
                alert("시작 날짜를 선택해주세요.");
                document.getElementById("start_date").focus();
                return false;
            }

            if($("#end_date").val() == ""){
                alert("마지막 날짜를 선택해주세요.");
                document.getElementById("end_date").focus();
                return false;
            }
            if($("#do_content").val() == ""){
                alert("일정을 작성해주세요.");
                document.getElementById("do_content").focus();
                return false;
            }

            let data_form = {
                start : $("#start_date").val(),
                end : $("#end_date").val(),
                content : $("#do_content").val(),
                user : $("#user_id").val()

            }

            $.ajax({
                url: "/do/doAdd_action",
                type: "post",
                data: data_form,
                success: function(result){
                    window.close();
                    location.href = "/do/doList";
                },
                error: function(error){
                    alert("일정 추가, 서버 연동 실패");
                }
            })

        }else{
            return false;
        }

    }

    // 취소
    function cancel_btn(){
        window.close();
    }












































</script>
</body>
</html>