<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<title>자유게시판 상세</title>
	<style>
		#inner_box {
			margin : 50px 80px 50px 80px;
		}

		.update_btn {
			font-size: 18px;
			border: none;
			background-color: blue;
			width: 50px;
			height: 30px;
			border-radius: 15px;
			color: #fff;
			cursor: pointer;
		}

		.list_btn {
			font-size: 18px;
			border: none;
			background-color: black;
			width: 50px;
			height: 30px;
			border-radius: 15px;
			color: #fff;
			cursor: pointer;
		}

		.del_btn {
			font-size: 18px;
			border: none;
			background-color: red;
			width: 50px;
			height: 30px;
			border-radius: 15px;
			color: #fff;
			cursor: pointer;
		}

	</style>
</head>

<div class="row" id="inner_box">
	<div class="col-2"></div>
	<div class="col-8">
		<h3>자유게시판 상세 화면</h3>

		<hr>
		<div class="detailTile" style="font-size: x-large; margin-bottom: 1%;">
			${board.board_title}
		</div>

		<div class="detailInfo" style="font-size: medium;">
			<b>${board.user_id}</b>&nbsp;&nbsp;<fmt:formatDate  value="${board.board_date}" type="DATE" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;[${board.board_cnt + 1}]
		</div>
		<hr>

		<div class="detailContent" style="height: 450px; overflow: auto;">
			${board.board_content}
		</div>
		<hr>

		<div class="detailFile">
			첨부된 파일명 클릭시 다운로드 가능하게 진행
		</div>
		<hr>

		<div style="float: right; margin-bottom: 5%;">
			<a href="/board/board_update?board_seq=${board.board_seq}"><button class="update_btn" type="button">수정</button></a>
			<a href="javascript:void(0)" onclick="delBoard();"><button class="del_btn" type="button">삭제</button></a>
			<a href="/board/board_list.do"><button class="list_btn" type="button">목록</button></a>
		</div>

	</div>
	<div class="col-2"></div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	function delBoard(){
		if(!confirm("삭제하시겠습니까?")){
			// 취소(아니오) 버튼 클릭 시 이벤트 발생
			return false;
		}else{
			// 확인(예) 버튼 클릭 시 이벤트 발생
			alert("삭제 성공!");
			location.href="${pageContext.request.contextPath}/board/board_delete.do?board_seq=${board.board_seq}";
		}
	}

</script>

</body>
</html>
