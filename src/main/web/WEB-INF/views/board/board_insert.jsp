<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <title>자유게시판 등록</title>
    <style>
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

        #inner_box {
            margin: 50px 80px 50px 80px;
        }

        textarea {
            width: 80%;
            height: 400;
            resize: none;
        }

        select {
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

        #file-list a{
            font-size: small;
        }

    </style>
</head>
<body>
<div class="row" id="inner_box">
    <form action="/board/board_insertAction" method="post" enctype="multipart/form-data" onsubmit="return form_check();">
        <div class="col-2"></div>

        <div class="col-8" style="height: 50%;">
            <div>
                <h3>자유게시판 등록</h3>
            </div>

            <!-- 게시글 등록 S -->
            <div>
                <hr>
                <div>
                    제목
                    <input type="text" id="board_title" name="board_title" style="width: 80%; margin-left: 10%">
                </div>

                <hr>
                <div>
                    작성자
                    <span style="width: 20%; margin-left: 9%;">${session}</span>
                </div>
                <hr>

                <div>
                    익명여부
                    <input type="checkbox" value="1" id="board_anonymous" name="board_anonymous"
                           style="margin-left: 8%;">&nbsp;해당 게시글을 익명으로 작성합니다.
                </div>
                <hr>

                <div style="display: flex;">
                    내용
                    <textarea id="board_content" name="board_content" style="margin-left: 10%"></textarea>
                </div>
                <hr>

                <div id="file-list">
                    파일

                    <input style="margin-left: 10%;" type="file" id="file_select" multiple name="file">

                    <div id="file_upload_list">

                    </div>
                </div>
                <hr>
            </div>
            <!-- 게시글 등록 S -->

            <!-- 버튼 S -->
            <div style="float: right; margin-bottom: 5%;">
                <button class="insert_btn" id="btn" type="submit">등록</button>
                <a href="/board/board_list">
                    <button class="list_btn" type="button">목록</button>
                </a>
            </div>
            <!-- 버튼 E -->

            <input type="hidden" id="user_id" name="user_id" readonly value="${session}" >
        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    // 파일 데이터를 가지는 배열 <- 파일 첨부 시 들어가있음
    let fileList = new Array();

    // 사이즈 변경
    const getByteSize = (size) => {
        const byteUnits = "MB";

        size = Math.floor((size / 1024) / 1024);
        return size + byteUnits;
    };

    // 파일 추가 - file_select 가 바뀔 때마다 진행
    $("#file_select").on('change', function(){
        let files = $("input[name=file]")[0].files; // 0번째 input 접근
        let fileArr = new Array();
        fileArr = fileList; // <- 파일 첨부 시 들어가있음

        let file_html = '';

        // fileList에 file 객체로 담아주기
        for(let i = 0; i < files.length; i++){
            fileArr.push(files[i]);
        }
        $('#file_upload_list').empty();
        for(let i = 0 ; i < fileArr.length ; i++){
            let file_size = fileArr[i].size;
            let file_list_size = getByteSize(file_size); // 파일 사이즈
            file_html += '<p id="file_result_'+i+'" style="font-size: small; margin-left: 13%;">' + fileArr[i].name +'<b id="file_'+i+'" style="display: none">' + i + '</b> <span>(' + file_list_size + ')</span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(\''+i+'\')">삭제</a></p>';
        }

        fileList = new Array(); // 초기화
        fileList = fileArr;

        $('#file_upload_list').append(file_html);

        //input box 비우기
        $("#file_select").val('');
    });

    // 삭제할 경우, 반복하면서 keyNum 알맞게 갱신
    function file_delete(keynum){
        $('#file_result_'+keynum).remove();

        // 삭제할 파일의 아이디
        let delete_id =keynum;

        let fileArr = fileList;
        fileArr.splice(delete_id , 1); // 파일 제거

        let keyNum = 0;

        $('#file_upload_list').empty();

        fileList = new Array();
        let file_html = '';
        for(let i = 0; i < fileArr.length; i++){
            let file_size = fileArr[i].size;
            let file_list_size = getByteSize(file_size); // 파일 사이즈
            file_html += '<p id="file_result_'+keyNum+'" style="font-size: small; margin-left: 13%;">' + fileArr[i].name +'<b id="file_'+keyNum+'" style="display: none">' + keyNum + '</b> <span>(' + file_list_size + ')</span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(\''+keyNum+'\')">삭제</a></p>';

            keyNum++;
            fileList.push(fileArr[i]);
            console.log("keyNum" + keyNum);
        }

        $("#file_upload_list").append(file_html);
    }

    $("#board_anonymous").change(function(){
        if($("input[type=checkbox]:checked").val() == 1){
            alert("익명의 경우, 게시글 수정이 불가합니다.");
        }
    })

    // 글 등록 버튼 클릭 시
    $("#btn").click(function(){
        if(confirm("게시글을 등록하시겠습니까?") == true){ // 예
            // FormData 새로운 객체 생성
            let formData = new FormData();

            for(let i = 0; i < fileList.length; i++){
                formData.append("file", fileList[i]);
            }

            // 익명 여부 확인
            let anonymous = $("input[type=checkbox]:checked").val();

            if(anonymous == 1){
                anonymous = 1;
            }else if(anonymous != 1){
                anonymous = 0;
            }

            // formData 에 데이터 추가
            formData.append("board_title" , $("#board_title").val());
            formData.append("user_id" , $("#user_id").val());
            formData.append("board_anonymous" , anonymous);
            formData.append("board_content" , $("#board_content").val());

            // formData 데이터 확인
            for(let value of formData.values()){
                console.log(value);
            }

            // 유효성 검사
            let blank_pattern = /^\s+|\s+$/g; // 공백 검사

            if ($("#board_title").val() == "" || $("#board_title").val() == null) {
                alert("제목을 입력해주세요");
                $("#board_title").focus();
                return false;
            }

            if ($("#board_content").val() == "" || $("#board_content").val() == null) {
                alert("내용을 입력해주세요");
                $("#board_content").focus();
                return false;
            }

            $.ajax({
                url: "/board/board_insertAction",
                processData: false,
                contentType: false,
                enctype: 'multipart/form-data',
                data: formData,
                type: 'POST',
                success: function(result){
                    location.href = "/board/board_list";
                },
                error: function (error) {
                    alert("게시글 작성, 서버 통신 실패");
                    return false;
                }
            });
            return false;

        }else{ // 아니오
            return false;
        }
    })

</script>

</body>
</html>