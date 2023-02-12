<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>자유게시판</title>
    <style>
        .wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 10vh;
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

        table {
            border-collapse: collapse;
            width: 1000px;
            margin-top: 20px;
            text-align: center;
        }

        td, th {
            border: 1px solid black;
            height: 50px;
        }

        th {
            font-size: 17px;
        }

        thead {
            font-weight: 700;
        }

        .table-wrap {
            margin: 50px 50px 50px 300px;
        }

        .top-btn {
            font-size: 20px;
            padding: 6px 12px;
            background-color: #fff;
            border: 1px solid #ddd;
            font-weight: 600;
            margin-left: 44%;
        }

        ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        li {
            margin: 0 2% 0 0;
            padding: 0 0 0 0;
            border: 0;
            float: left;
            text-align: center;
        }

        .search input {
            width: 80%;
            height: 30px;
            font-size: 18px;
            border: none;
            border-bottom: 1px black solid;
        }

        #search_btn {
            font-size: 18px;
            border: none;
            background-color: black;
            width: 50px;
            height: 30px;
            border-radius: 15px;
            color: #fff;
            cursor: pointer;
        }

        #up{
            font-size: 18px;
            border: none;
            background-color: black;
            width: 50px;
            height: 30px;
            border-radius: 15px;
            color: #fff;
            cursor: pointer;
        }

        .reset_btn {
            font-size: 18px;
            border: none;
            background-color: blue;
            width: 70px;
            height: 30px;
            border-radius: 15px;
            color: #fff;
            cursor: pointer;
        }

        .active {
            background-color: skyblue;
            width: 30px;
            height: 30px;
        }

        #select_box {
            width: 90px;
            height: 35px;
            font-size: 18px;
            text-align: center;
            margin-right: 1%;
        }

        #sort_table thead {
            cursor: pointer;
        }

    </style>
</head>
<body>
<div class="table-wrap">
    <form method="get" id="listForm" action="/board/board_list">
        <div>
            <h3><a href="/index">HOME</a></h3>
            <h3><a href="/do/doList">To Do List</a></h3>
        </div>

        <h3><a href="/board/board_list">자유게시판</a></h3>

        <!-- 검색S -->
        <div class="search_area" style="margin-left: 40%;">
            <div class="search">
                <select id="select_box" name="searchType">
                    <option value="" <c:out value="${type == null ? 'selected' : ''}" />>--</option>
                    <option value="C" <c:out value="${type eq 'C' ? 'selected' : ''}" />>내용</option>
                    <option value="U" <c:out value="${type eq 'U' ? 'selected' : ''}"/>>작성자</option>
                    <option value="T" <c:out value="${type eq 'T' ? 'selected' : ''}"/>>제목</option>
                </select>

                <input type="text" value="${searchKeyword}" name="searchKeyword" id="searchKeyword" onkeypress="if( event.keyCode == 13 ){enterKey();}" style="width: 200px; height: 30px;"/>

                <button type="button" id="search_btn" onclick="enterKey();" style="cursor: pointer" >검색</button>
                <a href="/board/board_list">
                    <button class="reset_btn" type="button">초기화</button>
                </a>
            </div>
        </div>
        <!-- 검색E -->

        <!-- 게시글 리스트 S -->
        <table id="sort_table">
            <thead>
            <tr>
                <th><a>번호</a></th>
                <th><a>제목</a></th>
                <th><a>작성자</a></th>
                <th><a>작성일</a></th>
                <th><a>조회수</a></th>
            </tr>
            </thead>

            <tbody class="listData">
            <c:forEach var="list" items="${boardList}">
                <tr>
                    <td>${list.no}
                        <input type="hidden" name="board_seq" id="board_seq" value="${list.board_seq}"/>
                        <c:set var="allCount" value="${allCount - 1}"/>
                    </td>
                    <td>
                        <c:if test="${list.board_state == 'Y'}">
                            <c:if test="${list.indent == 0}">
                                <a style="float: left; color: darkgray; ">&nbsp;삭제된 게시글입니다.</a>
                            </c:if>
                            <c:if test="${list.indent >= 1}">
                            <c:forEach var="i" begin="1" end="${list.indent}">
                                <a style="float: left; color: darkgray; ">&nbsp;&nbsp;${i eq list.indent ? "↳ " : "&nbsp;"}삭제된 게시글입니다.</a>
                            </c:forEach>
                            </c:if>
                        </c:if>

                        <c:if test="${list.board_state != 'Y'}">
                            <a href="/board/board_detail?board_seq=${list.board_seq}&page=${allSearch.page}&listSize=${listSize}&type=${type}&searchKeyword=${searchKeyword}" style="float: left;">&nbsp;
                                <c:forEach var="i" begin="1" end="${list.indent}">
                                    ${i eq list.indent ? "↳" : "&nbsp;"}
                                </c:forEach>
                                ${list.board_title}
                            </a>
                        </c:if>
                    </td>
                    <td>${list.user_id}</td>
                    <td >
                        <fmt:formatDate value="${list.board_date}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${list.board_cnt}</td>
                </tr>
            </c:forEach>

                <c:if test="${all_count == 0}">
                    <tr>
                        <td colspan="5">조회된 게시글이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>

        </table>
        <!-- 게시글 리스트 E -->

        <!-- 페이지 Inform S -->
        <div id="page_bottom" style="margin-top: 1%; margin-bottom: 3%;">
            <span id="page_total">총 ${all_count} 건 | 페이지 (${allPage} / ${page})</span>
             &nbsp;&nbsp;

            <select id="dataPerPage" name="dataPerPage" style="height: 30px; width: 100px; text-align: center;">
                <option value="10" <c:if test="${allSearch.getListSize() == 10 }">selected="selected"</c:if>>10개씩 보기</option>
                <option value="15" <c:if test="${allSearch.getListSize() == 15 }">selected="selected"</c:if>>15개씩 보기</option>
                <option value="20" <c:if test="${allSearch.getListSize() == 20 }">selected="selected"</c:if>>20개씩 보기</option>
            </select>

            <a href="/board/board_insert" class="top-btn">글 등록</a>
        </div>
        <!-- 페이지 Inform E -->

        <!-- pagination{s} -->
        <div id="paginationBox" style="margin-left: 30%;">
            <ul class="pagination" id="pagination_ul">
                <c:if test="${allPage ne 1}">
                    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                </c:if>

                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <c:if test="${allPage ne i}">
                        <li class="page-item"><a class="page-link" href="#"> ${i} </a></li>
                    </c:if>

                    <c:if test="${allPage eq i}">
                        <li class="page-item active"><a class="page-link" href="/board/board_list?page=${i}"> ${i} </a></li>
                    </c:if>
                </c:forEach>

                <c:if test="${allPage lt allCount / listSize}">
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </c:if>
            </ul>
        </div>
        <!-- pagination{e} -->

        <button  type="button" onclick="up_btn();" id="up" style="cursor: pointer; float: right">Up</button>

        <!-- 검색 및 Ajax -->
        <input type="hidden" value="${allSearch.page}" id="search_page"/> <!-- 현재 페이지 값 -->
        <input type="hidden" value="${listSize}" id="listSize" name="listSize"/> <!-- selected 값에 따라 바뀌는 목록 출력 값 -->
        <input type="hidden" value="${page}" id="total_page"/> <!-- listSize에 따라 바뀌는 전체 페이지 값 -->
        <input type="hidden" value="${all_count}" id="total_cnt"/> <!-- 전체 글 개수 값 -->
        <input type="hidden" value="${type}" name="type" id="type"/> <!-- 검색 type -->
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    function up_btn(){
        window.scroll({
            top: 0,
            letf: 0,
            behavior: 'smooth'
        });
    }

    // 엔터키 검색
    function enterKey(){
        let searchType = $("#select_box").val();
        let searchKeyword = $("#searchKeyword").val();

        if(!searchType){
            alert("검색 분류를 선택해주세요.");
            return false;
        }

        if(!searchKeyword){
            alert("검색 단어를 입력해주세요.");
            return false;
        }

        // 변경된 selected 값 찾기
        $("select[name=searchType]").change(function(){

        })

        let url = "/board/board_list?type=" + $("#type").val() + "&searchKeyword=" + $("#searchKeyword").val();
        location.href = url;

        make();
    }

    // 정렬
    // <thead> 와 <tbody> 로 구분을 지어야 오름, 내림차순 가능
    $(document).ready(function(){
        $('#sort_table th').each(function (column) {
            $(this).click(function() {
                if($(this).is('.asc')) {		// 현재 오름차순인 경우
                    $(this).removeClass('asc');
                    $(this).addClass('desc');	// 내림차순으로 변경
                    $(this).children().attr('src', "resources/img.png");	// 이미지 src 수정
                    sortdir=-1;

                } else {	// 현재 오름차순 아닌 경우
                    $(this).addClass('asc');	// 오름차순으로 변경
                    $(this).removeClass('desc'); sortdir=1;
                    $(this).children().attr('src', "resources/img.png");	// 이미지 src 수정
                }

                $(this).siblings().removeClass('asc');
                $(this).siblings().removeClass('desc');

                let rec = $('#sort_table').find('tbody > tr').get();

                rec.sort(function (a, b) {
                    let val1 = $(a).children('td').eq(column).text().toUpperCase();
                    let val2 = $(b).children('td').eq(column).text().toUpperCase();
                    return (val1 < val2)?-sortdir:(val1>val2)?sortdir:0;
                });

                $.each(rec, function(index, row) {
                    $('#sort_table tbody').append(row);
                });
            });
        });
    });

    // 페이징 화면 이동 - paginationBox a 태그 클릭 시 makeDisplay 발동
    $(document).on('click', '.pagination a', makeDisplay);

    // 화면 구성
    function makeDisplay(e){
        if($(e.target).text().trim() == "Previous"){
            $("#search_page").val(Number($("#search_page").val()) - 1);
        }else if($(e.target).text() == "Next"){
            $("#search_page").val(Number($("#search_page").val()) + 1);
        }else{
            $("#search_page").val($(e.target).text());
        }

        make();
    }

    // 페이지 목록 개수 출력 - 총 페이지, 목록 개수 지정 필요
    $("select[name=dataPerPage]").change(function(){
        let dataPerPage = $("#dataPerPage").val ();

        $("#listSize").val(dataPerPage);

        let real_page_end = Math.ceil(Number($("#total_cnt").val()) / Number($("#listSize").val())); // 진짜 총 페이지 - 정수 맞음

        $("#total_page").val(real_page_end);

        make();
    });

    // 내용 변경
    function make(){
        let count = 0;
        let listSize = Number($("#listSize").val()); // 출력 개수 (VO)

        let all_total = Number($("#total_cnt").val()); // 전체 개수
        let now_page = Number($("#search_page").val()); // 현재 페이지
        let total_page = $("#total_page").val(); // 전체 페이지

        let searchKeyword = $("#searchKeyword").val(); // 검색 단어
        let searchType = $("#select_box").val(); // 검색 타입
        let type = $("#type").val();
        $("#type").val(searchType);

        $.ajax({
            url: "/board/ajax_cnt.do",
            method: "POST",
            dataType: "JSON",
            async: false,
            data:{
                searchKeyword: $("#searchKeyword").val(),
                type: type, // 한번에 넣고 사용하려고 하면 재귀함수 호출되니깐, 하나씩 하기
                listSize: Number($("#listSize").val()), // 화면에 보여지는 개수
                search_page: Number($("#search_page").val()) // 현재 페이지
            },
            success: function(result){ // Controller에서 cnt가 result로~!
                count = result; // 게시물 전체 개수
                count = count - ($("#search_page").val() - 1) * listSize; // 보여질 개수

                let totalPage = result / listSize; // 전체 페이지

                // 한 페이지당 몇 개의 게시글이 나오게 할 것인지 출력
                let content = '';
                if(Number($("#search_page").val()) > 1){ // 2 이상부터 이전 출력
                    content += `<li class="page-item"><a class="page-link" href="#">Previous</a></li>`;
                }

                if(result % listSize == 0){
                    result--;
                }

                if(Number($("#search_page").val()) > totalPage + 1){
                    $("#search_page").val(Number($("#search_page").val()) - 1);
                }

                // 총 페이지 수 구하고, 한 화면에 몇 개의 쪽수를 나오게 할 것인지
                let page = Number($("#search_page").val());
                let startPage = 0;
                let endPage = 0;

                if(page < 3){
                    startPage = 1;
                }else{
                    startPage = page - 2;
                }

                if(page + 2 > totalPage + 1){
                    endPage = totalPage + 1;
                }else{
                    endPage = page + 2;
                }

                // 화면 페이지 번호
                for(let i = startPage; i <= endPage; i++){
                    if(Number($("#search_page").val()) != i){
                        content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
                    }
                    if(Number($("#search_page").val()) == i){
                        content += '<li class="page-item active"><a class="page-link" href="#">' + i + '</a></li>';
                    }
                }

                if (Number($("#search_page").val()) < totalPage) {
                    content += `<li class="page-item"><a class="page-link" href="#">Next</a></li>`;
                }
                $("#pagination_ul").empty();
                $("#pagination_ul").append(content);

                // 현재 페이지 번호 변경하는 html
                let content2 = '';

                content2 += '<span id="page_total">총 ' + all_total + ' 건 | 페이지 (' + now_page + ' / ' +  total_page + ') </span>';

                $("#page_total").empty();
                $("#page_total").append(content2);


            },
            error: function(error){
                alert("error!");
            }
        });

        $.ajax({
            url : "/board/ajax_list.do",
            method: "POST",
            dataType: "JSON",
            async: false,
            data: {
                searchKeyword: $("#searchKeyword").val(),
                type: type,
                listSize: Number($("#listSize").val()), // 출력 개수
                search_page: Number($("#search_page").val()) // 현재 페이지
            },
            success: function(result){ // Controller의 list가 result로
                let content = '';

                for(let i = 0; i < result.length; i++){
                    content +=
                        '<tr>' +
                        '<td>' + result[i].no +
                        '<input type="hidden" name="board_seq" id="board_seq" value="' + result[i].board_seq + '"/></td>' +
                        '<td>';

                    if(result[i].board_state == 'Y'){

                        if(result[i].indent == 0){
                            content += '<a style="float: left; color: darkgray; ">&nbsp;삭제된 게시글입니다.</a>';
                        }else if(result[i].indent >= 1){
                            content += '<a style="float: left; color: darkgray; ">&nbsp;';
                                for(let j = 1; j <= result[i].indent; j++){
                                    content += (j == result[i].indent ? ' ↳ ' : '&nbsp; ') + '삭제된 게시글입니다.</a>';
                                }
                        }

                    }else if(result[i].board_state != 'Y'){
                        content += '<a style="float: left;" href="/board/board_detail?board_seq=' + result[i].board_seq + '&page=' + now_page + '&listSize=' + listSize + '&type=' + type + '&searchKeyword=' + searchKeyword + '">&nbsp;&nbsp;';

                        for(let j = 1; j <= result[i].indent; j++){
                            content += (j == result[i].indent ? '↳ ' : '&nbsp; ');
                        }
                        content += result[i].board_title;
                    }

                    content += '</a></td>' + '<td>' + result[i].user_id + '</td>' + '<td>' + result[i].board_date + '</td>' + '<td>' + result[i].board_cnt + '</td>' ;
                }

                $(".listData").empty();
                $(".listData").append(content);

            },
            error: function(error){
                alert("error!!");
            }
        });
    }

</script>
</body>
</html>