package com.eunxi.board.controller;

import org.springframework.web.util.UriComponentsBuilder;

public class Criteria {
    private int page;
    private int perPageNum;

    public Criteria() {
        this.page = 1;
        this.perPageNum = 10;
    }

    // sql문에 있는 limit의 시작데이터인 pageStart를 반환
    public int getPageStart() {
        return (this.page - 1)*perPageNum;
    }

    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        }else {
            this.page = page;
        }
    }

    // sql문에 있는 Offset 데이터인 perPageNum을 반환
    public int getPerPageNum() {
        return perPageNum;
    }
    public void setPerPageNum(int perPageNum) {
        if(perPageNum <=0 || perPageNum > 100) {
            this.perPageNum = 10;
        }else {
            this.perPageNum = perPageNum;
        }
    }

    // listPage.jsp 구현할 때 많이 사용
    public String makeQuery() {
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", this.perPageNum)
                .build().encode().toString();
    }

    @Override
    public String toString() {
        return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
    }
}
