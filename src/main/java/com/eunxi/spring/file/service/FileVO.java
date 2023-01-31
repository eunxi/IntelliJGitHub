package com.eunxi.spring.file.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.xml.bind.annotation.XmlTransient;
import java.util.Date;
import java.util.List;

@Setter
@Getter
@ToString
public class FileVO {
    private int file_seq; // 파일 번호 - 시퀀스
    private String tbl_type; // 게시글 타입 ex) B: 게시판, N: 공지사항 등
    private int seq; // 게시글 번호 - 연결시켜서 찾아야하므로
    private int order_seq; // 순번 - 게시글 번호에 따라 다르게 증가해야하는 값
    private String file_path; // 파일 경로
    private String file_name; // 파일 이름

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date file_date; // 파일 업로드 날짜
    private int file_downCnt; // 파일 다운로드 횟수
}
