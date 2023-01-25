package com.eunxi.board.controller;

import com.eunxi.board.service.BoardService;
import com.eunxi.board.service.BoardVO;
import com.eunxi.board.service.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// vo.setQuery(); 는 리스트, 조회, 수정, 삭제 모두 선언해야 조회, 수정, 삭제 시에도 파라미터 값 유지될 수 있음
// 수정 및 삭제 액션에서 리다이렉트에 이 값을 뒤에 넣어주야 값을 가지고 원래 페이지로 이동할 수 있으므로, 값 뒤에 설정
@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    @GetMapping("/board_list")
    public String getBoardList(BoardVO vo, Model model) {
        System.out.println("Board List Controller");

        vo.setListSize(10); // 한 페이지에 보여줄 레코드 수 지정
        vo.setStartList(1); // 시작 페이지 지정

        System.out.println("-------------------> VO1 : " + vo);
        System.out.println("-------------------> VO2 : " + vo.getListSize());
        System.out.println("-------------------> VO3 : " + vo.getStartList());
        System.out.println("-------------------> VO4 : " + vo.getPage());
        System.out.println("-------------------> 출력 개수 : " + vo.getListSize());
        System.out.println("-------------------> 시작 페이지 : " + vo.getStartList());

        List<BoardVO> boardList = boardService.getBoardList(vo);
        int cnt = boardService.getBoardListCnt(vo);

        if(cnt % vo.getListSize() == 0) {
            cnt--;
        }

        if(vo.getPage()<3) {
            model.addAttribute("startPage", 1);
        }else {
            model.addAttribute("startPage", vo.getPage() - 2);
        }
        if(vo.getPage() + 2 > cnt / vo.getListSize() + 1) {
            model.addAttribute("endPage", cnt / vo.getListSize() + 1);
        }else {
            model.addAttribute("endPage", vo.getPage() + 2);
        }

        model.addAttribute("boardList", boardList); // 목록
        model.addAttribute("cnt", cnt - (vo.getPage() - 1) * vo.getListSize()); // 보여질 내용 수
        model.addAttribute("page", cnt / vo.getListSize() + 1); // 총 페이지
        model.addAttribute("allCount", cnt); // 게시글 총 개수
        model.addAttribute("allPage", vo.getPage()); // 현재 페이지
        model.addAttribute("allSearch", vo); // 검색할 내용 넘겨주기 - vo에 같이 넣어놨음
        model.addAttribute("listSize", vo.getListSize()); // 보여줄 개수

        System.out.println("-------------------> allPage : " + vo.getPage());
        System.out.println("-------------------> page : " + (cnt / vo.getListSize() + 1));
        System.out.println("-------------------> cnt : " + (cnt - (vo.getPage() - 1) * vo.getListSize()));

        return "/board/board_list";
    }

    // ajax 에서 사용할 list, cnt - 순서 확인해서 작성하기
    @PostMapping(value = "/ajax_list.do")
    @ResponseBody
    public List<BoardVO> ajax_list(int search_page, int listSize) throws IOException {
        System.out.println("------------------> Ajax List Controller");
        BoardVO vo = new BoardVO();

        // 먼저 넣고 빼오기(set -> get)
        vo.setPage(search_page);
        vo.setListSize(listSize);

        List<BoardVO> list = boardService.getBoardList(vo);

        System.out.println("=============> BOARD(1) : " + vo);
        System.out.println("===========> page(1) : " + vo.getPage());
        System.out.println("===========> listSize(1) : " + vo.getListSize());
        System.out.println("===========> list : " + list);
        return list;
    }

    @PostMapping("/ajax_cnt.do")
    @ResponseBody
    public int ajax_cnt(int search_page, int listSize) {
        System.out.println("------------------> Ajax Count Controller");
        BoardVO vo = new BoardVO();

        vo.setPage(search_page); // 페이지 번호 지정
        vo.setListSize(listSize);

        int cnt = boardService.getBoardListCnt(vo); // 개수

        System.out.println("=============> BOARD(2) : " + vo);
        System.out.println("===========> page(2) : " + vo.getPage());
        System.out.println("===========> cnt : " + cnt);
        return cnt;
    }

    // 등록 화면
    @GetMapping("/board_insert")
    public String boardInsert(@ModelAttribute("searchVO") BoardVO vo, Model model){
        System.out.println("Board Insert Get Controller");

        return "/board/board_insert";
    }

    // 등록 부분 처리
    // RedirectAttributes: 리다이렉트 이후 저장된 플래시 속성 모델로 이동 - URL 노출 X
    // 새롭게 등록된 게시물의 번호를 위해 RedirectAttributes 사용, 리턴할 때 redirect 사용
    @PostMapping("/board_insertAction")
    public String boardInsert_action(@ModelAttribute("searchVO") BoardVO vo, RedirectAttributes redirect){
        System.out.println("Board Insert Post Controller");

        // 등록 완료했을 때 알림창 출력
        boardService.boardInsert(vo);

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        return "redirect:/board/board_list";
    }

    // 상세 화면
    // 번호를 받을 수 있도록 @requestParam 이용하여 board_seq 값 넣어주기 - 게시글 내용을 인덱스 값 반영해서 가져오기 - 값 꺼내기 위해 addAttribute 사용
    @GetMapping("/board_detail")
    public String getBoard(@ModelAttribute("cri") Criteria cri, @RequestParam("board_seq") int board_seq, Model model) throws UnsupportedEncodingException {
        System.out.println("Board Detail Controller");

        BoardVO getBoard = boardService.getBoard(board_seq);
        boardService.getBoardCnt(board_seq); // 조회수 + 1
        model.addAttribute("board", getBoard);

        return "/board/board_detail";
    }

    // 수정 화면
    // 기존 글 불러오기
    @GetMapping("/board_update")
    public String boardUpdate(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model){
        System.out.println("Board Update Get Controller");

        BoardVO getBoard = boardService.getBoard(board_seq);
        model.addAttribute("board", getBoard);

        return "/board/board_update";
    }

    // 수정 부분 처리
    @PostMapping("/board_updateAction")
    public String boardUpdate_action(@ModelAttribute("searchVO") BoardVO vo, RedirectAttributes redirect) throws UnsupportedEncodingException {
        System.out.println("Board Update Post Controller");
        boardService.boardUpdate(vo);
        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        // 상세 페이지로 가기 위해 seq 값 붙여주기
        return "redirect:/board/board_detail?board_seq=" + vo.getBoard_seq();
    }

    // 삭제
    @GetMapping("/board_delete")
    public String boardDelete(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model) throws UnsupportedEncodingException {
        System.out.println("Board Delete Controller");

        boardService.boardDelete(board_seq);

        return "redirect:/board/board_list";
    }


















}