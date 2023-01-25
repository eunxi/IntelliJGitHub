package com.eunxi.board.service;

// 파라미터를 통해 페이징 처리를 하기 위해 클래스를 만들어 변수 생성 후 파라미터 지정
public class PaginationSample {
    private int currentPageNo;			//현재 페이지 번호
    private int recordCountPerPage;		//한 페이지당 게시되는 게시물 수
    private int pageSize;				//페이지 리스트에 게시되는 페이지 수
    private int totalRecordCount;		//전체 게시물 수
    private int realEnd;				//페이징 마지막 숫자

    public int getCurrentPageNo() {
        return currentPageNo;
    }
    public void setCurrentPageNo(int currentPageNo) {
        this.currentPageNo = currentPageNo;
    }
    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }
    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public int getTotalRecordCount() {
        return totalRecordCount;
    }
    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }

    private int firstPageNoOnPageList;	//페이지 리스트의 첫 페이지 번호
    private int lastPageNoOnPageList;	//페이지 리스트의 마지막 페이지 번호
    private int firstRecordIndex; 		//페이징 sql의 조건절에 사용되는 시작 rownum

    private boolean xprev;		//이전버튼
    private boolean xnext;		//다음버튼

    /**
     *  firstPageNoOnPageList (페이지 리스트의 첫 페이지 번호)
     *  마지막 페이지 번호를 선언 후,
     *  현재 페이지 번호에서 10.0을 나눈 뒤 10 곱해주기, 마지막 페이지에서 -9 해줄 경우 첫번째 페이지 번호 출력
     */
    public int getFirstPageNoOnPageList() {
        lastPageNoOnPageList = (int)(Math.ceil(currentPageNo/10.0)) * 10;

        firstPageNoOnPageList = lastPageNoOnPageList - 9;
        return firstPageNoOnPageList;
    }

    public void setFirstPageNoOnPageList(int firstPageNoOnPageList) {
        this.firstPageNoOnPageList = firstPageNoOnPageList;
    }

    /**
     *  lastPageNoOnPageList (페이지 리스트의 마지막 페이지 번호)
     *  현제 페이지 번호 10 이하일 경우, realEnd 변수에 다시 계산
     *  realEnd는 전체 게시물 * 1.0 / 한페이지당 게시되는 게시물 수
     *  realEnd 변수가 마지막 페이지 번호보다 작을 경우, 마지막 페이지 번호와 동일하게 진행
     */
    public int getLastPageNoOnPageList() {
        lastPageNoOnPageList = (int)(Math.ceil(getCurrentPageNo()/10.0)) * 10;

        int realEnd = (int)(Math.ceil((getTotalRecordCount() * 1.0) / getRecordCountPerPage()));


        if(realEnd < lastPageNoOnPageList) {
            lastPageNoOnPageList = realEnd;
        }

        return lastPageNoOnPageList;
    }

    public void setLastPageNoOnPageList(int lastPageNoOnPageList) {
        this.lastPageNoOnPageList = lastPageNoOnPageList;
    }

    /**
     * firstRecordIndex (페이지 sql의 조건절에 사용되는 시작 rownumber)
     * (현재 페이지 - 1) * 한 페이지당 게시되는 게시물 수
     */
    public int getFirstRecordIndex() {
        firstRecordIndex = (getCurrentPageNo() - 1) * getRecordCountPerPage();
        return firstRecordIndex;
    }

    public void setFirstRecordIndex(int firstRecordIndex) {
        this.firstRecordIndex = firstRecordIndex;
    }

    /**
     * xprev(이전 버튼)
     * 리스트의 첫 페이지 번호가 1보다 크면 출력
     */
    public boolean getXprev() {
        xprev= getFirstPageNoOnPageList() > 1;
        return xprev;
    }

    public void setXprev(boolean xprev) {
        this.xprev = xprev;
    }

    /**
     * xnext(다음 버튼)
     * realEnd 구해서 리스트의 마지막 페이지 번호보다 크면 다음 버튼 출력
     * if(getLastPageNoOnPageList 결과값 < realEnd) = 다음 버튼 생성
     */
    public boolean getXnext() {

        int realEnd = (int)(Math.ceil((getTotalRecordCount() * 1.0) / getRecordCountPerPage()));

        xnext = getLastPageNoOnPageList() < realEnd;
        return xnext;
    }

    public void setXnext(boolean xnext) {
        this.xnext = xnext;
    }

    /**
     * realEnd (페이징 마지막 숫자)
     */
    public int getRealEnd() {

        realEnd = (int)(Math.ceil((getTotalRecordCount() * 1.0) / getRecordCountPerPage()));

        return realEnd;
    }
    public void setRealEnd(int realEnd) {
        this.realEnd = realEnd;
    }
}
