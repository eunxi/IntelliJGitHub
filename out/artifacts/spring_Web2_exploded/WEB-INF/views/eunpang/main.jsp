<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>은팡</title>
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
        /*ul, lo, li { margin:4% 0 2% 5%; padding:0; list-style:none; }*/
        ul, lo, li { margin0; padding:0; list-style:none; }

        ul.category-menu li { position:relative; width:80px; padding:5px 10px; text-align:center; }
        ul.category-menu li:hover { background:#fff; }
        ul.category-menu li > ul.submenu { display:none; position:absolute; top:0; left:100px;  }
        ul.category-menu li:hover > ul.submenu { display:block; }
        ul.category-menu li:hover > ul.submenu li a {  }
        ul.category-menu li:hover > ul.submenu li a:hover {}
        ul.category-menu li > ul.submenu li {}

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
            background-color: #819FF7;
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
    </style>
</head>
<body>
<div>
    <button type="button" style="float: right;">상품 등록</button>

    <div class="dataPerPage">
        <span style="float: right">
            <select id="select_data" name="dataPerPage" style="height: 30px; width: 100px; text-align: center;">
                <option value="12" <c:if test="${allSearch.getListSize() == 10 }">selected="selected"</c:if>>12개씩 보기</option>
                <option value="20" <c:if test="${allSearch.getListSize() == 15 }">selected="selected"</c:if>>20개씩 보기</option>
            </select>
        </span>
    </div>


    <div id="header">
        <h1><a href="/eunpang/" style="margin-left: 2%;">은팡</a></h1>
        <span style="margin-left: 2%;">로그인한 사용자 : ${session}</span>
    </div>

    <div id="menu">
        <h3 style="margin: 2% 0 0 5%;">카테고리</h3>
        <ul class="category-menu">
            <li class="cate1"><a href="/eunpang/main?c=100&l=1">식품</a>
                <ul class="cate1-sub row submenu">
                    <li><a href="/eunpang/main?c=101&l=2">과일</a></li>
                    <li><a href="/eunpang/main?c=102&l=2">채소</a></li>
                    <li><a href="/eunpang/main?c=103&l=2">간식</a></li>
                    <li><a href="/eunpang/main?c=104&l=2">음료</a></li>
                </ul>
            </li>
            <li class="cate2"><a href="">생활용품</a>
                <ul class="cate2-sub row submenu">
                    <li><a href="">방한용품</a></li>
                    <li><a href="">헤어</a></li>
                    <li><a href="">바디</a></li>
                    <li><a href="">구강</a></li>
                </ul>
            </li>
            <li class="cate3"><a href="">뷰티</a>
                <ul class="cate3-sub row submenu">
                    <li><a href="">스킨케어</a></li>
                    <li><a href="">클렌징</a></li>
                    <li><a href="">메이크업</a></li>
                    <li><a href="">향수</a></li>
                </ul>
            </li>
            <li class="cate4"><a href="">취미</a></li>
        </ul>
    </div>

    <div id="content">
        <c:forEach var="pro" items="${pro_list}">
            <div class="product_box" style="margin: 2% 2% 1% 2%;">
                <p><img src="${pro.p_image1}"/> </p>
                <p style="font-size: small">${pro.p_name}</p>
                <p>
                    <span style="color: darkgray; text-decoration: black line-through;">${pro.p_cost}</span>
                </p>
                <p><span>${pro.p_price}원</span>&nbsp;&nbsp;<span style="font-weight: bolder;">${pro.p_delivery}</span></p>
                <p>내일(수) 새벽 도착 보장</p>
                <p>★★★★☆&nbsp;(101)</p>
            </div>

        </c:forEach>
    </div>

    <div id="footer">
        여기서 페이징
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 카테고리명
    // console.log($("#cate_name_}").val());

    function cate_fn(num){
        alert(num + "클릭!");
    }














































</script>
</body>
</html>
