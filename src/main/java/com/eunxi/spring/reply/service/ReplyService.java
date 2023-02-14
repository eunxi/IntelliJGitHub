package com.eunxi.spring.reply.service;

import java.util.List;
import java.util.Map;

public interface ReplyService {
    List<ReplyVO> replyList(Map<String, Object> map ); // 댓글 목록
    void replyInsert(ReplyVO vo); // 댓글 작성
    void replyUpdate(ReplyVO vo); // 댓글 수정
    void replyDelete(ReplyVO vo); // 댓글 삭제
    int replyTotal(int b_num); // 댓글 조회
}
