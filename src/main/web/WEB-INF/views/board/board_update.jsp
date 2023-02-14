<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <title>자유게시판 수정</title>
    <style>
        #inner_box {
            margin: 50px 80px 50px 80px;
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

        textarea {
            width: 80%;
            height: 400;
            resize: none;
        }

        select {
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
    <form action="/board/board_updateAction" method="post" enctype="multipart/form-data">
        <input type="hidden" id="board_seq" name="board_seq" value="${board.board_seq}"/>

        <div class="col-2"></div>

        <div class="col-8" style="height: 50%;">
            <div>
                <h3>자유게시판 수정</h3>
            </div>

            <!-- 게시글 등록/수정 S -->
            <div>
                <hr>
                <div>
                    제목
                    <input type="text" id="board_title" name="board_title" value="${board.board_title}"
                           style="width: 80%; margin-left: 10%">
                </div>

                <hr>
                <div>
                    작성자
                    <span style="width: 20%; margin-left: 9%;">${session}</span>
                </div>
                <hr>

                <div>
                    익명여부
                    <input type="checkbox" id="board_anonymous" name="board_anonymous"
                           style="margin-left: 8%;">&nbsp;해당
                    게시글을 익명으로 작성합니다.
                </div>
                <hr>

                <div style="display: flex;">
                    내용
                    <textarea id="board_content" name="board_content"
                              style="margin-left: 10%">${board.board_content}</textarea>
                </div>
                <hr>

                <div>
                    파일
                    <input type="file" id="bd_file" name="bd_file" multiple style="margin-left: 10%">

                    <div id="file_upload_list">
                        <!-- 첨부 파일 있을 경우 출력 -->
                            <c:forEach var="file" items="${fileList}">
                                <p id="ori_file_list_${file.file_seq}" style="font-size: small; margin-left: 13%;">${file.file_name}
                                    <b style="display: none" id="file_${file.file_seq}">${file.file_seq}</b>
                                    <span> (${file.file_size}MB)</span>
                                    <a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(${file.file_seq})">삭제</a>
                                </p>
                            </c:forEach>
                    </div>
                </div>
                <hr>
            </div>
            <!-- 게시글 등록/수정 E -->

            <!-- 버튼 S -->
            <div style="float: right; margin-bottom: 5%;">
                <button class="update_btn" id="btn" type="submit">수정</button>
                <a href="/board/board_detail?board_seq=${searchVO.board_seq}&seq=${allCount}&page=${searchVO.page}&listSize=${searchVO.listSize}&type=${searchVO.type}&searchKeyword=${searchVO.searchKeyword}">
                    <button class="rollback_btn" type="button">취소</button>
                </a>
            </div>
            <!-- 버튼 E -->

        </div>

        <input type="hidden" value="${searchVO.page}" name="page" id="page"/>
        <input type="hidden" value="${searchVO.listSize}" name="listSize" id="listSize"/>
        <input type="hidden" value="${searchVO.type}" name="type" id="type"/>
        <input type="hidden" value="${searchVO.searchKeyword}" name="searchKeyword" id="searchKeyword"/>
        <input type="hidden" value="${file_num}" id="file_num"/>
        <input type="hidden" id="user_id" name="user_id" readonly value="${session}" >

    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    let file_list = new Array(); // 파일[]
    let delete_file_seq = new Array();

    let file_num =  $("#file_num").val(); // 파일 개수

    // 사이즈 변경
    const getByteSize = (size) => {
        const byteUnits = "MB";

        size = Math.floor((size / 1024) / 1024);
        return size + byteUnits;
    };

    // 파일 추가
    $("#bd_file").on('change', function () {
        let files = $("input[name=bd_file]")[0].files; // input file 태그 접근해서 파일 가져오기
        let file_arr = new Array();
        file_arr = file_list;

        let html = '';

        for (let i = 0; i < files.length; i++) {
            file_arr.push(files[i]);
        }

        $('.insert_file').remove(); // 기존 파일까지 전부 삭제되면 안되기 때문에, 새로운 id / class 값을 주고, 새로 파일이 추가될 때 해당 class 를 이용해서 추가된 파일에서 삭제가 가능하도록 진행

        for (let i = 0; i < file_arr.length; i++) {
            let file_size = getByteSize(file_arr[i].size);
            html += '<p id="file_list_' + i + '" class="insert_file" style="font-size: small; margin-left: 13%;">' + file_arr[i].name +
                '<b style="display: none" id="file_' + i + '"> ' + i +
                ' </b><span> (' + file_size + ') </span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="new_file_delete(\'' + i + '\')">삭제</a></p>';
        }

        file_list = new Array();
        file_list = file_arr;
        console.log(file_list);

        $('#file_upload_list').append(html);
        $("#bd_file").val(''); // 얘를 해줘야 똑같은 파일을 넣어도 들어감
    });

    // 기존 파일 삭제
    function file_delete(num) {
        console.log("file_delete num ? " + num);
        $("#ori_file_list_" + num).remove();

        delete_file_seq.push(num);
        console.log(delete_file_seq);
    }

    // 새로운 파일 삭제
    function new_file_delete(num){
        console.log("new_file_delete num ? " + num);
        $("#file_list_" + num).remove();

        let file_arr = file_list;
        file_arr.splice(num, 1);

        let key_num = 0;

        let html = '';
        file_list = new Array();

        $('.insert_file').remove();

        for (let i = 0; i < file_arr.length; i++) {
            let file_size = getByteSize(file_arr[i].size);
            html += '<p id="file_list_' + key_num + '"class="insert_file" style="font-size: small; margin-left: 13%;">' + file_arr[i].name +
                '<b style="display: none" id="file_' + key_num + '" > ' + key_num +
                ' </b><span> (' + file_size + ') </span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="new_file_delete(\'' + key_num + '\')">삭제</a></p>';

            key_num++;
            file_list.push(file_arr[i]);
        }

        $("#file_upload_list").append(html);
    }

    // 익명 여부 확인
    $("#board_anonymous").change(function(){
        if($("input[type=checkbox]:checked").val() == "on"){
            alert("익명의 경우, 게시글 수정이 불가합니다.");
        }
    })

    // 수정 버튼 클릭
    $("#btn").click(function () {
        if(confirm("게시글을 수정하시겠습니까?") == true) {

            // 익명 여부 확인
            let anonymous = $("input[type=checkbox]:checked").val();

            // 익명 체크했을 때
            if (anonymous == "on") {
                anonymous = 1;
            } else {
                anonymous = 0;
            }

            // FormData
            let formData = new FormData();

            formData.append("board_seq", $("#board_seq").val());
            formData.append("board_title", $("#board_title").val());
            formData.append("user_id", $("#user_id").val());
            formData.append("board_content", $("#board_content").val());
            formData.append("board_anonymous", anonymous);
            formData.append("page", $("#page").val());
            formData.append("listSize", $("#listSize").val());
            formData.append("type", $("#type").val());
            formData.append("searchKeyword", $("#searchKeyword").val());

            for(let i = 0; i < file_list.length; i++){
                formData.append("file", file_list[i]);
            }

            if(delete_file_seq.length == 0){ // 삭제할 파일의 길이가 0일 때 (없을 때)
                formData.append("delete_file", 0);
            }else{
                for(let i = 0; i < delete_file_seq.length; i++){ // 삭제할 파일 있을 때
                    formData.append("delete_file", delete_file_seq[i]);
                }
            }

            // formData - value 확인
            console.log("formData 확인");
            for(let value of formData.values()){
                console.log(value);
            }
            console.log("formData 끝");

            // 유효성 검사
            let blank_pattern = /^\s+|\s+$/g; // 공백 검사

            if ($("#board_title").val() == "") {
                alert("제목을 입력해주세요");
                $("#board_title").focus();
                return false;
            }

            if ($("#board_content").val() == "") {
                alert("내용을 입력해주세요");
                $("#board_content").focus();
                return false;
            }

            $.ajax({
                url: "/board/board_updateAction",
                processData: false,
                contentType: false,
                enctype: "multipart/form-data",
                data: formData,
                type: "post",
                success: function(result) {
                    location.href ="/board/board_detail?board_seq=${searchVO.board_seq}&page=${searchVO.page}" +
                        "&listSize=${searchVO.listSize}" +
                        "&type=${searchVO.type}" +
                        "&searchKeyword=${searchVO.searchKeyword}";
                },
                error: function(error) {
                    alert("게시글 수정, 서버 통신 실패");
                    return false;
                }
            });
            return false;

        }else{
            return false;
        }

    });

</script>

</body>
</html>