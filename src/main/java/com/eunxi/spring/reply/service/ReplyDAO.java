package com.eunxi.spring.reply.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ReplyDAO {
    @Autowired
    private SqlSessionTemplate session;

    // 댓글 목록
    public List<ReplyVO> replyList(Map<String, Object> map){
        return session.selectList("replyDao.replyList", map);
    }

    // 댓글 작성
    public void replyInsert(ReplyVO vo){
        session.insert("replyDao.replyInsert", vo);
    }

    // 댓글 수정
    public void replyUpdate(ReplyVO vo){
        session.update("replyDao.replyUpdate", vo);
    }

    // 댓글 삭제
    public void replyDelete(ReplyVO vo){
        session.delete("replyDao.replyDelete", vo);
    }

    // 댓글 개수
    public int replyTotal(int b_num){
        return session.selectOne("replyDao.replyTotal" , b_num);
    }

}
