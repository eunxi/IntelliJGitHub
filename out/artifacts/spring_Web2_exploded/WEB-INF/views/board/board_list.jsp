<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <title>자유게시판</title>
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
    <!-- 검색 가능하도록 form 태그, id  값 생성하여 검색 함수 호출 시 id 값을 불러 submit 가능하도록 설정 -->
    <form method="get" id="listForm" action="/board/board_list">

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

                <input type="text" value="${searchKeyword}" name="searchKeyword" id="searchKeyword" style="width: 200px; height: 30px;"/>

                <a href="#">
                    <button type="button" id="search_btn">검색</button>
                </a>
                <a href="/board/board_list">
                    <button class="reset_btn" type="button">초기화</button>
                </a>
            </div>
        </div>
        <!-- 검색E -->

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
                        <a href="/board/board_detail?board_seq=${list.board_seq}&seq=${allCount}&page=${allSearch.page}&listSize=${listSize}&type=${type}&searchKeyword=${searchKeyword}">${list.board_title}</a>
                    </td>
                    <td>${list.user_id}</td>
                    <td>
                        <fmt:formatDate value="${list.board_date}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${list.board_cnt}</td>
                </tr>
            </c:forEach>
            </tbody>

        </table>

        <div id="page_bottom" style="margin-top: 1%; margin-bottom: 3%;">
            <span id="page_total">총 ${all_count} 건 | 페이지 (${allPage} / ${page})</span>
             &nbsp;&nbsp;

            <select id="dataPerPage" name="dataPerPage" style="height: 30px; width: 100px; text-align: center;">
                <option value="10" <c:if test="${allSearch.getListSize() == 10 }">selected="selected"</c:if>>10개씩 보기</option>
                <option value="15" <c:if test="${allSearch.getListSize() == 15 }">selected="selected"</c:if>>15개씩 보기</option>
                <option value="20" <c:if test="${allSearch.getListSize() == 20 }">selected="selected"</c:if>>20개씩 보기</option>
<%--                <option value="10">10개씩 보기</option>--%>
<%--                <option value="15">15개씩 보기</option>--%>
<%--                <option value="20">20개씩 보기</option>--%>
            </select>

            <a href="/board/board_insert.do" class="top-btn">글 등록</a>
        </div>

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
                        <li class="page-item active"><a class="page-link" href="/board/board_list.do?page=${i}"> ${i} </a></li>
                    </c:if>
                </c:forEach>

                <c:if test="${allPage lt allCount / listSize}">
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </c:if>
            </ul>
        </div>
        <!-- pagination{e} -->

        <!-- 검색 및 Ajax -->
        <input type="hidden" value="${allSearch.page}" id="search_page"/> <!-- 현재 페이지 값 -->
        <input type="hidden" value="${listSize}" id="listSize" name="listSize"/> <!-- selected 값에 따라 바뀌는 목록 출력 값 -->
        <input type="hidden" value="${page}" id="total_page"/> <!-- listSize에 따라 바뀌는 전체 페이지 값 -->
        <input type="hidden" value="${all_count}" id="total_cnt"/> <!-- 전체 글 개수 값 -->
        <input type="hidden" value="${type}" name="type" id="type"/> <!-- 검색 type -->

    </form>
</div>

<script type="text/javascript">

    // 검색버튼 클릭할 경우
    $(document).on('click', '#search_btn', function(){

        let searchType = $("#select_box").val();
        let searchKeyword = $("#searchKeyword").val();

        let realType = $("#type").val(searchType);

        console.log($("#type").val());

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

        // $("#listForm").find("input[name='type']").val(searchType);
        // $("#listForm").find("input[name='searchKeyword']").val(searchKeyword);
        // $("#listForm").submit();

        let url = "/board/board_list?type=" + $("#type").val() + "&searchKeyword=" + $("#searchKeyword").val();
        location.href = url;
        // alert(url);

        make();
    });

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

                let rec = $('#sort_table').find('tbody>tr').get();

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

    <%--<span id="page_total">총 ${cnt} 건 | 페이지 (${allPage} / ${page}) </span>--%>

    // 페이지 개수 출력 - 총 페이지, 목록 개수 지정 필요
    // 페이지 목록 개수 선택
    $("select[name=dataPerPage]").change(function(){
        let dataPerPage = $("#dataPerPage").val ();

        $("#listSize").val(dataPerPage);

        let now_page = $("#search_page").val(); // 현재 페이지 수
        let real_page_end = Math.ceil(Number($("#total_cnt").val()) / Number($("#listSize").val())); // 진짜 총 페이지 - 정수 맞음
        // console.log("total_cnt : " + Number($("#total_cnt").val()));
        // console.log("listSize : " + Number($("#listSize").val()));
        // console.log();
        // console.log("real_page_end : " + real_page_end);

        // console.log("---------시작------------");
        $("#total_page").val(real_page_end);
        let total_page = Number($("#total_page").val()); // 전체 페이지(total_page)에 listSize에 따라 변동되는 real_page_end 값 넣어주기 - 정수 아님
        // console.log("---------끝 ------------");

        make();
    });

    // 내용 변경
    function make(){
        let count = 0;
        let all_count = 0;
        let dataPerPage = $("#dataPerPage").val(); // option selected 값
        let listSize = Number($("#listSize").val()); // 출력 개수 (VO)
        // let perPageSize = $("#listSize").val(dataPerPage); // 목록 개수 넣기 -> 진짜 한 페이지당 게시되는 게시물 수 -> 없어도 되는 코드

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

                console.log(endPage);
                // 화면 페이지 번호
                for(let i = startPage; i <= endPage; i++){
                    if(Number($("#search_page").val()) != i){
                        //content += `<li class="page-item"><a class="page-link" href="#">${i}</a></li>`;
                        content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
                    }
                    if(Number($("#search_page").val()) == i){
                        //content += `<li class="page-item active"><a class="page-link" href="#">${i}</a></li>`;
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

                content2 += '<span id="page_total">총 ' + all_total + ' 건 | 페이지 ( ' + now_page + ' / ' +  total_page + ' ) </span>';

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

                console.log("now_page: " + now_page);
                console.log("listSize: " + listSize);
                console.log("type: " + type);
                console.log("searchKeyword: " + searchKeyword);
                console.log("count: " + count);

                for(let i = 0; i < result.length; i++){
                    content +=
                        '<tr>' +
                        '<td>' + result[i].no +
                        '<input type="hidden" name="board_seq" id="board_seq" value="' + result[i].board_seq + '"/></td>' +
                        '<td>' +
                        '<a href="/board/board_detail?board_seq=' + result[i].board_seq + '&seq=' + result[i].no + '&page=' + now_page + '&listSize=' + listSize + '&type=' + type + '&searchKeyword=' + searchKeyword + '">' + result[i].board_title + '</a></td>' +
                        '<td>' + result[i].user_id + '</td>' +
                        '<td>' + result[i].board_date + '</td>' +
                        '<td>' + result[i].board_cnt + '</td>'
                    ;
                    // count--;
                }

                <%--result.map((list) => { // result를 map--%>
                <%--    content +=--%>
                <%--        `<tr>--%>
                <%--            <td>${count}--%>
                <%--                <input type="hidden" name="board_seq" id="board_seq" value="${list.board_seq}"/>--%>
                <%--            </td>--%>
                <%--            <td>--%>
                <%--                <a href="/board/board_detail?board_seq=${list.board_seq}&seq=${count}">${list.board_title}</a>--%>
                <%--            </td>--%>
                <%--            <td>${list.user_id}</td>--%>
                <%--            <td>--%>
                <%--                ${list.board_date}--%>
                <%--            </td>--%>
                <%--            <td>${list.board_cnt}</td>--%>
                <%--        </tr>`;--%>
                <%--    count--;--%>
                <%--})--%>

                $("#sort_table tbody").empty();
                $("#sort_table tbody").append(content);

                // $("#sort_table tbody").html(content);
            },
            error: function(error){
                alert("error!!");
            }
        });
    }

</script>
</body>
</html>