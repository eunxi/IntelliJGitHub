package com.eunxi.spring.file.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Setter
@Getter
@ToString
public class FileVO {
    private int file_seq; // 파일 번호 - 시퀀스
    private String tbl_type; // 게시글 타입 ex) B: 게시판, N: 공지사항 등
    private int b_num; // 게시글 번호 - 연결시켜서 찾아야하므로
    private int division_num; // 순번 - 게시글 번호에 따라 다르게 증가해야하는 값
    private String file_path; // 파일 경로
    private String file_name; // 파일 이름
    private String file_saveName; // 파일 저장 이름

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date file_date; // 파일 업로드 날짜
    private int file_downCnt; // 파일 다운로드 횟수
    private int file_size; // 파일 사이즈
    private String file_state; // 파일 상태


}
