package com.eunxi.spring.reply.controller;

import com.eunxi.spring.reply.service.ReplyService;
import com.eunxi.spring.reply.service.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reply")
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    // 댓글 조회
    @PostMapping("/reply_list")
    @ResponseBody
    public List<ReplyVO> reply_list(int b_num, Map<String, Object> map, int r_page, int r_amount, String r_state, HttpSession session, Model model){
        System.out.println("Reply List Controller");

        model.addAttribute("session", session.getAttribute("user_id"));

        map.put("b_num", b_num);
        map.put("tbl_type", "B");
        map.put("page", r_page);
        map.put("amount", r_amount);
        map.put("state", r_state);

        List<ReplyVO> reply_list = replyService.replyList(map);

        return reply_list;
    }

    // 댓글 작성
    @PostMapping("/reply_insertAction")
    @ResponseBody
    public void reply_insert(ReplyVO vo){
        System.out.println("REPLY Insert Controller");

        replyService.replyInsert(vo);
    }

    // 댓글 수정
    @PostMapping("/reply_updateAction")
    @ResponseBody
    public void reply_update(ReplyVO vo){
        System.out.println("REPLY Update Controller");

        replyService.replyUpdate(vo);
    }

    // 댓글 삭제
    @PostMapping ("/reply_delete")
    @ResponseBody
    public void reply_delete(ReplyVO vo){
        System.out.println("REPLY Delete Controller");

        replyService.replyDelete(vo);
    }


}
