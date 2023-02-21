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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
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
    public String com_insert(BoardVO vo, Model model, HttpSession session){
        System.out.println("Comment Insert Get Controller");
        model.addAttribute("session", session.getAttribute("user_id"));

        int b_num = vo.getBoard_seq();
        BoardVO board = boardService.getBoard(b_num);

        model.addAttribute("board", board); // 원글의 정보를 답글 쓰기 화면에서 알 수 있도록 하기

        return "/comment/com_insert";
    }

    // 답글 작성 처리
    @PostMapping("/com_insertAction")
    @ResponseBody
    public String com_insertAction(MultipartHttpServletRequest files, @RequestParam Map<String, Object> map, RedirectAttributes redirect) throws IOException {
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

        FileUtils fileUtils = new FileUtils();
        List<FileVO> file_list = fileUtils.parseFileInfo(1, seq, "C", file_path, files);

        if(!file_list.isEmpty()){
            fileService.fileListInsert(file_list);
        }

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        return "redirect:/board/board_list";
    }

    // 답글 수정 화면 - 상세화면의 기존 데이터 뿌려주기
    @GetMapping("/com_update")
    public String com_update(Model model, @RequestParam Map<String, Object> map, HttpSession session){
        System.out.println("Comment Update Get Controller");

        model.addAttribute("session", session.getAttribute("user_id"));

        int b_seq = Integer.parseInt(map.get("board_seq").toString());

        List<FileVO> file_list = fileService.fileDetail(b_seq);

        BoardVO board = boardService.getBoard(b_seq); // 기존 데이터 가져오기

        model.addAttribute("board", board);
        model.addAttribute("file_list", file_list); // file_list
        model.addAttribute("file_size", file_list.size()); // file_size
        model.addAttribute("page", Integer.parseInt(map.get("page").toString())); // page
        model.addAttribute("listSize", Integer.parseInt(map.get("listSize").toString())); // listSize
        model.addAttribute("type", map.get("type").toString()); // type
        model.addAttribute("searchKeyword", map.get("searchKeyword").toString()); // searchKeyword

        return "/comment/com_update";
    }

    // 답글 수정 처리
    @PostMapping("/com_updateAction")
    @ResponseBody
    public String com_updateAction(@RequestParam Map<String, Object> map, MultipartHttpServletRequest files, @RequestParam("del_file") List<Integer> del_file) throws IOException {
        System.out.println("Comment Update Post Controller");

        BoardVO vo = new BoardVO();

        int b_seq = Integer.parseInt(map.get("board_seq").toString());
        int page = Integer.parseInt(map.get("page").toString());
        int listSize = Integer.parseInt(map.get("listSize").toString());
        String type = map.get("type").toString();
        String searchKeyword = map.get("searchKeyword").toString();

        vo.setBoard_seq(b_seq);
        vo.setBoard_title(map.get("board_title").toString());
        vo.setBoard_content(map.get("board_content").toString());
        vo.setUser_id(map.get("user_id").toString());
        vo.setBoard_anonymous(Boolean.parseBoolean(map.get("board_anonymous").toString()));
        vo.setType(type);
        vo.setSearchKeyword(searchKeyword);
        vo.setPage(page);
        vo.setListSize(listSize);
        vo.setRoot(Integer.parseInt(map.get("root").toString()));
        vo.setStep(Integer.parseInt(map.get("step").toString()));
        vo.setIndent(Integer.parseInt(map.get("indent").toString()));

        for(int i = 0; i < del_file.size(); i++){
            fileService.fileListDelete(del_file.get(i));
        }

        List<FileVO> list = fileService.fileDetail(b_seq);
        int f_size = list.size(); // 추가할 파일 개수 구하고, 순번 지정해주는 코드
        int division_num = f_size;

        if(division_num == 0){
            division_num = 1;
        }else{
            division_num += f_size;
        }

        // 파일 추가
        String file_path = "C:\\SAVE\\upload\\comment";
        FileUtils fileUtils = new FileUtils();
        List<FileVO> file_list = fileUtils.parseFileInfo(division_num, b_seq, "C", file_path, files);

        boardService.boardUpdate(vo);

        if(!file_list.isEmpty()){
            fileService.fileListInsert(file_list);
        }

        System.out.println("com_updateAction BoardVO : " + vo);

        // 답글 상세 페이지로 이동하기 위해 필요 조건 붙여주기
        return "redirect:/board/board_detail?board_seq=" + b_seq + "&page=" + page + "&listSize=" + listSize + "&type" + type + "&searchKeyword=" + searchKeyword;
    }






















































}
