package com.eunxi.spring.board.service;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class BoardDAO {
    @Autowired
    private SqlSessionTemplate session;

    // 목록 - offset 같이 처리해줘서 페이징 넘기기(뺏겨)
    // RowBounds : 마이바티스로 하여금 특정 개수만큼의 레코드 건너띄게 함
    public List<BoardVO> getBoardList(BoardVO vo){
        int limit = vo.getListSize();
        int offset = ( vo.getPage() - 1 ) * limit;

        RowBounds rowBounds = new RowBounds(offset, limit);

        return session.selectList("boardDao.getBoardList", vo, rowBounds);
    }

    // 등록
    public void boardInsert(BoardVO vo){

        session.insert("boardDao.boardInsert", vo);
    }

    // 상세 화면
    public BoardVO getBoard(int board_seq){
        return session.selectOne("boardDao.getBoard", board_seq);
    }

    // 수정
    public void boardUpdate(BoardVO vo){
        session.update("boardDao.boardUpdate", vo);
    }

    // 삭제
    public void boardDelete(BoardVO vo){
        session.delete("boardDao.boardDelete", vo);
    }

    // 글 개수
    public int getBoardListCnt(BoardVO vo){
        return session.selectOne("boardDao.getBoardListCnt", vo);
    }

    // 조회수
    public void getBoardCnt(int board_seq){
        session.update("boardDao.getBoardCnt", board_seq);
    }

    // 게시글 번호 가져오기
    public int getBoardSeq(BoardVO vo){

        return session.selectOne("boardDao.getBoardSeq", vo);
    }

    // 답글 등록
    public void board_com_insert(BoardVO vo){
        session.insert("boardDao.board_com_insert", vo);
    }

    // 답글 step 업데이트
    public void board_com_update(BoardVO vo){
        session.update("boardDao.board_com_update", vo);
    }


}
