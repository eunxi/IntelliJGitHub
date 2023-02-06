package com.eunxi.spring.comment.controller;

import com.eunxi.spring.board.service.BoardService;
import com.eunxi.spring.board.service.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private BoardService boardService;

    // 답글 작성
    @GetMapping("/com_insert")
    public String comment_insert(BoardVO vo, Model model){
        System.out.println("Comment Insert Get Controller");

        int b_num = vo.getBoard_seq();
        BoardVO board = boardService.getBoard(b_num);

        // 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 하기
        model.addAttribute("board", board);

        return "/comment/com_insert";
    }

    // 답글 작성 처리
    @PostMapping("/com_insertAction")
    public String com_insertAction(BoardVO vo){
        System.out.println("Comment Insert Post Controller");

        // step 관련 업데이트 -> 화면에서 입력한 정보 DB 저장
        boardService.board_com_update(vo);
        boardService.board_com_insert(vo);

        return "redirect:/board/board_list";
    }

}
