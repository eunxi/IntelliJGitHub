package com.eunxi.spring.commons.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {
    // 현재페이지, 시작페이지, 끝페이지, 게시글 총 개수, 페이지당 글 개수, 마지막페이지, sql 쿼리에 사용할 start, end
    private int nowPage, startPage, endPage, total, cntPerPage, lastPage, start, end;
    private boolean prev, next;
    private int cntPage = 5;
    private String keyword, type; // 검색 키워드, 검색 타입

    public Criteria() {
    }

    public Criteria(int total, int nowPage, int cntPerPage) {

        if(startPage == 0){
            startPage = 1;
        }

        this.total = total;
        this.nowPage = nowPage;
        this.cntPerPage = cntPerPage;

        this.endPage = (int)Math.ceil(nowPage / 5.0) * cntPage;
        this.startPage = this.endPage - 4;

        int realEnd = (int)Math.ceil(total * 1.0 / cntPerPage);
        if(realEnd < this.endPage){
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;

//        setNowPage(nowPage);
//        setCntPerPage(cntPerPage);
//        setTotal(total);
//        calcLastPage(getTotal(), getCntPerPage());
//        calcStartEndPage(getNowPage(), cntPage);
        calcStartEnd(getNowPage(), getCntPerPage());
    }

    // 제일 마지막 페이지 계산
    public void calcLastPage(int total, int cntPerPage) {
        setLastPage((int) Math.ceil((double)total / (double)cntPerPage));
    }

    // 시작, 끝 페이지 계산
    public void calcStartEndPage(int nowPage, int cntPage) {
        setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
        if (getLastPage() < getEndPage()) {
            setEndPage(getLastPage());
        }
        setStartPage(getEndPage() - cntPage + 1);
        if (getStartPage() < 1) {
            setStartPage(1);
        }
    }

    // DB 쿼리에서 사용할 start, end값 계산
    public void calcStartEnd(int nowPage, int cntPerPage) {
        setEnd(nowPage * cntPerPage);
        setStart(getEnd() - cntPerPage + 1);
    }

}
