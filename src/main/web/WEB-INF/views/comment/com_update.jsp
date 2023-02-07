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
    <form action="/comment/com_insertAction" id="insert_form" method="post" enctype="multipart/form-data">
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








































</script>

</body>
</html>