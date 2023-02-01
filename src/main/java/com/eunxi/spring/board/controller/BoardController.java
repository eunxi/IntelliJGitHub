package com.eunxi.spring.board.controller;

import com.eunxi.spring.board.service.BoardService;
import com.eunxi.spring.board.service.BoardVO;
import com.eunxi.spring.file.service.FileService;
import com.eunxi.spring.file.service.FileUtils;
import com.eunxi.spring.file.service.FileVO;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    @Autowired
    FileService fileService;

    // @RequestParam(전달인자 이름으로, 실제 값을 표시) : 파라미터의 값과 이름을 함께 전달하는 방식
    @GetMapping("/board_list")
    public String getBoardList(BoardVO vo, Model model, String type, @RequestParam(value = "listSize", defaultValue = "10") int listSize) {
        System.out.println("Board List Controller");

        //리스트 사이즈 확인
        //없으면 10
        //있으면 parameter
        // listSize 에 고정적인 값을 줘버리면 해당 값으로만 계속 출력되기 때문에, listSize 값이 없을 경우와 있을 경우를 나눠서 사용

        vo.setListSize(listSize); // 한 페이지에 보여줄 레코드 수 지정

        vo.setStartList(1); // 시작 페이지 지정
        vo.setType(type);

        List<BoardVO> boardList = boardService.getBoardList(vo);

        int cnt = boardService.getBoardListCnt(vo);
        int all_count = boardService.getBoardListCnt(vo);

        int total_cnt = cnt - (vo.getPage() - 1) * vo.getListSize();

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

        // 검색한 결과가 없을 경우, 값 0 으로 정확하게 전달
        if(total_cnt < 0){
            total_cnt = 0;
        }

        model.addAttribute("boardList", boardList); // 목록

        // no, 데이터를 가져오는지 확인
//        for(int i = 0 ; i < boardList.size() ; i++){
//            System.out.println(boardList.get(i));
//        }

        model.addAttribute("cnt", total_cnt); // 보여질 내용 수(전체 게시글 수)
        model.addAttribute("page", cnt / vo.getListSize() + 1); // 총 페이지
        model.addAttribute("allCount", cnt); // 게시글 총 개수 - 목록에서 사용하는 총 개수 변수
        model.addAttribute("all_count", all_count); // 게시글 총 개수2 - ajax에서 사용하는 총 개수 변수
        model.addAttribute("allPage", vo.getPage()); // 현재 페이지
        model.addAttribute("allSearch", vo); // 검색할 내용 넘겨주기 - vo에 같이 넣어놨음
        model.addAttribute("listSize", vo.getListSize()); // 보여줄 개수
        model.addAttribute("type", vo.getType()); // 검색 타입
        model.addAttribute("searchKeyword", vo.getSearchKeyword()); // 검색 키워드

        return "/board/board_list";
    }

    // ajax 에서 사용할 list, cnt - 순서 확인해서 작성하기
    @PostMapping(value = "/ajax_list.do")
    @ResponseBody
    public List<BoardVO> ajax_list(int search_page, int listSize, String type, String searchKeyword) throws IOException {
        System.out.println("------------------> Ajax List Controller");
        BoardVO vo = new BoardVO();

        // 먼저 넣고 빼오기(set -> get)
        vo.setPage(search_page);
        vo.setListSize(listSize);
        vo.setType(type);
        vo.setSearchKeyword(searchKeyword);

        List<BoardVO> list = boardService.getBoardList(vo);

        return list;
    }

    @PostMapping("/ajax_cnt.do")
    @ResponseBody
    public int ajax_cnt(int search_page, int listSize, String type, String searchKeyword) {
        System.out.println("------------------> Ajax Count Controller");
        BoardVO vo = new BoardVO();

        vo.setPage(search_page); // 페이지 번호 지정
        vo.setListSize(listSize);
        vo.setType(type);
        vo.setSearchKeyword(searchKeyword);

        int cnt = boardService.getBoardListCnt(vo); // 개수

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
    // 실제 file 은 List<MultipartFile> 로 받고, 나머지는 Map<String, Object> 로 받음
    @PostMapping("/board_insertAction")
    @ResponseBody
    public String boardInsert_action(Model model, BoardVO vo, MultipartHttpServletRequest files, @RequestParam("file") List<MultipartFile> file, @RequestParam Map<String, Object> map, @RequestParam("board_anonymous") boolean board_anonymous, RedirectAttributes redirect) throws IOException {
        System.out.println("Board Insert Post Controller");

        // ajax 에서 파일과 데이터들이 넘어오는지 확인
//        System.out.println(file);
//        for(int i = 0 ; i < file.size() ; i++){
//            System.out.println(file.get(i).getOriginalFilename());
//        }
//
//        System.out.println(">>>> MAP 형태 불러오기");
//        for(String key : map.keySet()){
//            System.out.println("key: " + key + ", value: " + map.get(key));
//        }

        String title = map.get("board_title").toString(); // map Object를 toString()을 통해 String 타입으로 변경
        String id = map.get("user_id").toString();
        String content = map.get("board_content").toString();

        // BoardVO 새로 만들어서 jsp 에서 받아온 데이터 값 넣어주기
        vo.setBoard_title(title);
        vo.setUser_id(id);
        vo.setBoard_anonymous(board_anonymous);
        vo.setBoard_content(content);

        String filePath = "C:\\SAVE\\upload\\board";
//        List<MultipartFile> list = files.getFiles("file"); // 웹에서 파일 받는 코드

        // 게시글 등록
        boardService.boardInsert(vo);
        int seq = boardService.getBoardSeq(vo);

        FileUtils fileUtils = new FileUtils();
        List<FileVO> fileList = fileUtils.parseFileInfo(seq, "B", filePath, files);

        // 파일 존재할 때만 파일 넣ㅇ주기
        if(!fileList.isEmpty()){
            fileService.fileListInsert(fileList);
        }

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        return "redirect:/board/board_list";
    }

    // 상세 화면
    // 번호를 받을 수 있도록 @requestParam 이용하여 board_seq 값 넣어주기 - 게시글 내용을 인덱스 값 반영해서 가져오기 - 값 꺼내기 위해 addAttribute 사용
    @GetMapping("/board_detail")
    public String getBoard(@RequestParam("board_seq") int board_seq, Model model, BoardVO vo, FileVO fileVO) throws UnsupportedEncodingException {
        System.out.println("Board Detail Controller");

        int cnt = boardService.getBoardListCnt(vo); // 전체 개수
        int total_cnt = cnt - (vo.getPage() - 1) * vo.getListSize(); // 출력하는 개수
        int seq = vo.getBoard_seq();

        BoardVO getBoard = boardService.getBoard(board_seq);

        boardService.getBoardCnt(board_seq); // 조회수 + 1
        List<FileVO> fileList = fileService.fileDetail(seq);

        model.addAttribute("board", getBoard);
        model.addAttribute("searchVO", vo);
        model.addAttribute("cnt", total_cnt); // 보여질 내용 수
        model.addAttribute("allCount", cnt); // 전체 게시글 수

        model.addAttribute("fileList", fileList);

        return "/board/board_detail";
    }

    // 수정 화면
    // 기존 글 불러오기
    @GetMapping("/board_update")
    public String boardUpdate(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model){
        System.out.println("Board Update Get Controller");

        List<FileVO> fileList = fileService.fileDetail(board_seq);

        for(int i = 0; i < fileList.size(); i++){
            System.out.println(fileList.get(i));
        }

        int cnt = boardService.getBoardListCnt(vo); // 전체 개수

        BoardVO getBoard = boardService.getBoard(board_seq);
        model.addAttribute("board", getBoard);
        model.addAttribute("searchVO", vo);
        model.addAttribute("allCount", cnt); // 전체 게시글 수

        model.addAttribute("fileList", fileList); // fileList 보내주기

        System.out.println(">>>> fileList: " + fileList);

        return "/board/board_update";
    }

    // 수정 부분 처리
    @PostMapping("/board_updateAction")
    @ResponseBody
    public String boardUpdate_action(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("file") List<MultipartFile> file,  MultipartHttpServletRequest files, RedirectAttributes redirect) throws UnsupportedEncodingException {
        System.out.println("Board Update Post Controller");

        System.out.println(">>>>>>>>>>>> AJAX 연동 확인 시작");
        System.out.println(file);
        System.out.println(">>>>>>>>>>>> AJAX 연동 확인 끝");

        boardService.boardUpdate(vo);

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        redirect.addFlashAttribute("page", vo.getPage());
        redirect.addFlashAttribute("listSize", vo.getListSize());
        redirect.addFlashAttribute("type", vo.getType());
        redirect.addFlashAttribute("searchKeyword", vo.getSearchKeyword());

        // 상세 페이지로 가기 위해 seq 값 붙여주기
        return "redirect:/board/board_detail?board_seq=" + vo.getBoard_seq() + "&page=" + vo.getPage() + "&listSize=" + vo.getListSize() + "&type" + vo.getType() + "&searchKeyword=" + vo.getSearchKeyword();
    }

    // 삭제
    @GetMapping("/board_delete")
    public String boardDelete(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model, RedirectAttributes redirect) throws UnsupportedEncodingException {
        System.out.println("Board Delete Controller");

        boardService.boardDelete(board_seq);

        redirect.addFlashAttribute("page", vo.getPage());
        redirect.addFlashAttribute("listSize", vo.getListSize());
        redirect.addFlashAttribute("type", vo.getType());
        redirect.addFlashAttribute("searchKeyword", vo.getSearchKeyword());

        System.out.println("=====>>>>>> board_delete vo : " + vo);
//        System.out.println("=====>>>>>> board_delete vo : " + vo);
//        System.out.println("=====>>>>>> board_delete vo : " + vo);

        return "redirect:/board/board_list?board_seq=" + vo.getBoard_seq() + "&page=" + vo.getPage() + "&listSize=" + vo.getListSize() + "&type" + vo.getType() + "&searchKeyword=" + vo.getSearchKeyword();
    }


















}