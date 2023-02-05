package com.eunxi.spring.reply.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReplyServiceImpl implements ReplyService{
    @Autowired
    private ReplyDAO replyDao;

    @Override
    public List<ReplyVO> replyList(Map<String, Object> map) {
        return replyDao.replyList(map);
    }

    @Override
    public void replyInsert(ReplyVO vo) {
        replyDao.replyInsert(vo);
    }

    @Override
    public void replyUpdate(ReplyVO vo) {
        replyDao.replyUpdate(vo);
    }

    @Override
    public void replyDelete(int r_seq) {
        replyDao.replyDelete(r_seq);
    }

    @Override
    public int replyTotal(int b_num) {
        return replyDao.replyTotal(b_num);
    }
}
