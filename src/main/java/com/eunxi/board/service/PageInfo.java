package com.eunxi.board.service;

// 페이지 관련 메소드
public class PageInfo {
    private int listCount;
    private int currentPage;
    private int pageLimit;
    private int boardLimit;
    private int maxPage;
    private int startPage;
    private int endPage;

    public PageInfo() {}

    public PageInfo(int listCount, int currentPage, int pageLimit, int boardLimit, int maxPage, int startPage, int endPage) {
        super();
        this.listCount = listCount; // 전체 글 개수
        this.currentPage = currentPage; // 현재 페이지
        this.pageLimit = pageLimit; // 하단 페이지 출력 개수
        this.boardLimit = boardLimit; // 출력되는 게시글
        this.maxPage = maxPage; // 총 페이지 수
        this.startPage = startPage; // 시작 페이지
        this.endPage = endPage; // 마지막 페이지
    }

    public int getListCount() {
        return listCount;
    }

    public void setListCount(int listCount) {
        this.listCount = listCount;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageLimit() {
        return pageLimit;
    }

    public void setPageLimit(int pageLimit) {
        this.pageLimit = pageLimit;
    }

    public int getBoardLimit() {
        return boardLimit;
    }

    public void setBoardLimit(int boardLimit) {
        this.boardLimit = boardLimit;
    }

    public int getMaxPage() {
        return maxPage;
    }

    public void setMaxPage(int maxPage) {
        this.maxPage = maxPage;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    @Override
    public String toString() {
        return "PageInfo [listCount=" + listCount + ", currentPage=" + currentPage + ", pageLimit=" + pageLimit
                + ", boardLimit=" + boardLimit + ", maxPage=" + maxPage + ", startPage=" + startPage + ", endPage="
                + endPage + "]";
    }

}
