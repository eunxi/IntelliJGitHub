<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test</title>
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

        #get_btn, #form-date_btn, #json_btn {
            width: 90px;
            height: 35px;
            font-size: 12px;
            text-align: center;
            margin-right: 1%;
        }

        #start-year, #end-year {
            width: 5%;
            height: 35px;
            font-size: 18px;
            text-align: center;
            margin-right: 1%;
        }

        #start-month, #start-date, #end-month, #end-date, #start-hour, #start-min, #end-hour, #end-min {
            width: 4%;
            height: 35px;
            font-size: 18px;
            text-align: center;
            margin-right: 1%;
        }

    </style>
</head>
<body>
<div >
    <div>
        <div class="menu-info">
            <a href="/index">HOME</a>&nbsp;|&nbsp;
            <a href="/board/test">TEST</a>
        </div>

        <div class="main">
            <div class="now-date" style="margin-bottom: 2%;">
                <span><h3>오늘 날짜 : ${now}</h3></span>
            </div>

            <div class="start-select-form">
                시작 날짜
                <select class="select_box" id="start-year" name="start_date" onchange="javascript:start_lastDay();" style="margin-left: 30px;">
                </select>년

                <select class="select_box" id="start-month" name="start_date"  onchange="javascript:start_lastDay();" style="margin-left: 15px;">
                </select>월

                <select class="select_box" id="start-date" name="start_date"  style="margin-left: 15px;">
                </select>일

                <select class="select_box" id="start-hour" name="start_date" style="margin-left: 15px;">
                    <c:forEach begin="0" end="23" var="i">
                        <option value="${i}" > ${i > 9 ? i : '0'}${i > 9 ? '' : i}</option>
                    </c:forEach>
                </select>
                :
                <select class="select_box" id="start-min" name="start_date"  style="margin-left: 15px;">
                    <c:forEach var="i" begin="0" end="59">
                        <option value="${i}">${i > 9 ? i : '0'}${i > 9 ? '' : i}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="end-select-form" style="margin-top: 1%;">
                마지막 날짜
                <select class="select_box" id="end-year" onchange="javascript:end_lastDay();" style="margin-left: 15px;">
                </select>년

                <select class="select_box" id="end-month" onchange="javascript:end_lastDay();" style="margin-left: 15px;">
                </select>월

                <select class="select_box" id="end-date" style="margin-left: 15px;">
                </select>일

                <select class="select_box" id="end-hour" style="margin-left: 15px;">
                    <c:forEach begin="0" end="23" var="i">
                        <option value="${i}" > ${i > 9 ? i : '0'}${i > 9 ? '' : i}</option>
                    </c:forEach>
                </select>
                :
                <select class="select_box" id="end-min" style="margin-left: 15px;">
                    <c:forEach var="i" begin="0" end="59">
                        <option value="${i}">${i > 9 ? i : '0'}${i > 9 ? '' : i}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="button-group" style="margin-top: 2%;">
                <form action="/board/list_get" method="get">
                    <button type="button" id="get_btn">GET</button>
                </form>

                <form action="/board/list_post" method="post">
                    <input type="hidden" name="start_date" value=""/>
                    <input type="hidden" name="end_date" value=""/>
                    <button type="submit" id="form-date_btn">FORM-DATA</button>
                </form>
                <button type="button" id="json_btn">JSON</button>
            </div>
        </div>
    </div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 시작 날짜 구하기
    let start_yaer = "2020"; // 시작할 년도
    let today = new Date();
    let today_year = today.getFullYear();
    let start_index = 0;

    for(let i = start_yaer; i <= today_year; i++){ //start_year ~ 현재 년도
        document.getElementById('start-year').options[start_index] = new Option(i, i);
        start_index++;
    }

    start_index = 0;

    for(let i = 1; i <= 12; i++){
        document.getElementById('start-month').options[start_index] = new Option(i, i);
        start_index++;
    }

    start_lastDay();

    function start_lastDay(){ //년과 월에 따라 마지막 일 구하기
        let Year=document.getElementById('start-year').value;
        let Month=document.getElementById('start-month').value;
        let day=new Date(new Date(Year, Month, 1) - 86400000).getDate();

        let day_index_len=document.getElementById('start-date').length;
        if(day > day_index_len){
            for(let i = (day_index_len+1); i <= day; i++){
                document.getElementById('start-date').options[i - 1] = new Option(i, i);
            }
        }
        else if(day < day_index_len){
            for(let i = day_index_len; i >= day; i--){
                document.getElementById('start-date').options[i] = null;
            }
        }
    }

    // 마지막 날짜 구하기
    let end_yaer = "2020"; // 시작할 년도
    let select_day = new Date();
    let select_day_year = select_day.getFullYear();
    let end_index = 0;

    for(let i = end_yaer; i <= select_day_year; i++){ //start_year ~ 현재 년도
        document.getElementById('end-year').options[end_index] = new Option(i, i);
        end_index++;
    }

    end_index = 0;

    for(let i = 1; i <= 12; i++){
        document.getElementById('end-month').options[end_index] = new Option(i, i);
        end_index++;
    }

    end_lastDay();

    function end_lastDay(){ //년과 월에 따라 마지막 일 구하기
        let Year=document.getElementById('end-year').value;
        let Month=document.getElementById('end-month').value;
        let day=new Date(new Date(Year, Month, 1) - 86400000).getDate();

        let day_index_len=document.getElementById('end-date').length;
        if(day > day_index_len){
            for(let i = (day_index_len+1); i <= day; i++){
                document.getElementById('end-date').options[i - 1] = new Option(i, i);
            }
        }
        else if(day < day_index_len){
            for(let i = day_index_len; i >= day; i--){
                document.getElementById('end-date').options[i] = null;
            }
        }
    }

    // json
    $("#json_btn").click(function(){
        let start_year = $("#start-year").val();
        let start_month = $("#start-month").val();
        let start_day = $("#start-date").val();
        let start_hour = $("#start-hour").val();
        let start_min = $("#start-min").val();

        let end_year = $("#end-year").val();
        let end_month = $("#end-month").val();
        let end_day = $("#end-date").val();
        let end_hour = $("#end-hour").val();
        let end_min = $("#end-min").val();

        if(start_month < 10){
            start_month = "0" + start_month;
        }

        if(start_day < 10){
            start_day = "0" + start_day;
        }

        if(start_hour < 10){
            start_hour = "0" + start_hour;
        }

        if(start_min < 10){
            start_min = "0" + start_min;
        }

        if(end_month < 10){
            end_month = "0" + end_month;
        }

        if(end_day < 10){
            end_day = "0" + end_day;
        }

        if(end_hour < 10){
            end_hour = "0" + end_hour;
        }

        if(end_min < 10){
            end_min = "0" + end_min;
        }

        let start_date = start_year + "-" + start_month + "-" + start_day + "T" + start_hour + ":" + start_min + ":00";
        let end_date = end_year + "-" + end_month + "-" + end_day + "T" + end_hour + ":" + end_min + ":59";

        let data_form = {
            start_date : start_date,
            end_date : end_date
        }

        $.ajax({
            url: "/board/list",
            type: "post",
            data: JSON.stringify(data_form),
            contentType: "application/json",
            success: function(result){
                alert("성공");
            },
            error: function( request, status, error ){
                alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
            }
        })
    })

    // form-data
    $("#form-date_btn").click(function(){
        let start_year = $("#start-year").val();
        let start_month = $("#start-month").val();
        let start_day = $("#start-date").val();
        let start_hour = $("#start-hour").val();
        let start_min = $("#start-min").val();

        let end_year = $("#end-year").val();
        let end_month = $("#end-month").val();
        let end_day = $("#end-date").val();
        let end_hour = $("#end-hour").val();
        let end_min = $("#end-min").val();

        if(start_month < 10){
            start_month = "0" + start_month;
        }

        if(start_day < 10){
            start_day = "0" + start_day;
        }

        if(start_hour < 10){
            start_hour = "0" + start_hour;
        }

        if(start_min < 10){
            start_min = "0" + start_min;
        }

        if(end_month < 10){
            end_month = "0" + end_month;
        }

        if(end_day < 10){
            end_day = "0" + end_day;
        }

        if(end_hour < 10){
            end_hour = "0" + end_hour;
        }

        if(end_min < 10){
            end_min = "0" + end_min;
        }

        let start_date = start_year + "-" + start_month + "-" + start_day + "T" + start_hour + ":" + start_min + ":00";
        let end_date = end_year + "-" + end_month + "-" + end_day + "T" + end_hour + ":" + end_min + ":59";

        // input name에 값 넣어서 조회
        $('input[name=start_date]').attr('value', start_date);
        $('input[name=end_date]').attr('value', end_date);
    })

    // get
    $("#get_btn").click(function(){
        let start_year = $("#start-year").val();
        let start_month = $("#start-month").val();
        let start_day = $("#start-date").val();
        let start_hour = $("#start-hour").val();
        let start_min = $("#start-min").val();

        let end_year = $("#end-year").val();
        let end_month = $("#end-month").val();
        let end_day = $("#end-date").val();
        let end_hour = $("#end-hour").val();
        let end_min = $("#end-min").val();

        if(start_month < 10){
            start_month = "0" + start_month;
        }

        if(start_day < 10){
            start_day = "0" + start_day;
        }

        if(start_hour < 10){
            start_hour = "0" + start_hour;
        }

        if(start_min < 10){
            start_min = "0" + start_min;
        }

        if(end_month < 10){
            end_month = "0" + end_month;
        }

        if(end_day < 10){
            end_day = "0" + end_day;
        }

        if(end_hour < 10){
            end_hour = "0" + end_hour;
        }

        if(end_min < 10){
            end_min = "0" + end_min;
        }

        let start_date = start_year + "-" + start_month + "-" + start_day + "T" + start_hour + ":" + start_min + ":00";
        let end_date = end_year + "-" + end_month + "-" + end_day + "T" + end_hour + ":" + end_min + ":59";

        let data_form = {
            start_date : start_date,
            end_date : end_date
        }

        $.ajax({
            url: "/board/list_get",
            type: "get",
            data: data_form,
            success:function(result){
                console.log(data_form);
                alert("성공");
            },
            error: function(error){
                alert("get 데이터, 서버 통신 실패");
            }
        })
    })



























</script>
</body>
</html>
