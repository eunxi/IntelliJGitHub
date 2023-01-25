package com.eunxi.board.service;

import lombok.Getter;
import lombok.Setter;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

// 페이징에 맞게 사용될 변수들 선언 <- Pagination을 받아줄 변수
// 여기서 현재 페이지 수, 페이지 개수 페이지 사이즈 등 default 값으로 지정
@Setter
@Getter
public class PageVO {
    private int pageIndex = 1;				    //현재페이지
    private int pageUnit = 10;				    //페이지갯수
    private int pageSize = 10;	    			//페이지사이즈
    private int firstIndex = 1;		    		//firstIndex - sql 에서 사용
    private int recordCountPerPage = 10;		//recordCountPerPage - sql 에서 사용
    private int totCnt = 0;				      	//총갯수
    private int startDate = 0;			    	//시작데이터
    private int endDate = 0;				    //종료데이터
    private int realEnd = 0;				    //페이징 마지막 숫자

    private boolean prev, next;	    			//이전, 다음버튼

    private String type; // 검색 타입 - 제목, 내용, 작성자 등 어떤 주제로 검색
//    private String[] typeArr; // 검색 타입 배열 변환 - 제목+내용, 제목+작성자, 제목+내용+작성자 경우


    // 쿼리스트링 변수 만들어주기 - 해당 페이지에 머물 수 있도록
    // 검색 키워드, 페이지 인덱스 필요

    private String searchKeyword = ""; // 검색어
    private String queryString = ""; // 쿼리스트링

    public void setQueryString() throws UnsupportedEncodingException {
        String qs = "";
        qs += "&searchKeyword="+ URLEncoder.encode(this.searchKeyword, "UTF-8"); // 문자열이 들어가는 searchKeyword 는 인코딩 처리
        qs += "&pageIndex="+this.pageIndex; // 페이지 인덱스
        qs += "&type=" + this.type; // 검색 분류

        this.queryString = qs;

    }

//    public void setType(String type){
//        this.type = type;
//        this.typeArr = type.split(""); // type 변수에 데이터가 들어왔을 때 자동으로 배열 형식으로 변환하여 저장할 수 있도록 split 사용
//    }

}
