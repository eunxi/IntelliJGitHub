package com.eunxi.spring.file.controller;

import com.eunxi.spring.board.service.BoardService;
import com.eunxi.spring.board.service.BoardVO;
import com.eunxi.spring.file.service.FileService;
import com.eunxi.spring.file.service.FileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class FileController {

    @Autowired
    FileService fileService;

    // 파일 다운로드 가능한 컨트롤러 생성
    @GetMapping("/file_download.do")
    public void file_download(FileVO fileVO, BoardVO boardVO){
        System.out.println("FILE Download Controller");

        int seq = boardVO.getBoard_seq();
        List<FileVO> fileList = fileService.fileDetail(seq);

        for(int i = 0; i < fileList.size(); i++){
            System.out.println(">>>>>>>>>>>>>>> fileList : " + fileList.get(i));
        }



    }

}
