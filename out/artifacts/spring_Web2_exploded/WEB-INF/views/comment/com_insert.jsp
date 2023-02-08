<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <title>답글 작성</title>
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
    <form action="/comment/com_insertAction" method="post" enctype="multipart/form-data">
        <div class="col-2"></div>

        <div class="col-8" style="height: 50%;">
            <div>
                <h3>답글 작성</h3>
            </div>

            <!-- 답글 작성 S -->
            <div>
                <hr>
                <div>
                    제목
                    <input type="text" id="board_title" name="board_title" style="width: 80%; margin-left: 10%">
                </div>

                <hr>
                <div>
                    작성자
                    <input type="text" id="user_id" name="user_id" disabled style="width: 20%; margin-left: 9%;">
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
                    <input style="margin-left: 10%;" type="file" id="c_file_select" multiple name="c_file">

                    <div id="c_file_upload_form">

                    </div>
                </div>
                <hr>

            </div>
            <!-- 답글 작성 E -->

            <!-- 버튼 S -->
            <div class="buttons" style="float: right; margin-bottom: 5%;">
                <button class="insert_btn" id="btn" type="submit">등록</button>
                <button class="cancel_btn" type="button" onclick="javascript:history.back();">취소</button>
            </div>
            <!-- 버튼 E -->

        </div>

        <div class="input_tag">
            <input type="hidden" value="${board.root}" id="root" name="root"/>
            <input type="hidden" value="${board.step}" id="step" name="step"/>
            <input type="hidden" value="${board.indent}" id="indent" name="indent"/>
        </div>

    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

    // 파일
    let file_list = new Array();
    console.log(file_list);

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

        console.log(file_list);

        $("#c_file_upload_form").empty();

        for(let i = 0; i < file_list.length; i++){
            let file_size = getByteSize(file_list[i].size); // 파일 사이즈

            html += '<p id="file_name_'+i+'" style="font-size: small; margin-left: 13%;">' + file_list[i].name +
                    '<b id="file_'+i+'" style="display: none;">' + i +
                    '</b> <span>(' + file_size + ')</span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(\'' + i + '\')">삭제</a></p>';
        }

        $("#c_file_upload_form").append(html);

        $("#c_file_select").val('');
    })

    // 파일 삭제
    function file_delete(num){
        $("#file_name_" + num).remove();

        file_list.splice(num, 1);

        let html = '';

        $("#c_file_upload_form").empty();

        for(let i = 0; i < file_list.length; i++){
            let file_size = getByteSize(file_list[i].size); // 파일 사이즈

            html += '<p id="file_name_' + i +'" style="font-size: small; margin-left: 13%;">' + file_list[i].name +
                '<b id="file_'+i+'" >' + i +
                '</b> <span>(' + file_size + ')</span><a style="margin-left: 1%;" href="#this" name="file-delete" onclick="file_delete(\'' + i + '\')">삭제</a></p>';
        }

        $("#c_file_upload_form").append(html);

        console.log(file_list);
    }

    // 답글 작성 버튼
    $(".insert_btn").click(function(){
        // 익명 여부
        let anonymous = $("input[type=checkbox]:checked").val();

        if(anonymous == 1){
            anonymous = "true";
            alert("익명의 경우, 수정이 불가능합니다.");
        }else{
            anonymous = "false";
        }

        // formData
        let formData = new FormData();

        for(let i = 0; i < file_list.length; i++){
            formData.append("file", file_list[i]);
        }

        formData.append("board_title" , $("#board_title").val());
        formData.append("user_id" , $("#user_id").val());
        formData.append("board_anonymous" , anonymous);
        formData.append("board_content" , $("#board_content").val());
        formData.append("root" , $("#root").val());
        formData.append("step" , $("#step").val());
        formData.append("indent" , $("#indent").val());

        // formData 확인
        for(let value of formData.values()) {
            console.log(value);
        }

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

        // ajax
        $.ajax({
            url: '/comment/com_insertAction',
            processData: false,
            contentType: false,
            enctype: 'multipart/form-data',
            data: formData,
            type: 'post',
            success: function(result){
                // 답글 작성한 화면으로 이동할 수 있도록
                location.href = '/board/board_list';

                /*location.href = "/board/board_detail?board_seq=${board.board_seq}&page=${vo.page}" +
                    "&listSize=${vo.listSize}" +
                    "&type=${vo.type}" +
                    "&searchKeyword=${vo.searchKeyword}";*/
            },
            error: function (error) {
                alert("실패!");
                return false;
            }
        });
        return false;

    })







































</script>

</body>
</html>