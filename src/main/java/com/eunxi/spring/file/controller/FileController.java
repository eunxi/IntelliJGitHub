package com.eunxi.spring.file.controller;

import com.eunxi.spring.file.service.FileService;
import com.eunxi.spring.file.service.FileUtils;
import com.eunxi.spring.file.service.FileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FileController {

    @Autowired
    FileService fileService;

    // 파일 다운로드 처리
    @RequestMapping(value = "/file_download.do/{seq}/{order_seq}")
    @ResponseBody
    public void file_download(@PathVariable("order_seq") int order_seq, @PathVariable("seq") int seq, HttpServletResponse response) throws Exception {
        System.out.println("FILE Download Controller");

        System.out.println(">>> seq" + seq);
        System.out.println(">>> order_seq" + order_seq);

        int o_seq = (order_seq - 1);
        List<FileVO> fileList = fileService.fileDetail(seq);
        System.out.println("----------------- file list -----------------");
        System.out.println(fileList.get(o_seq));
//
        String path = fileList.get(o_seq).getFile_path();
//            String name = fileList.get(seq).getFile_path();
//            String path = "C:\\SAVE\\upload\\board\\" + name;

        File file = new File(path);

        response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileList.get(o_seq).getFile_name().getBytes("UTF-8"), "ISO-8859-1")); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더
//            response.setHeader("Content-Disposition", "attachment; filename=" + fileList.get(seq).getFile_name()); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더
        System.out.println("file name : " + fileList.get(o_seq).getFile_name());


        FileInputStream fileInputStream = new FileInputStream(path); // 파일 읽어오기
        OutputStream out = response.getOutputStream();

        int read = 0;
        byte[] buffer = new byte[1024];
        while ((read = fileInputStream.read(buffer)) != -1) { // 1024 바이트씩 계속 읽으면서 outputStream 에 저장, -1 이 나오면 더이상 읽을 파일이 없음
            out.write(buffer, 0, read);
        }

    }

}
