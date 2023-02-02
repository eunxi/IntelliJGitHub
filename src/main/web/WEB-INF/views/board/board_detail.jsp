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

		a {
			text-decoration: none;
		}

		a:link {
			color: darkgray;
		}

		a:visited {
			color: darkgray;
		}

		a:hover {
			color: black;
		}

		a:active {
			color: black;
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

		textarea{
			width: 50%;
			height: 6.25em;
			resize: none;
		}

	</style>
</head>

<div class="row" id="inner_box">

	<div class="col-2"></div>

	<!-- 상세 화면 S -->
	<div class="col-8">
		<h3>자유게시판 상세 화면</h3>

		<hr>
		<div class="detailTitle" style="font-size: x-large; margin-bottom: 1%;">
			${board.board_title}
		</div>

		<div class="detailInfo" style="font-size: medium;">
			<b>${board.user_id}</b>&nbsp;&nbsp;<fmt:formatDate  value="${board.board_date}" type="DATE" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;[${board.board_cnt + 1}]
		</div>
		<hr>

		<div class="detailContent" style="height: 450px; overflow: auto;">
			<pre>${board.board_content}</pre>
		</div>
		<hr>

		<div class="detailFile">
			<c:if test="${not empty fileList}">
				<p>첨부 파일</p>
				<c:forEach var="file" items="${fileList}">
					<p style="margin-left: 1%; font-size: small;"><a href='/file_download.do/${file.b_num}/${file.file_seq}' id="file_btn">${file.file_name }</a> (${file.file_size}MB)</p>
				</c:forEach>
			</c:if>

			<c:if test="${empty fileList}">
				<p style="margin-left: 1%; font-size: small; color: darkgray;">등록된 첨부 파일이 없습니다.</p>
			</c:if>
		</div>
		<hr>

		<!-- 버튼 S -->
		<div style="float: right; margin-bottom: 1%;">
			<a href="javascript:void(0)"><button class="update_btn" type="button">수정</button></a>
			<a href="javascript:void(0)"><button class="del_btn" type="button">삭제</button></a>
			<a href="javascript:void(0)"><button class="list_btn" type="button">목록</button></a>
		</div>
		<!-- 버튼 E -->

	</div>
	<!-- 상세 화면 E -->

	<!-- 댓글 S -->
	<hr style="margin-top: 5%;">
	<div class="col-8 reply-form">
		<!-- 댓글 리스트 -->
		<div>
			<p>▶ 첫번째 댓글 | 작성자</p>
		</div>
		<div>
			<p>▶ 두번째 댓글 | 작성자</p>
		</div>
		<div>
			<p>▶ 세번째 댓글 | 작성자</p>
		</div>

		<!-- 댓글 작성 구간 -->
		<div>
			<p>
				<label>댓글 작성자</label> <input type="text">
			</p>
			<p>
				<textarea></textarea>
			</p>
			<p>
				<button type="button">댓글 작성</button>
			</p>
		</div>
	</div>
	<!-- 댓글 E -->

	<div class="col-2"></div>
		<!-- 페이지 유지하는데 필요한 데이터 값들 -->
		<input type="hidden" value="${searchVO.board_seq}" name="board_seq" id="board_seq"/>
		<input type="hidden" value="${searchVO.page}" name="page" id="page"/>
		<input type="hidden" value="${searchVO.listSize}" name="listSize" id="listSize"/>
		<input type="hidden" value="${searchVO.type}" name="type" id="type"/>
		<input type="hidden" value="${searchVO.searchKeyword}" name="searchKeyword" id="searchKeyword"/>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	// 수정
	$(".update_btn").click(function(){
		let url = "/board/board_update?board_seq=${searchVO.board_seq}&page=${searchVO.page}" +
		"&listSize=${searchVO.listSize}" +
		"&type=${searchVO.type}" +
		"&searchKeyword=${searchVO.searchKeyword}";

		location.href = url;
	})

	// 삭제
	$(".del_btn").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			// 취소(아니오) 버튼 클릭 시 이벤트 발생
			return false;
		}else{
			// 확인(예) 버튼 클릭 시 이벤트 발생
			alert("삭제 성공!");

			let url = "/board/board_delete?board_seq=${searchVO.board_seq}&page=${searchVO.page}" +
					"&listSize=${searchVO.listSize}" +
					"&type=${searchVO.type}" +
					"&searchKeyword=${searchVO.searchKeyword}";

			location.href = url;
		}
	})

	// 목록
	$(".list_btn").click(function(){
		let url = "/board/board_list?page=${searchVO.page}" +
				"&listSize=${searchVO.listSize}" +
				"&type=${searchVO.type}" +
				"&searchKeyword=${searchVO.searchKeyword}";

		location.href = url;
	})

</script>

</body>
</html>
