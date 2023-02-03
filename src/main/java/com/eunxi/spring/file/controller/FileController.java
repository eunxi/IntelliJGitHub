package com.eunxi.spring.file.controller;

import com.eunxi.spring.file.service.FileService;
import com.eunxi.spring.file.service.FileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;

@Controller
public class FileController {

    @Autowired
    FileService fileService;

    // 파일 다운로드 처리
    @RequestMapping(value = "/file_download.do/{b_num}/{file_seq}")
    @ResponseBody
    public void file_download(@PathVariable("file_seq") int file_seq, @PathVariable("b_num") int b_num, HttpServletResponse response) throws Exception {
        System.out.println("FILE Download Controller");

        List<FileVO> fileList = fileService.fileDetail(b_num);
        FileVO file_info = fileService.file_downDetail(file_seq);

        String path = file_info.getFile_path();
        System.out.println("path : " + path);

        File file = new File(path);

        response.setHeader("Content-Disposition", "attachment; filename=" + new String(file_info.getFile_name().getBytes("UTF-8"), "ISO-8859-1")); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더
        System.out.println("file name : " + file_info.getFile_name());

        FileInputStream fileInputStream = new FileInputStream(path); // 파일 읽어오기
        OutputStream out = response.getOutputStream();

        int read = 0;
        byte[] buffer = new byte[1024];
        while ((read = fileInputStream.read(buffer)) != -1) { // 1024 바이트씩 계속 읽으면서 outputStream 에 저장, -1 이 나오면 더이상 읽을 파일이 없음
            out.write(buffer, 0, read);
        }

    }

}
