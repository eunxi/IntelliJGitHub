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
<body onload="javascript:test();">
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
                    <input type="text" id="board_title" name="board_title" value="${board.board_title}"
                           style="width: 80%; margin-left: 10%">
                </div>

                <hr>
                <div>
                    작성자
                    <input type="text" id="user_id" name="user_id" disabled value="${board.user_id}"
                           style="width: 20%; margin-left: 9%;">
                </div>
                <hr>

                <div>
                    익명여부
                    <input type="checkbox" value="${board.board_anonymous}" id="board_anonymous" name="board_anonymous"
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

                    <div id="original_file">
                        <c:if test="${not empty fileList}">
                            <c:forEach var="file" items="${fileList}">
                                <p id="file_list_${file.order_seq}" style="font-size: small; margin-left: 13%;">${file.file_name}
                                    <b id="file_${file.order_seq}">${file.order_seq -1}</b>
                                    <span> (size)</span>
                                    <a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(${file.order_seq})">삭제</a>
                                </p>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="file_upload_list">

                    </div>
                </div>
                <hr>
            </div>

            <!-- 버튼 -->
            <div style="float: right; margin-bottom: 5%;">
                <button class="update_btn" id="btn" type="submit">수정</button>
                <a href="/board/board_detail?board_seq=${searchVO.board_seq}&seq=${allCount}&page=${searchVO.page}&listSize=${searchVO.listSize}&type=${searchVO.type}&searchKeyword=${searchVO.searchKeyword}">
                    <button class="rollback_btn" type="button">취소</button>
                </a>
            </div>

        </div>

        <input type="hidden" value="${searchVO.page}" name="page" id="page"/>
        <input type="hidden" value="${searchVO.listSize}" name="listSize" id="listSize"/>
        <input type="hidden" value="${searchVO.type}" name="type" id="type"/>
        <input type="hidden" value="${searchVO.searchKeyword}" name="searchKeyword" id="searchKeyword"/>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    // 파일[] 배열
    let file_list = new Array();

    // 사이즈 변경
    const getByteSize = (size) => {
        const byteUnits = ["KB", "MB", "GB", "TB"];

        for (let i = 0; i < byteUnits.length; i++) {
            size = Math.floor(size / 1024);

            if (size < 1024) return size.toFixed() + byteUnits[i];
        }
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

        $('#file_upload_list').empty();

        for (let i = 0; i < file_arr.length; i++) {
            let file_size = getByteSize(file_arr[i].size);
            <%--html += '<c:if test="${not empty fileList}"><c:forEach var="file" items="${fileList}">' + file_arr[i].name + '</c:forEach></c:if>';--%>
            html += '<p id="file_list_' + i + '" style="font-size: small; margin-left: 13%;">' + file_arr[i].name +
                '<b id="file_' + i + '">' + i +
                '</b><span> (' + file_size + ') </span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(\'' + i + '\')">삭제</a></p>';
        }

        file_list = new Array();
        file_list = file_arr;
        console.log(file_list);

        $('#file_upload_list').append(html);
        $("#bd_file").val(''); // 얘를 해줘야 똑같은 파일을 넣어도 들어감
    });

    // 파일 삭제
    function file_delete(num) {
        $("#file_list_" + num).remove();

        let file_arr = file_list;
        console.log("여기에서 뜨나용??");
        console.log(file_arr);
        file_arr.splice(num, 1);

        let key_num = 0; // 리스트 개수 다시 세기
        let html = '';
        file_list = new Array();

        $("#file_upload_list").empty();

        for (let i = 0; i < file_arr.length; i++) {
            let file_size = getByteSize(file_arr[i].size);
            html += '<p id="file_list_' + key_num + '" style="font-size: small; margin-left: 13%;">' + file_arr[i].name +
                '<b id="file_' + key_num + '" >' + key_num +
                '</b><span> (' + file_size + ') </span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(\'' + key_num + '\')">삭제</a></p>';

            key_num++;
            file_list.push(file_arr[i]);
            console.log("key_num : " + key_num);
        }

        $("#file_upload_list").append(html);
    }

    // 익명 체크 값 유지
    function test() {
        $("input[name='board_anonymous']").each(function () {
            let check_value = $(this).val();

            if (check_value == "true") {
                $(this).attr("checked", true);
            }
        })
    }

    // 수정 버튼 클릭
    $("#btn").click(function () {
        // 익명 여부 확인
        let anonymous = $("input[type=checkbox]:checked").val();

        if (anonymous == "on") {
            anonymous = 1;
        } else {
            anonymous = 0;
        }

        // FormData
        let formData = new FormData();

        for(let i = 0; i < file_list.length; i++){
            formData.append("file", file_list[i]);
        }

        // formData - value 확인
        for(let value of formData.values()){
            console.log(value);
        }

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
                alert("성공!!");
            },
            error: function(error) {
                alert("실패!!");
                return false;
            }
        });
        return false;

    });

    function checkUpdate() {
        if (!confirm("수정하시겠습니까?")) {
            // 취소(아니오) 버튼 클릭 시 이벤트 발생
            return false;
        } else {
            alert("수정 성공!");
        }
    }

</script>

</body>
</html>