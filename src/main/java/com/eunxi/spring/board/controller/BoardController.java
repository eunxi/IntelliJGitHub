package com.eunxi.spring.board.controller;

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

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

// vo.setQuery(); 는 리스트, 조회, 수정, 삭제 모두 선언해야 조회, 수정, 삭제 시에도 파라미터 값 유지될 수 있음
// 수정 및 삭제 액션에서 리다이렉트에 이 값을 뒤에 넣어주야 값을 가지고 원래 페이지로 이동할 수 있으므로, 값 뒤에 설정
@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    @Autowired
    FileService fileService;

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
    @PostMapping("/board_insertAction")
    public String boardInsert_action(@ModelAttribute("searchVO") BoardVO vo, MultipartHttpServletRequest files, RedirectAttributes redirect) throws IOException {
        System.out.println("Board Insert Post Controller");

        String filePath = "C:\\SAVE\\upload\\board";
        List<MultipartFile> list = files.getFiles("file");

        System.out.println(">>>>>>>>>>>>>>>>>>>>>> file size : " + list.size());

        // 파일 업로드
//        for(int i = 0; i < list.size(); i++){
//            String fileOriginalName = list.get(i).getOriginalFilename(); // 원래 파일명
//
//            UUID uuid = UUID.randomUUID(); // UUID
//            String[] uuids = uuid.toString().split("-");
//            String uniqueName = uuids[0]; // 생성된 고유 문자열
//
//            File saveFile = new File(filePath + "\\" + uniqueName + fileOriginalName);
//
//            try{
//                list.get(i).transferTo(saveFile);
//            }catch (IllegalStateException e){
//                e.printStackTrace();
//            }catch (IOException e){
//                e.printStackTrace();
//            }
//        }

        // 게시글 등록
        boardService.boardInsert(vo);
        int seq = boardService.getBoardSeq(vo);

        FileUtils fileUtils = new FileUtils();
        List<FileVO> fileList = fileUtils.parseFileInfo(seq, "B", filePath, files);

        System.out.println("fileList Size : " + fileList.size());
        for(int i = 0 ; i < fileList.size() ; i++){
            System.out.println(fileList.get(i));
        }

        // 파일 등록
        fileService.fileListInsert(fileList);

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        return "redirect:/board/board_list";
    }

    // 상세 화면
    // 번호를 받을 수 있도록 @requestParam 이용하여 board_seq 값 넣어주기 - 게시글 내용을 인덱스 값 반영해서 가져오기 - 값 꺼내기 위해 addAttribute 사용
    @GetMapping("/board_detail")
    public String getBoard(@RequestParam("board_seq") int board_seq, Model model, @ModelAttribute("searchVO") BoardVO vo, FileVO fileVO) throws UnsupportedEncodingException {
        System.out.println("Board Detail Controller");

        int cnt = boardService.getBoardListCnt(vo); // 전체 개수
        int total_cnt = cnt - (vo.getPage() - 1) * vo.getListSize(); // 출력하는 개수

        BoardVO getBoard = boardService.getBoard(board_seq);

        boardService.getBoardCnt(board_seq); // 조회수 + 1

        model.addAttribute("board", getBoard);
        model.addAttribute("searchVO", vo);
        model.addAttribute("cnt", total_cnt); // 보여질 내용 수
        model.addAttribute("allCount", cnt); // 전체 게시글 수


        System.out.println("=================>>>>>>>> board_detail getBoard : " + getBoard);
        System.out.println("=================>>>>>>>> board_detail fileVO : " + fileVO);
        System.out.println("=================>>>>>>>> board_detail vo : " + vo);

        return "/board/board_detail";
    }

    // 수정 화면
    // 기존 글 불러오기
    @GetMapping("/board_update")
    public String boardUpdate(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model){
        System.out.println("Board Update Get Controller");

        int cnt = boardService.getBoardListCnt(vo); // 전체 개수

        BoardVO getBoard = boardService.getBoard(board_seq);
        model.addAttribute("board", getBoard);
        model.addAttribute("searchVO", vo);
        model.addAttribute("allCount", cnt); // 전체 게시글 수

        System.out.println("============> board_update vo : " + vo);

        return "/board/board_update";
    }

    // 수정 부분 처리
    @PostMapping("/board_updateAction")
    public String boardUpdate_action(@ModelAttribute("searchVO") BoardVO vo, RedirectAttributes redirect) throws UnsupportedEncodingException {
        System.out.println("Board Update Post Controller");
        boardService.boardUpdate(vo);

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        redirect.addFlashAttribute("page", vo.getPage());
        redirect.addFlashAttribute("listSize", vo.getListSize());
        redirect.addFlashAttribute("type", vo.getType());
        redirect.addFlashAttribute("searchKeyword", vo.getSearchKeyword());

        System.out.println("=====>>>>>> board_updateAction vo : " + vo);
        System.out.println("=====>>>>>> board_updateAction page : " + vo.getPage());
        System.out.println("=====>>>>>> board_updateAction listSize : " + vo.getListSize());

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