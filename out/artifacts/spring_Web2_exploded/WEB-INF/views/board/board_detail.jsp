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

		.active {
			background-color: skyblue;
			width: 30px;
			height: 30px;
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

		.comment_btn {
			font-size: 18px;
			border: none;
			background-color: darkgray;
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

		#pagination{
			cursor: pointer;
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
<%--			<a href="/comment/com_insert"><button class="comment_btn" type="button">답글</button></a>--%>
			<a href="javascript:void(0)"><button class="comment_btn" type="button">답글</button></a>
		</div>
		<!-- 버튼 E -->

	</div>
	<!-- 상세 화면 E -->

	<!-- 댓글 S -->
	<hr style="margin-top: 5%;">
	<div class="col-8 reply-form" >
		<p id="reply_cnt">댓글 [${r_total}]</p>

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

				<input type="hidden" value="${r_page}" id="r_page" name="r_page"/>
				<input type="hidden" value="${r_amount}" id="r_amount" name="r_amount"/>
				<input type="hidden" value="${endPage}" id="endPage"/>

				<input type="text" value="${board.step}" id="step" name="step"/>
				<input type="text" value="${board.indent}" id="indent" name="indent"/>
				<input type="text" value="${board.root}" id="root" name="root"/>

			</div>
		</form>

		<!-- 댓글 리스트 Ajax -->
		<div id="reply_div">

		</div>

		<!-- 댓글 페이징 S -->
		<div class="reply_pagination" style="margin-left: 45%;">
			<ul id="pagination">
				<c:if test="${r_page ne 1}">
					<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				</c:if>

				<c:forEach begin="${startPage}" end="${endPage}" var="i">
					<c:if test="${r_page ne i}">
						<li class="page-item"><a class="page-link" href="#this"> ${i} </a></li>
					</c:if>

					<c:if test="${r_page eq i}">
						<li class="page-item active"><a class="page-link" href="#this"> ${i} </a></li>
					</c:if>
				</c:forEach>

				<c:if test="${r_page lt r_total / r_amount}">
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 댓글 페이징 E -->

		<div class="scroll_up">
			<button style="float: right" type="button" onclick="up_btn();">Up</button>
		</div>

		<div></div>

	</div>
	<!-- 댓글 E -->

	<div class="col-2"></div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	// 댓글 페이징
	$(document).on('click', '#pagination', function(e){

        if($(e.target).text().trim() == "Previous"){
            $("#r_page").val(Number($("#r_page").val()) - 1);
        }else if($(e.target).text().trim() == "Next"){
        	$("#r_page").val(Number($("#r_page").val()) + 1);
		}else{
        	$("#r_page").val(Number($(e.target).text()));
		}

        let page = Number($("#r_page").val());
        let b_num = Number($("#board_seq").val());

        console.log("page : " + page);
        console.log("b_num : " + b_num);

        getReply_list();
	})

	// 스크롤 위
	function up_btn(){
		window.scrollTo(0, 0);
	}

	// 댓글 리스트 불러오기
	$(document).ready(function () {
		getReply_list();
	});

	function getReply_list(){
		let page = Number($("#r_page").val());
		let r_amount = Number($("#r_amount").val());

		let data_form = {
			b_num : $("#board_seq").val(),
			r_page : $("#r_page").val(),
			r_amount : $("#r_amount").val()
		}

		let html = '';
		let page_html = '';

		$.ajax({
			url: "/reply/reply_list",
			type: 'post',
			dataType: 'json',
			data : data_form,
			success: function (result) {
				console.log(result);
				if(result.length < 1){
					html = "<div style='font-size: small; color: darkgray;'>등록된 댓글이 없습니다.</div>";
				}else{
					$(result).each(function(){
						html += '<div id="reply_seq_' + this.r_seq + '" style="border: 1px solid darkgray; margin-bottom: 2%;"><span>' +
								'<p style="font-size: small; margin-left: 1%;"><pre style="margin-left: 1%;">' + this.r_content + '</pre></p>' +
								'<span style="margin-left: 1%; font-size: small; margin-bottom: 2%;"> <span>' + this.user_id + '</span>' +
								'<span> (' + this.r_date + ') </span>' +
								'<a href="#this" style="margin-left: 1%;" onclick="reply_update_form(' + this.r_seq + ',\'' + this.r_date + '\', \'' + this.r_content + '\', \'' + this.user_id + '\')">수정</a>' +
								'<a href="#this" style="margin-left: 1%;" onclick="reply_delete_fn(' + this.r_seq + ')">삭제</a></p></span></div>'
						;
					})
				};

				let endPage = Number($("#endPage").val());

				// Pagination
				let start_page = 0;
				let end_page = 0
				let amount = r_amount;


				if(start_page < 3){
					start_page = 1;

				}else{
					start_page = page - 2;
				}

				if(page + 2 > end_page){
					end_page = endPage;
				}else {
					end_page = page + 2;
				}

				if(page > 1){
					page_html += '<li class="page-item"><a class="page-link">Previous</a></li>';
				}

				for(let i = start_page; i <= end_page; i++){

					if(page != i){
						console.log("page != i : " + page + " " + i )
						page_html += '<li class="page-item"><a class="page-link">' + i + '</a></li>';
					}

					if(page == i){
						console.log("page == i : " + page + " " + i )
						page_html += '<li class="page-item active"><a class="page-link">' + i + '</a></li>';
					}
				}

				if(page < endPage){
					page_html += '<li class="page-item"><a class="page-link">Next</a></li>';
				}

				// html += '<div class="reply_pagination" style="margin-left: 45%;"><ul id="pagination"></ul></div>';

				$("#reply_div").empty();
				$("#reply_div").append(html);

				$("#pagination").empty();
				$("#pagination").append(page_html);

			},
			error: function(error){
				alert("실패");
			}
		})
	}

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

		let content = $("#r_content").val().replaceAll("\n", "<br/>");

		let data_form = {
			b_num : $("#board_seq").val(),
			page : $("#page").val(),
			list_size : $("#listSize").val(),
			type : $("#type").val(),
			searchKeyword : $("#searchKeyword").val(),
			tbl_type : $("#tbl_type").val(),
			user_id : $("#user_id").val(),
			r_content : content
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

	// 댓글 수정 form 변경만 진행
	function reply_update_form(r_seq, r_date, r_content, user_id){
		console.log("댓글 수정 데이터 값");

		let html = '';

		r_content = r_content.replaceAll("<br/>", "\n");
		r_content = r_content.replaceAll("<br>", "\n");
		r_content = r_content.replaceAll("</a>", "");

		html += '<div id="reply_seq_' + r_seq + '"><p>' +
				'<label style="font-size: small;">댓글 작성자</label> <input type="text" disabled style="width: 200px; height: 30px;" value="' + user_id + '">' +
				'<button style="margin-left: 11%;" type="button" onclick="update_btn(' + r_seq + ');">수정</button>' +
				'<button style="margin-left: 1%;" type="button" onclick="location.reload();">취소</button></p>' +
				'<p id="text_form"><textarea id="update_content_' + r_seq + '" placeholder="댓글을 작성해주세요.">' + r_content + '</textarea></p></div>';

		$("#reply_seq_" + r_seq).replaceWith(html);
	}

	// 댓글 수정 ajax
	function update_btn(r_seq){
		if($("#update_content_" + r_seq).val() == ''){
			alert("댓글을 입력해주세요");
			$("#update_content_" + r_seq).focus();
			return false;
		}

		let content = $("#update_content_" + r_seq).val().replaceAll("\n", "<br/>");

		let data_form = {
			r_seq : r_seq,
			r_content : content,
			b_num : $("#board_seq").val(),
			page : $("#page").val(),
			list_size : $("#listSize").val(),
			type : $("#type").val(),
			searchKeyword : $("#searchKeyword").val(),
			tbl_type : $("#tbl_type").val(),
			user_id : $("#user_id").val()
		}

		$.ajax({
			url: '/reply/reply_updateAction',
			type: 'post',
			data: data_form,
			success: function(result){
				location.href = "/board/board_detail?board_seq=" + data_form.b_num + "&page=" + data_form.page + "&listSize=" + data_form.list_size + "&type=" + data_form.type + "&searchKeyword=" + data_form.searchKeyword;
			},
			error: function (error) {
				alert("댓글 수정 ajax 실패");
			}
		});
	}

	// 댓글 삭제
	function reply_delete_fn(r_seq){
		alert("댓글 삭제");

		let data_form = {
			r_seq : r_seq,
			b_num : $("#board_seq").val(),
			page : $("#page").val(),
			list_size : $("#listSize").val(),
			type : $("#type").val(),
			searchKeyword : $("#searchKeyword").val(),
			tbl_type : $("#tbl_type").val(),
			user_id : $("#user_id").val()
		}

		console.log(data_form);

		$.ajax({
			url: '/reply/reply_delete',
			type: 'post',
			data: data_form,
			success: function(result){
				location.href = "/board/board_detail?board_seq=" + data_form.b_num + "&page=" + data_form.page + "&listSize=" + data_form.list_size + "&type=" + data_form.type + "&searchKeyword=" + data_form.searchKeyword;

			},
			error: function (error) {
				alert("댓글 삭제 실패!");
			}
		})

	}

	// 답글
	$(".comment_btn").click(function(){
		let url = "/comment/com_insert?board_seq=${searchVO.board_seq}&page=${searchVO.page}&listSize=${searchVO.listSize}&type=${searchVO.type}&searchKeyword=${searchVO.searchKeyword}";
		location.href = url;
	})

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
