package com.eunxi.spring.board.service;

import java.util.List;

public interface BoardService {
    List<BoardVO> getBoardList(BoardVO vo); // 목록
    BoardVO getBoard(int board_seq); // 상세화면
    int getBoardListCnt(BoardVO vo); // 전체 글 개수
    int getBoardSeq(BoardVO vo); // 게시글 번호

    void boardInsert(BoardVO vo); // 등록
    void boardUpdate(BoardVO vo); // 수정
    void boardDelete(int board_seq); // 삭제
    void getBoardCnt(int board_seq); // 조회수

    void board_com_insert(BoardVO vo); // 답글 등록
    void board_com_update(BoardVO vo); // 답글 step 업데이트


}
