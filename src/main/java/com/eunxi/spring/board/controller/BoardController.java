package com.eunxi.spring.board.controller;

import com.eunxi.spring.board.service.BoardService;
import com.eunxi.spring.board.service.BoardVO;
import com.eunxi.spring.file.service.FileService;
import com.eunxi.spring.file.service.FileUtils;
import com.eunxi.spring.file.service.FileVO;
import com.eunxi.spring.reply.service.ReplyService;
import com.eunxi.spring.reply.service.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    @Autowired
    FileService fileService;

    @Autowired
    ReplyService replyService;

    @GetMapping("/list_get") // get 방식 test
    public ResponseEntity<?> list_get(@RequestParam("user_id") String user){
        Map<String, Object> map = new HashMap<>();
        map.put("user", user);

        System.out.println("map : " + map);

        List<Map<String, Object>> list = boardService.list_user(map);

        System.out.println("<< list_get 목록 출력 >>");
        for(int i = 0; i < list.size(); i++){
            System.out.println(list.get(i));
        }

        return ResponseEntity.ok().body("connection successfully");
    }

    @PostMapping("/list_post") // form-data
    public ResponseEntity<String> list_post(@RequestParam Map<String, Object> map){
        for(String key : map.keySet()){
            System.out.println("key : " +key + ", value : " + map.get(key));
        }

        List<Map<String, Object>> list = boardService.list_board(map);

        System.out.println("<< list_post 목록 출력 >>");
        for(int i = 0; i < list.size(); i++){
            System.out.println(list.get(i));
        }

        return ResponseEntity.ok().body("connection successfully");
    }

    @PostMapping(value = "/list") // json
    public ResponseEntity<String> list(@RequestBody Map<String, Object> map){
        for(String key : map.keySet()){
            System.out.println("key : " +key + ", value : " + map.get(key));
        }

        System.out.println(map);
        List<Map<String, Object>> list = boardService.list_board(map); // 조건 : 시작날짜 - 마지막날짜
//        List<Map<String, Object>> list = boardService.get_list(map); // 조건 없이 전체 목록 출력

        System.out.println("<< list 목록 출력 >>");
        for(int i = 0; i < list.size(); i++){
            System.out.println(list.get(i));
        }

        return ResponseEntity.ok().body("connection successfully");
    }

    @GetMapping("/board_list")
    public String getBoardList(BoardVO vo, Model model, String type, @RequestParam(value = "listSize", defaultValue = "10") int listSize) {
        System.out.println("Board List Controller");

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
        System.out.println("Ajax List Controller");
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
        System.out.println("Ajax Count Controller");
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
    public String boardInsert(@ModelAttribute("searchVO") BoardVO vo, Model model, HttpServletRequest request){
        System.out.println("Board Insert Get Controller");

        HttpSession session = request.getSession();
        System.out.println("게시글 등록 화면 넘어갈 때 - session : " + session.getAttribute("user_id"));

        model.addAttribute("session", session.getAttribute("user_id"));

        return "/board/board_insert";
    }

    // 등록 부분 처리 -  @RequestParam("file") List<MultipartFile> file 는 불필요해서 제거
    @PostMapping("/board_insertAction")
    @ResponseBody
    public String boardInsert_action(BoardVO vo, MultipartHttpServletRequest files, @RequestParam Map<String, Object> map, @RequestParam("board_anonymous") boolean board_anonymous, RedirectAttributes redirect) throws IOException {
        System.out.println("Board Insert Post Controller");

        String title = map.get("board_title").toString(); // map Object를 toString()을 통해 String 타입으로 변경
        String id = map.get("user_id").toString();
        String content = map.get("board_content").toString();

        // BoardVO 새로 만들어서 jsp 에서 받아온 데이터 값 넣어주기
        vo.setBoard_title(title);
        vo.setUser_id(id);
        vo.setBoard_anonymous(board_anonymous);
        vo.setBoard_content(content);

        String filePath = "C:\\SAVE\\upload\\board";

        // 게시글 등록
        boardService.boardInsert(vo);
        int seq = boardService.getBoardSeq(vo);

        FileUtils fileUtils = new FileUtils();
        List<FileVO> fileList = fileUtils.parseFileInfo(1, seq, "B", filePath, files);

        // 파일 존재할 때만 파일 넣어주기
        if(!fileList.isEmpty()){
            fileService.fileListInsert(fileList);
        }

        redirect.addFlashAttribute("redirect", vo.getBoard_seq());

        return "redirect:/board/board_list";
    }

    // 상세 화면 (게시글, 답글)
    @GetMapping("/board_detail")
    public String getBoard(@RequestParam("board_seq") int board_seq, Model model, BoardVO vo, HttpSession session) throws UnsupportedEncodingException {
        System.out.println("Board Detail Controller");

        System.out.println("게시글 상세 화면 넘어갈 때 - session : " + session.getAttribute("user_id"));
        model.addAttribute("session", session.getAttribute("user_id"));

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

        System.out.println("게시글 상세보기 화면 : " + getBoard);

        // reply pagination
        ReplyVO reply = new ReplyVO();
        reply.setR_amount(10);

        int reply_total = replyService.replyTotal(board_seq); // 댓글 전체 개수
        int reply_cnt = replyService.replyTotal(board_seq); // 댓글 전체 개수
        int reply_amount = reply.getR_amount();
        int reply_num = reply_total - (reply.getR_page() - 1) * reply.getR_amount();

        if(reply_total % reply.getR_amount() == 0){
            reply_total--;
        }

        if(reply_total < 0){
            reply_total = 0;
        }

        // startPage
        if(reply.getR_page() < 3){
            model.addAttribute("startPage", 1);
        }else{
            model.addAttribute("startPage", reply.getR_page() - 2);
        }

        // endPage
        if(reply.getR_page() + 2 > reply_total / reply.getR_amount() + 1){
            model.addAttribute("endPage", reply_cnt / reply.getR_amount() + 1);
        }else {
            model.addAttribute("endPage", reply.getR_page() + 2);
        }

        model.addAttribute("reply_num", reply_num); // 보여질 댓글 수
        model.addAttribute("r_allPage", reply_total / reply.getR_amount() + 1); // 총 페이지
        model.addAttribute("r_total", reply_total); // 댓글 총 개수
        model.addAttribute("reply_cnt", reply_cnt); // 댓글 총 개수 (ajax 사용)
        model.addAttribute("r_page", reply.getR_page()); // 현재 페이지
        model.addAttribute("r_amount", reply_amount); // 보여질 개수

        return "/board/board_detail";
    }

    // 수정 화면
    // 기존 글 불러오기
    @GetMapping("/board_update")
    public String boardUpdate(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model, HttpSession session){
        System.out.println("Board Update Get Controller");

        System.out.println("게시글 수정 화면 넘어갈 때 - session : " + session.getAttribute("user_id"));
        model.addAttribute("session", session.getAttribute("user_id"));

        List<FileVO> fileList = fileService.fileDetail(board_seq);

        System.out.println("GET 수정 화면");
        for(int i = 0; i < fileList.size(); i++){
            System.out.println(fileList.get(i));
        }

        int cnt = boardService.getBoardListCnt(vo); // 전체 개수

        BoardVO getBoard = boardService.getBoard(board_seq);
        model.addAttribute("board", getBoard);
        model.addAttribute("searchVO", vo);
        model.addAttribute("allCount", cnt); // 전체 게시글 수

        model.addAttribute("fileList", fileList); // fileList 보내주기
        model.addAttribute("file_num", fileList.size());

        return "/board/board_update";
    }

    // 수정 부분 처리
    @PostMapping("/board_updateAction")
    @ResponseBody
    public String boardUpdate_action(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("delete_file") List<Integer> delete_file, @RequestParam Map<String, Object> map, @RequestParam("board_anonymous") boolean board_anonymous,  @RequestParam("page") int page, @RequestParam("board_seq") int board_seq,  @RequestParam("listSize") int listSize,  MultipartHttpServletRequest files, RedirectAttributes redirect) throws IOException {
        System.out.println("Board Update Post Controller");

        // 삭제하는 파일의 order_seq 확인 후, 삭제 진행
        for(int i = 0; i < delete_file.size(); i++){
            fileService.fileListDelete(delete_file.get(i));
        }

        List<FileVO> list = fileService.fileDetail(board_seq);
        int division_num = list.size();

        // order_seq 가 0 이라면, 1부터 시작
        int order_seq = division_num;

        if(division_num == 0){
            order_seq = 1;
        }else{
            order_seq += division_num;
        }

        String title = map.get("board_title").toString();
        String user = map.get("user_id").toString();
        String content = map.get("board_content").toString();
        String type = map.get("type").toString();
        String searchKeyword = map.get("searchKeyword").toString();

        vo.setBoard_seq(board_seq);
        vo.setBoard_title(title);
        vo.setUser_id(user);
        vo.setBoard_content(content);
        vo.setBoard_anonymous(board_anonymous);
        vo.setPage(page);
        vo.setListSize(listSize);
        vo.setType(type);
        vo.setSearchKeyword(searchKeyword);

        // 파일 업로드 코드
        String file_path = "C:\\SAVE\\upload\\board";
        FileUtils fileUtils = new FileUtils();
        List<FileVO> file_list = fileUtils.parseFileInfo(order_seq, board_seq, "B", file_path, files);

        boardService.boardUpdate(vo);

        // 파일 존재할 때만 파일 넣어주기
        if(!file_list.isEmpty()){
            fileService.fileListInsert(file_list);
        }

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
    public String boardDelete(@ModelAttribute("searchVO") BoardVO vo, @RequestParam("board_seq") int board_seq, Model model, RedirectAttributes redirect, HttpSession session) throws UnsupportedEncodingException {
        System.out.println("Board Delete Controller");

        System.out.println("게시글 삭제 경우 - session : " + session.getAttribute("user_id"));
        model.addAttribute("session", session.getAttribute("user_id"));

        boardService.boardDelete(vo);
        System.out.println("board_delete vo : " + vo.getBoard_state());

        redirect.addFlashAttribute("page", vo.getPage());
        redirect.addFlashAttribute("listSize", vo.getListSize());
        redirect.addFlashAttribute("type", vo.getType());
        redirect.addFlashAttribute("searchKeyword", vo.getSearchKeyword());

        return "redirect:/board/board_list?board_seq=" + vo.getBoard_seq() + "&page=" + vo.getPage() + "&listSize=" + vo.getListSize() + "&type" + vo.getType() + "&searchKeyword=" + vo.getSearchKeyword();
//        return "redirect:/board/board_list";
    }


















}