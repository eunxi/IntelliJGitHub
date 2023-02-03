<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<title>자유게시판 상세</title>
	<style>
		/* 보여주기 */
		.show{
			display: block;
		}

		/* 숨기기 */
		.hide{
			display: none;
		}

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
			width: 40%;
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
	<div class="col-8 reply-form" >
		<p>댓글 [${reply_total}]</p>
		<!-- 댓글 리스트 -->
		<c:forEach items="${reply}" var="reply">
			<div id="">
			<div id="reply_form_${reply.r_seq}" style="border: 1px solid darkgray; margin-bottom: 2%;">
				<span id="reply_span${reply.r_seq}">
					<p style="font-size: small; margin-left: 1%; white-space:pre;" id="reply_content_${reply.r_seq}"> ${reply.r_content}</p>
						<span style="margin-left: 1%; font-size: small; margin-bottom: 2%;"> <span id="reply_user_${reply.r_seq}">${reply.user_id}</span>
							<span id="reply_date_${reply.r_seq}"> (<fmt:formatDate  value="${reply.r_date}" type="DATE" pattern="yyyy-MM-dd"/>) </span>
						<a id="reply_update_${reply.r_seq}" href="#this" onclick="reply_update_form(${reply.r_seq});" style="margin-left: 1%;">수정</a> <a href="#this" onclick="reply_delete_fn();" style="margin-left: 1%;">삭제</a>
					</p>
				</span>
			</div>
			</div>
		</c:forEach>

		<!-- 댓글 작성 구간 -->
		<form method="post" action="/reply/reply_insertAction">
			<div style="margin-top: 2%;">
				<p>
					<label style="font-size: small;">댓글 작성자</label> <input type="text" disabled name="user_id" id="user_id" style="width: 200px; height: 30px;">
					<button style="margin-left: 11%;" type="button" onclick="reply_insert_fn();">댓글 등록</button>
					<button style="margin-left: 1%;" type="button" onclick="reply_reset_fn();">초기화</button>
				</p>
				<p id="text_form">
					<textarea name="r_content" id="r_content" placeholder="댓글을 작성해주세요."></textarea>
				</p>
				<!-- 페이지 유지하는데 필요한 데이터 값들 -->
				<input type="hidden" value="${searchVO.board_seq}" name="board_seq" id="board_seq"/>
				<input type="hidden" value="${searchVO.page}" name="page" id="page"/>
				<input type="hidden" value="${searchVO.listSize}" name="listSize" id="listSize"/>
				<input type="hidden" value="${searchVO.type}" name="type" id="type"/>
				<input type="hidden" value="${searchVO.searchKeyword}" name="searchKeyword" id="searchKeyword"/>
				<input type="hidden" id="tbl_type" name="tbl_type" value="B"/>
			</div>
		</form>

		<div class="reply_test">

		</div>
	</div>
	<!-- 댓글 E -->

	<div class="col-2"></div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	// 댓글 작성 초기화
	function reply_reset_fn(){
		document.getElementById("r_content").value='';
	}

	// 댓글 작성
	function reply_insert_fn(){
		if($("#r_content").val() == ''){
			alert("댓글을 입력해주세요");
			$("#r_content").focus();
			return false;
		}

		let data_form = {
			b_num : $("#board_seq").val(),
			page : $("#page").val(),
			list_size : $("#listSize").val(),
			type : $("#type").val(),
			searchKeyword : $("#searchKeyword").val(),
			tbl_type : $("#tbl_type").val(),
			user_id : $("#user_id").val(),
			r_content : $("#r_content").val()
		}

		$.ajax({
			url : '/reply/reply_insertAction',
			type : 'post',
			data : data_form,
			success : function(result){
				location.href = "/board/board_detail?board_seq=" + data_form.b_num + "&page=" + data_form.page + "&listSize=" + data_form.list_size + "&type=" + data_form.type + "&searchKeyword=" + data_form.searchKeyword;
			},
			error : function (error) {
				alert("실패!");
			}
		});
	}

	// 댓글 수정
	function reply_update_form(num){
		alert("댓글 수정");

/*		console.log(num , "번째 댓글 수정");
		let reply_update = $("#reply_update_" + num); // 수정 버튼 -> 막아주기
		let content = $("#reply_content_" + num).html();
		let user = $("#reply_user_" + num).html();

		let html = '';

		html += '<div id="reply_layer_' + num + '"><p style="margin-left: 1%; margin-top: 1%;"><label style="font-size: small;">댓글 작성자</label> <input type="text" readonly name="reply_update_user" id="reply_update_user" style="width: 200px; height: 30px;" value="' + user + '">' +
				'<button style="margin-left: 15%;" type="button" onclick="reply_insert_fn(' + num + ');">수정</button>' +
				'<button style="margin-left: 1%;" type="button" onclick="rollback(' + num + ');">취소</button></p>' +
				'<p style="margin-left: 1%;" id="text_form"><textarea name="reply_update_content" id="reply_update_content" placeholder="댓글을 작성해주세요.">' + content + '</textarea></p></div>';

		$("#reply_form_" + num).append(html);*/
	}

/*	function rollback(no){
		console.log(no);
		$("#reply_layer_" + no).remove();
	}*/

/*	// 수정 ajax
	function reply_insert_fn(){
	}*/

	// 댓글 삭제
	function reply_delete_fn(){
		alert("댓글 삭제");
	}

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
