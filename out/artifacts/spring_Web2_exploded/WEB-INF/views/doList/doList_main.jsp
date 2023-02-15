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
            width: 1100px;
            height: 700px;
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
            background-color: green;
            width: 40px;
            height: 35px;
            border-radius: 20px;
            color: #fff;
            cursor: pointer;
        }

        .d-list-date a {
            cursor: pointer;
        }

    </style>
</head>
<body>
<div class="table-wrap">
    <div class="menu-info">
        <h3><a href="/index">HOME</a></h3>
    </div>

    <div class="doList-form">
        <h3><a href="/do/doList">To Do List</a></h3>
        <hr>

        <div class="d-list-date" style="text-align: center; font-size: 1.5em; font-weight: bolder; margin-bottom: 2%; margin-top: 1%;">
            <a class="before_date" href="/do/doList?now=${now}&type=pre">
                &#9664;</a>
            <span class="this_month">
                ${now}
            </span>
            <a class="after_date" href="/do/doList?now=${now}&type=next">&#9654;</a>
            <hr>
        </div>

        <div class="doList-content">
            <c:forEach items="${doList}" var="list">
                    <c:if test="${now == list.Date}">
                        <c:if test="${list.d_state != 'D'}">
                            <div class="row">
                                <input type="hidden" value="${list.d_state}" id="d_state"/>
                                <input type="hidden" value="${list.d_seq}" id="d_seq"/>

                                <c:if test="${list.d_state != 'E'}">
                                    <button type="button" onclick="x_btn(${list.d_seq})" style="float: right; margin-left: 1%;">✕</button>
                                    <button type="button" onclick="v_btn(${list.d_seq})" style="float: right;">✓</button>

                                    <pre>${list.d_content}</pre>
                                </c:if>

                                <c:if test="${list.d_state == 'E'}">
                                    <pre style="background-color: lightpink">${list.d_content}</pre>
                                </c:if>

                                <hr style="margin-bottom: 1%; margin-top: 2%;">
                            </div>
                        </c:if>
                    </c:if>
            </c:forEach>
        </div>

        <button type="button" id="do_add_btn" onclick="do_add();" style="float: right; margin-bottom: 1%;">+</button>

        <div class="input-tags">
            <input type="hidden" value="${login.user_id}" id="user_id"/>
            <input type="hidden" value="${now}" id="now"/>
            <input type="hidden" value="${type}" id="type"/>
            <input type="hidden" value="${pre_date}" id="pre_date"/>
            <input type="hidden" value="${next_date}" id="next_date"/>
        </div>
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

    function x_btn(num){
        if(confirm("일정을 삭제하시겠습니까?") == true){

            let data_form = {
                seq : num,
                now : $("#now").val(),
                type : $("#type").val(),
                pre : $("#pre_date").val(),
                next : $("#next_date").val()
            }

            $.ajax({
                url: "/do/doDel",
                type: "post",
                data: data_form,
                success: function(result){

                    if(data_form.type == "pre"){
                        location.href = "/do/doList?now=" + data_form.next + "&type=pre";
                    }else if(data_form.type == "next"){
                        location.href = "/do/doList?now=" + data_form.pre + "&type=next";
                    }else if(data_form.type == ""){
                        location.href = "/do/doList";
                    }
                },
                error: function(error){
                    alert("할 일 삭제, 서버 통신 실패");
                }
            })

        }else{
            return false;
        }
    }

    function v_btn(num){
        if(confirm("일정을 끝내시겠습니까?") == true){

            let data_form = {
                seq : num,
                now : $("#now").val(),
                type : $("#type").val(),
                pre : $("#pre_date").val(),
                next : $("#next_date").val()
            }

            console.log(data_form);

            $.ajax({
                url : "/do/doUpdate",
                type : "post",
                data : data_form,
                success: function(result){
                    alert("성공!");

                    if(data_form.type == "pre"){
                        location.href = "/do/doList?now=" + data_form.next + "&type=pre";
                    }else if(data_form.type == "next"){
                        location.href = "/do/doList?now=" + data_form.pre + "&type=next";
                    }else if(data_form.type == ""){
                        location.href = "/do/doList";
                    }
                },
                error: function(error){
                    alert("할 일 완료, 서버 통신 실패");
                }
            })

        }else{
            return false;
        }



    }


















































</script>
</body>
</html>