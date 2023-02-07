package com.eunxi.spring.comment.controller;

import com.eunxi.spring.board.service.BoardService;
import com.eunxi.spring.board.service.BoardVO;
import com.eunxi.spring.file.service.FileService;
import com.eunxi.spring.file.service.FileUtils;
import com.eunxi.spring.file.service.FileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private FileService fileService;

    // 답글 작성
    @GetMapping("/com_insert")
    public String comment_insert(BoardVO vo, Model model){
        System.out.println("Comment Insert Get Controller");

        int b_num = vo.getBoard_seq();
        BoardVO board = boardService.getBoard(b_num);

        System.out.println("com_insert BoardVO vo : " + vo);
        System.out.println("com_insert BoardVO board : " + board);

        // 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 하기
        model.addAttribute("board", board);
        model.addAttribute("vo", vo);

        return "/comment/com_insert";
    }

    // 답글 작성 처리
    @PostMapping("/com_insertAction")
    @ResponseBody
    public String com_insertAction(MultipartHttpServletRequest files, @RequestParam Map<String, Object> map, RedirectAttributes redirect, @RequestParam("file") List<MultipartFile> file) throws IOException {
        System.out.println("Comment Insert Post Controller");

        BoardVO vo = new BoardVO();

        vo.setBoard_title(map.get("board_title").toString());
        vo.setBoard_content(map.get("board_content").toString());
        vo.setUser_id(map.get("user_id").toString());
        vo.setBoard_anonymous(Boolean.parseBoolean(map.get("board_anonymous").toString()));  // jsp 에서 익명 값을 Y | N 으로 보내주고, 컨트롤러에서 Y == 1, N == 0 으로 수정 or 컨트롤러에서 Boolean 으로 변환
        vo.setRoot(Integer.parseInt(map.get("root").toString()));
        vo.setStep(Integer.parseInt(map.get("step").toString()));
        vo.setIndent(Integer.parseInt(map.get("indent").toString()));

        String file_path = "C:\\SAVE\\upload\\comment";

        boardService.board_com_update(vo); // root, step, indent 업데이트
        boardService.board_com_insert(vo); // 답글 등록

        int seq = vo.getBoard_seq();
        System.out.println("vo.getBoard_seq() : " + seq);

        FileUtils fileUtils = new FileUtils();
        List<FileVO> file_list = fileUtils.parseFileInfo(1, seq, "C", file_path, files);

        if(!file_list.isEmpty()){
            fileService.fileListInsert(file_list);
        }

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        return "redirect:/board/board_list";
    }






















































}
