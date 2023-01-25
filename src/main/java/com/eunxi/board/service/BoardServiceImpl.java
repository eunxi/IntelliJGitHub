package com.eunxi.board.service;

import com.eunxi.board.controller.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{
    @Autowired
    private BoardDAO boardDao;

    @Override
    public List<BoardVO> getBoardList(BoardVO vo) {
        if(vo.getPage() == 0){
            vo.setPage(1);
        }

        return boardDao.getBoardList(vo);
    }

    @Override
    public void boardInsert(BoardVO vo) {
        boardDao.boardInsert(vo);
    }

    @Override
    public BoardVO getBoard(int board_seq) {
        return boardDao.getBoard(board_seq);
    }

    @Override
    public void boardUpdate(BoardVO vo) {
        boardDao.boardUpdate(vo);
    }

    @Override
    public void boardDelete(int board_seq) {
        boardDao.boardDelete(board_seq);
    }

    @Override
    public int getBoardListCnt(BoardVO vo) {
        return boardDao.getBoardListCnt(vo);
    }

    @Override
    public void getBoardCnt(int board_seq) {
        boardDao.getBoardCnt(board_seq);
    }
}
