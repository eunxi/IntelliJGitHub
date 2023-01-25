package com.eunxi.board.service;

import com.eunxi.board.controller.Criteria;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class Pagination {
    public static PageInfo getInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {

        int maxPage = (int)Math.ceil((double)listCount/boardLimit);
        int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;
        if(endPage > maxPage) {
            endPage = maxPage;
        }

        return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);

    }
}