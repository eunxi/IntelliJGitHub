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
    <form action="/board/board_insertAction" method="post" onsubmit="return checkInsert();" enctype="multipart/form-data">
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

            <!-- 버튼 -->
            <div style="float: right; margin-bottom: 5%;">
                <button class="insert_btn" id="btn" type="submit">등록</button>
                <a href="/board/board_list.do">
                    <button class="list_btn" type="button">목록</button>
                </a>
            </div>

        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    // 첨부 파일을 다 가지고 있어야함
    let fileList = new Array;

    // 사이즈 변경
    const getByteSize = (size) => {
        const byteUnits = ["BYTE", "KB", "MB", "GB", "TB"];

        for(let i = 0; i < byteUnits.length; i++){
            size = Math.floor(size / 1024);

            if (size < 1024) return size.toFixed(1) + byteUnits[i];
        }
    };

    // 파일 삭제
    $(document).ready(function(){
        $("a[name='file-delete']").on("click", function(e){
            e.preventDefault();
            deleteFile($(this));
        });

        $("#file_select").on('change', function(){
            let str = '';

            /*str = "<div style='margin-left: 13%; margin-top: 1%;'>" +
                "<input type='file' id='file_select' multiple name='file'><a href='#this' name='file-delete'>삭제</a></div>";
            $("#file-list").append(str);*/

            let files = $("input[name=file]")[0].files; // 0번째 input 접근

            // fileList에 file 객체로 담아주기
            for(let i = 0; i < files.length; i++){
                fileList.push(files[i]);
            }

            console.log(fileList);
            $('#file_upload_list').empty();
            let file_html = '';

            for(let i = 0; i < fileList.length; i++){
                let file_size = fileList[i].size;
                let file_list_size = getByteSize(file_size);
                file_html += '<br><span style="font-size: small; margin-left: 15%;">' + fileList[i].name +' (' + file_list_size + ')<a style="margin-left: 3%;" href="#this" name="file-delete">삭제</a></span><br>';
            }
            $('#file_upload_list').append(file_html);

            $("a[name='file-delete']").on("click", function(e){
                e.preventDefault();
                deleteFile($(this));
            });

            //input box 비우기
            $("#file_select").val('');
        });

    })

    // 파일 삭제 함수
    function deleteFile(obj){
        obj.parent().remove();
    }

    // 체크박스 선택 시 값 가져오기
    $("#btn").click(function () {
        console.log($("input[type=checkbox]:checked").val());
        $("input[type=checkbox]:checked").val();
    })

    // 게시글 유효성 검사
    function checkInsert() {
        let blank_pattern = /^\s+|\s+$/g; // 공백 검사

        if ($("#board_title").val() == "") {
            alert("제목을 입력해주세요");
            $("#board_title").focus();
            return false;
        }

        if ($("#board_anonymous").val() == 0 || $("#user_id").val() == "" || blank_pattern.test($("#user_id").val()) == true) {
            alert("작성자를 입력해주세요");
            $("#user_id").focus();
            return false;
        }

        if ($("#board_content").val() == "") {
            alert("내용을 입력해주세요");
            $("#board_content").focus();
            return false;
        }

        if (!confirm("등록하시겠습니까?")) {
            // 취소(아니오) 버튼 클릭 시 이벤트 발생
            return false;
        } else {
            alert("등록 성공!");
        }
    };


</script>

</body>
</html>