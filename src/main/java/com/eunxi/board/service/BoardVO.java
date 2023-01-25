package com.eunxi.board.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.UnsupportedEncodingException;
import java.util.Date;

@Setter
@Getter
@ToString
// BoardVO에 extends하고 PageVO 선언하여 사용 가능하도록 진행
public class BoardVO extends PageVO{
    private int board_seq;
    private String user_id;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date board_date;
    private int board_cnt;
    private String board_title;
    private String board_content;
    private boolean board_anonymous; // 익명 여부

    // 페이징
    private int page;
//    private int startList = 1; // 시작 페이지
//    private int listSize = 10;  // 한 페이지에 보여줄 레코드 수
    private int startList; // 시작 페이지
    private int listSize;  // 한 페이지에 보여줄 레코드 수
//    private int perPageNum; // 목록에 따라 변할 페이지 수

    // 검색
    private String title;
    private String id;
    private String content;
    private String searchKeyword;

    private String query;

    // 키워드 & 현재페이지 값 지정
    public void setQuery() throws UnsupportedEncodingException {

        String qs = "";
        this.setQueryString();
        qs += this.getQueryString();
        this.query = qs;
    }

//    public void setPerPageNum(int perPageNum){
//        this.perPageNum = perPageNum;
//    }

}
