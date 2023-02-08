<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <title>답글 수정</title>
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

        .cancel_btn {
            font-size: 18px;
            border: none;
            background-color: red;
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
    <form action="/comment/com_updateAction" method="post" enctype="multipart/form-data">
        <div class="col-2"></div>

        <div class="col-8" style="height: 50%;">
            <div>
                <h3>답글 수정</h3>
            </div>

            <!-- 답글 수정 S -->
            <div>
                <hr>
                <div>
                    제목
                    <input type="text" value="${board.board_title}" id="board_title" name="board_title" style="width: 80%; margin-left: 10%">
                </div>

                <hr>
                <div>
                    작성자
                    <input type="text" value="${board.user_id}" readonly id="user_id" name="user_id" disabled style="width: 20%; margin-left: 9%;">
                </div>
                <hr>

                <div>
                    익명여부
                    <input type="checkbox" value="1" id="board_anonymous" name="board_anonymous" style="margin-left: 8%;">&nbsp;해당 게시글을 익명으로 작성합니다.
                </div>
                <hr>

                <div style="display: flex;">
                    내용
                    <textarea id="board_content" name="board_content" style="margin-left: 10%">${board.board_content}</textarea>
                </div>
                <hr>

                <div id="file-list">
                    파일
                    <input style="margin-left: 10%;" type="file" id="c_file_select" multiple name="c_file">

                    <div id="c_file_upload_form">
                        <!-- 첨부 파일 존재 -->
                        <c:forEach var="f" items="${file_list}">
                            <p id="original_${f.file_seq}" style="font-size: small; margin-left: 13%;">
                                ${f.file_name}
                                <b id="f_${f.file_seq}">${f.file_seq}</b>
                                <span> (${f.file_size}MB)</span>
                                <a style="margin-left: 1%;" href="#this" onclick="f_del(${f.file_seq})">삭제</a>
                            </p>
                        </c:forEach>

                    </div>
                </div>
                <hr>

            </div>
            <!-- 답글 수정 E -->

            <!-- 버튼 S -->
            <div class="buttons" style="float: right; margin-bottom: 5%;">
                <button class="insert_btn" id="c_btn" type="button">등록</button>
                <button class="cancel_btn" type="button" onclick="javascript:history.back();">취소</button>
            </div>
            <!-- 버튼 E -->
        </div>

        <div class="input_tag">
            <input type="hidden" value="${board.board_seq}" id="board_seq" name="board_seq"/>
            <input type="hidden" value="${board.root}" id="root" name="root"/>
            <input type="hidden" value="${board.step}" id="step" name="step"/>
            <input type="hidden" value="${board.indent}" id="indent" name="indent"/>

            <input type="hidden" value="${page}" id="page" name="page" />
            <input type="hidden" value="${listSize}" id="listSize" name="listSize" />
            <input type="hidden" value="${type}" id="type" name="type" />
            <input type="hidden" value="${searchKeyword}" id="searchKeyword" name="searchKeyword" />
        </div>

    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    let del_file = new Array(); // 기존 파일[]
    let file_list = new Array(); // 추가 파일[]

    // 사이즈 변경
    const getByteSize = (size) => {
        const byteUnits = "MB";

        size = Math.floor((size / 1024) / 1024);
        return size + byteUnits;
    };

    // 파일 추가
    $("#c_file_select").change(function(){
        let files = $("input[name=c_file]")[0].files;
        let html = '';

        for(let i = 0; i < files.length; i++){
            file_list.push(files[i]);
        }

        $(".new_file").remove();

        for(let i = 0; i < file_list.length; i++){
            let file_size = getByteSize(file_list[i].size);
            html += '<p class="new_file" id="new_' + i + '" style="font-size: small; margin-left: 13%;">' + file_list[i].name +
                    '<b id="f_' + i + '">' + i + '</b><span> (' + file_size + ') </span>' +
                    '<a style="margin-left: 1%;" href="#this" onclick="f_new_del(' + i + ')">삭제</a></p>' ;
        }

        $("#c_file_upload_form").append(html);
        $("#c_file_select").val('');

        console.log(file_list);

    })

    // 추가 파일 삭제
    function f_new_del(num){
        $("#new_" + num).remove();

        let html = '';
        file_list.splice(num, 1); // 제거 파일 -> 남은 파일은 file_list 에 담겨있음!

        $(".new_file").remove();

        for(let i = 0; i < file_list.length; i++){
            let file_size = getByteSize(file_list[i].size);
            html += '<p class="new_file" id="new_' + i + '" style="font-size: small; margin-left: 13%;">' + file_list[i].name +
                    '<b id="f_' + i + '">' + i + '</b><span> (' + file_size + ') </span>' +
                    '<a style="margin-left: 1%;" href="#this" onclick="f_new_del(' + i + ')">삭제</a></p>';

        }

        $("#c_file_upload_form").append(html);
    }

    // 기존 파일 삭제
    function f_del(num){
        $("#original_" + num).remove();

        del_file.push(num); // 삭제할 파일 seq 넣어서, server 넘겨주기
        console.log(del_file);
    }

    // 등록 버튼 클릭
    $("#c_btn").click(function(){
        // 익명 - 체크1, 빈칸undefined
        let anonymous = $("input[type=checkbox]:checked").val();

        if(anonymous == 1){
            anonymous = "true";
        }else{
            anonymous = "false";
        }

        // 제목, 내용 유효성 검사
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

        // formData
        let formData = new FormData();

        // 삭제할 파일 유무에 따라 다르게 진행(오류)
        if(del_file.length == 0){
            formData.append("del_file", 0);
        }else{
            for(let i = 0; i < del_file.length; i++){
                formData.append("del_file", del_file[i]);
            }
        }

        // 추가할 파일
        for(let i = 0; i < file_list.length; i++){
            formData.append("file", file_list[i]);
        }

        formData.append("board_seq", $("#board_seq").val());
        formData.append("board_title", $("#board_title").val());
        formData.append("user_id", $("#user_id").val());
        formData.append("board_content", $("#board_content").val());
        formData.append("board_anonymous", anonymous);
        formData.append("page", $("#page").val());
        formData.append("listSize", $("#listSize").val());
        formData.append("type", $("#type").val());
        formData.append("searchKeyword", $("#searchKeyword").val());
        formData.append("root", $("#root").val());
        formData.append("step", $("#step").val());
        formData.append("indent", $("#indent").val());

        for(let value of formData.values()){
            console.log(value);
        }

        $.ajax({
            url: '/comment/com_updateAction',
            type: 'post',
            processData: false,
            contentType: false,
            enctype: 'multipart/form-data',
            data: formData,
            success: function(result){
                location.href = "/board/board_detail?board_seq=${board.board_seq}&page=${page}&listSize=${listSize}&type=${type}&searchKeyword=${searchKeyword}";
            },
            error: function (error) {
                alert("수정 등록 실패");
                return false;
            }
        });

    })








































</script>

</body>
</html>