<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
  <title>자유게시판 등록</title>
  <style>
    #inner_box {
      margin : 50px 80px 50px 80px;
    }

    textarea{
      width: 80%;
      height: 400;
      resize: none;
    }

    select{
      height: 30px;
    }

    .insert_btn {
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
<body>
<div class="row" id="inner_box">
  <form action="/board/board_insertAction" method="post" onsubmit="return checkInsert();">
    <div class="col-2"></div>

  <div class="col-8" style="height: 50%;">
    <div>
      <h3>자유게시판 등록</h3>
    </div>

    <!-- 게시글 등록/수정 -->
    <!-- name 값은 DB의 각각의 컬럼값을 넣어야 값이 들어감 -->
    <div>
      <hr>
      <div>
        제목
        <input type="text" id="board_title" name="board_title" style="width: 80%; margin-left: 10%">
      </div>

      <hr>
      <div>
        작성자
        <input type="text" id="user_id" name="user_id" style="width: 20%; margin-left: 9%;">
      </div>
      <hr>

      <div>
        익명여부
        <input type="checkbox" id="board_anonymous" name="board_anonymous" style="margin-left: 8%;">&nbsp;해당 게시글을 익명으로 작성합니다.
      </div>
      <hr>

      <div style="display: flex;">
        내용
        <textarea id="board_content" name="board_content" style="margin-left: 10%"></textarea>
      </div>
      <hr>

      <div>
        파일
        <input type="file" id="board_file" name="board_file" multiple style="margin-left: 10%">
      </div>
      <hr>
    </div>

    <!-- 버튼 -->
    <div style="float: right; margin-bottom: 5%;">
      <button class="insert_btn" type="submit">등록</button>
      <a href="/board/board_list.do"><button class="list_btn" type="button">목록</button></a>
<%--      <button class="del_btn" type="button" onclick="delBoard();">삭제</button>--%>
    </div>

  </div>
  </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

  // 게시글 유효성 검사
  function checkInsert() {

    if($("#board_title").val() == ""){
      alert("제목을 입력해주세요");
      $("#board_title").focus();
      return false;
    }

    if($("#user_id").val() == ""){
      alert("작성자를 입력해주세요");
      $("#user_id").focus();
      return false;
    }

    if($("#board_content").val() == ""){
      alert("내용을 입력해주세요");
      $("#board_content").focus();
      return false;
    }

    if(!confirm("등록하시겠습니까?")){
      // 취소(아니오) 버튼 클릭 시 이벤트 발생
      return false;
    }else{
      alert("등록 성공!");
    }

  };

</script>

</body>
</html>