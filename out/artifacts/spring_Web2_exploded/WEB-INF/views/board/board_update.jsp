<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
  <title>자유게시판 수정</title>
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

    .rollback_btn {
      font-size: 18px;
      border: none;
      background-color: black;
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
  <form action="/board/board_updateAction" method="post" onsubmit="return checkUpdate();">
    <!-- form 제출(submit) 시 사용자는 변경 못하는 데이터 값을 서버에 함께 보내기 위해 hidden 사용 & board_seq 로 전달 -->
    <input type="hidden" id="board_seq" name="board_seq" value="${board.board_seq}"/>

    <!-- submit 할 때 값을 가져가기 위해 form 아래 hidden 설정해주고, 취소 버튼 눌러 상세 페이지로 갈 때 쿼리값 설정 -->

    <div class="col-2"></div>

    <div class="col-8" style="height: 50%;">
      <div>
        <h3>자유게시판 수정</h3>
      </div>

      <!-- 게시글 등록/수정 -->
      <!-- name 값은 DB의 각각의 컬럼값을 넣어야 값이 들어감 -->
      <!-- input 태그는 value에 값을 넣어주고 textarea는 태그 사이에 값을 넣어줘야함, 취소의 경우 해당 게시물 상세 페이지로 돌아갈 수 있도록 주소 뒤에 인덱스 값 넣어주기 -->
      <!-- form 태그 밑에 hidden 으로 board_seq 값 넣어서 컨트롤러에 가지고 갈 수 있도록 진행 -->
      <div>
        <hr>
        <div>
          제목
          <input type="text" id="board_title" name="board_title" value="${board.board_title}" style="width: 80%; margin-left: 10%">
        </div>

        <hr>
        <div>
          작성자
          <input type="text" id="user_id" name="user_id" value="${board.user_id}" style="width: 20%; margin-left: 9%;">
        </div>
        <hr>

        <div>
          익명여부
          <input type="checkbox" id="board_anonymous" name="board_anonymous" style="margin-left: 8%;">&nbsp;해당 게시글을 익명으로 작성합니다.
        </div>
        <hr>

        <div style="display: flex;">
          내용
          <textarea id="board_content" name="board_content" style="margin-left: 10%">${board.board_content}</textarea>
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
        <button class="update_btn" type="submit">수정</button>
        <a href="/board/board_detail.do?board_seq=${board.board_seq}"><button class="rollback_btn" type="button">취소</button></a>
        <!-- searchVO.query 함께 넘겨주면, 화면이 넘어갈 때마다 쿼리값을 가져와서 페이지 유지 가능 -->
      </div>

    </div>
  </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

  function checkUpdate(){
    if(!confirm("수정하시겠습니까?")){
      // 취소(아니오) 버튼 클릭 시 이벤트 발생
      return false;
    }else{
      alert("수정 성공!");
    }
  }



</script>

</body>
</html>