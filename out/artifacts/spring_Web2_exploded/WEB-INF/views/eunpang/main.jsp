<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>은팡!</title>
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

        h1, h2, h3, h4, h5, h6 { margin:0; padding:0; }
        ul, lo, li { margin:4% 0 2% 5%; padding:0; list-style:none; }

        #header{
            width:100%;
            height:80px;
        }

        #menu{
            width:15%;
            height:1500px;
            float:left;
            background-color: #F2F2F2;
        }

        #content{
            width:85%;
            float:right;
            height:1500px;
        }

        #footer{
            width:100%;
            clear:both;
            height:80px;
            font-size: larger;
        }

        .product_box{
            width: 20%;
            height: 30%;
            border: 1px solid black;
            float: left;
        }

        .product_box > * {
            text-align: center;
        }

        #search_box{
            width: 1000px;
            height: 40px;
            font-size: medium;
        }

        #search_option{
            width: 100px;
            height: 40px;
        }

        #search_btn{
            width: 50px;
            height: 40px;
        }

        .pageInfo_area ul, li{
            margin: 0 0 0 0;
        }

        .pageInfo{
            list-style: none;
            display: inline-block;
            margin: 50px 0 0 100px;
        }

        .pageInfo li{
            float: left;
            font-size: 20px;
            margin-left: 18px;
            padding: 7px;
            font-weight: 500;
        }

        .active{
            background-color: #cdd5ec;
        }

    </style>
</head>
<body>
<div>
    <button type="button" style="float: right;">상품 등록</button>

    <div class="dataPerPage">
        <span style="float: right">
            <select id="cntPerPage" name="sel" onchange="sel_change();" style="height: 30px; width: 100px; text-align: center;">
                <option value="12" <c:if test="${criteria.cntPerPage == 12}">selected="selected"</c:if>>12개씩 보기</option>
                <option value="20" <c:if test="${criteria.cntPerPage == 20}">selected="selected"</c:if>>20개씩 보기</option>
            </select>
        </span>
    </div>

    <div class="search_area" style="align-items: center; margin-left: 15%;">
        <select id="search_option" name="s_type">
            <option value="" <c:out value="${map.type == null ? 'selected' : ''}" />>전체</option>
                <c:forEach var="c1" items="${list_cate1}">
                    <c:if test="${c1.pc_code % 100 == 0}">
                        <option value="${c1.pc_codeRef}" <c:out value="${map.type eq c1.pc_codeRef ? 'selected' : ''}" />>${c1.pc_name}</option>
                    </c:if>
                </c:forEach>
        </select>

        <input type="text" name="s_keyword" value="${map.keyword}" id="search_box"/>
        <button id="search_btn" type="button">검색</button>
    </div>

    <div id="header">
        <h1><a href="/eunpang/" style="margin-left: 2%;">은팡</a></h1>
        <span style="margin-left: 2%;">로그인한 사용자 : ${session}</span>
    </div>

    <div id="menu">
        <h3 style="margin: 2% 0 0 5%;"><a href="/eunpang/">카테고리</a></h3>
        <ul>
            <c:forEach var="c1" items="${list_cate1}">
            <li>
                <c:choose>
                    <c:when test="${c1.pc_code % 100 == 0}">
                        <c:choose>
                            <c:when test="${c1.pc_code eq pc_codeRef}">
                                <a href="/eunpang/?pc_codeRef=${c1.pc_code}" class="active">${c1.pc_name}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/eunpang/?pc_codeRef=${c1.pc_code}">${c1.pc_name}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>

                    <c:otherwise>
                        <ul>
                            <c:choose>
                                <c:when test="${c1.pc_code eq cate.pc_code}">
                                    <li><a href="/eunpang/?pc_code=${c1.pc_code}" class="active">${c1.pc_name}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="/eunpang/?pc_code=${c1.pc_code}">${c1.pc_name}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </li>
            </c:forEach>
        </ul>
    </div>

    <div id="content">
        <c:if test="${empty pro_list}">
            <c:out value="${WAIT}"/>
        </c:if>
        <c:forEach var="pro" items="${pro_list}">
            <div class="product_box" style="margin: 2% 2% 1% 2%;">
                <a href="/eunpang/detail?p_seq=${pro.p_seq}">
                    <p><img src="${pro.p_image1}" width=250px, height=230px/></p>
                    <p style="font-size: small">${pro.p_name}</p>
                </a>
                <p>
                    <span style="color: darkgray; text-decoration: black line-through;">${pro.p_cost}</span>
                </p>
                <p><span>${pro.p_price}원</span>&nbsp;&nbsp;<span style="font-weight: bolder;">${pro.p_delivery}</span></p>
                <p>내일(수) 새벽 도착 보장</p>
                <p>★★★★☆&nbsp;(101)</p>
            </div>
        </c:forEach>
    </div>

    <div class="pageInfo_wrap" id="footer">
        <div class="pageInfo_area" style="display: block; text-align: center;">
            <ul id="pageInfo" class="pageInfo">
                <!-- 이전 페이지 -->
                <c:if test="${criteria.prev}">
                    <li class="pageInfo_btn previous">
                        <a href="/eunpang/?pc_codeRef=${pc_codeRef}&pc_code=${cate.pc_code}&nowPage=${criteria.startPage - 1}&cntPerPage=${criteria.cntPerPage}&t=${map.type}&q=${map.keyword}">&lt;</a>
                    </li>
                </c:if>

                <!-- 각 페이지 번호 버튼 -->
                <c:forEach var="i" begin="${criteria.startPage}" end="${criteria.endPage}">
                    <li class="pageInfo_btn ${criteria.nowPage == i ? 'active' : ''}">
                        <a href="/eunpang/?pc_codeRef=${pc_codeRef}&pc_code=${cate.pc_code}&nowPage=${i}&cntPerPage=${criteria.cntPerPage}&t=${map.type}&q=${map.keyword}">${i}</a>
                    </li>
                </c:forEach>

                <!-- 다음 페이지 -->
                <c:if test="${criteria.next}">
                    <li class="pageInfo_btn next">
                        <a href="/eunpang/?pc_codeRef=${pc_codeRef}&pc_code=${cate.pc_code}&nowPage=${criteria.endPage + 1}&cntPerPage=${criteria.cntPerPage}&t=${map.type}&q=${map.keyword}">&gt;</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>

    <form method="get" id="actionForm" action="/eunpang/">
        <input type="hidden" name="pc_codeRef" value="${pc_codeRef}"/>
        <input type="hidden" name="nowPage" value="${criteria.nowPage}"/>
        <input type="hidden" name="cntPerPage" value="${criteria.cntPerPage}"/>
        <input type="hidden" name="keyword" value="${map.keyword}"/>
        <input type="hidden" name="type" value="${map.type}"/>
    </form>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 개수 보기
    function sel_change(){
        let sel = document.getElementById('cntPerPage').value;
        // document.getElementById('menu').style.height = "2500px";
        // document.getElementById('menu').style.backgroundColor = "red";

        location.href = "/eunpang/?pc_code=${cate.pc_code}&nowPage=${criteria.nowPage}&cntPerPage=" + sel;
    }

    // 검색 버튼
    $("#search_btn").on('click', function(){
        let type = $(".search_area select").val();
        let keyword = $(".search_area input[name='s_keyword']").val();

        if(!type){
            alert("분류를 선택하세요.");
            return false;
        }

        if(!keyword){
            alert("키워드를 입력하세요.");
            return false;
        }

        $("#actionForm").find("input[name='pc_codeRef']").val(type);
        $("#actionForm").find("input[name='type']").val(type);
        $("#actionForm").find("input[name='keyword']").val(keyword);
        $("#actionForm").find("input[name='nowPage']").val(1);
        $("#actionForm").submit();
    })

    // 페이징
    $(".pageInfo a").on('click', function(){
        let cntPerPage = document.getElementById('cntPerPage').value;

        $("#actionForm").find("input[name='nowPage']").val($(this).attr("href"));
        $("#actionForm").find("input[name='cntPerPage']").val(cntPerPage);
        $("#actionForm").attr("action", '/eunpang/');
        $("#actionForm").submit();
    });













































</script>
</body>
</html>
