package com.eunxi.spring.board.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.xml.bind.annotation.XmlTransient;
import java.util.Date;

@Setter
@Getter
@ToString
// BoardVO에 extends하고 PageVO 선언하여 사용 가능하도록 진행
public class BoardVO {
    // DB
    private int no; // sql문에서 rownum을 같이 하나로 넘겨주는거니깐, 얘도 함께 넘겨줘야함!!!!
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

    // 검색
    private String searchKeyword = ""; // 어떤 검색어
    private String type = ""; // 어떤 주제

}
