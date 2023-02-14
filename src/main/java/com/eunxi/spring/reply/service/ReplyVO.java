package com.eunxi.spring.reply.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Setter
@Getter
@ToString
public class ReplyVO {
    private int r_seq; // 댓글 번호
    private int b_num; // 게시글 번호
    private String tbl_type; // 게시판 타입 - 현재는 B
    private String user_id; // 사용자
    private String r_content; // 댓글 내용
    private String r_state; // 댓글 상태

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date r_date; // 댓글 작성 날짜

    // 페이징
    private int r_page = 1;
    private int r_amount;
    private int startPage;
}
