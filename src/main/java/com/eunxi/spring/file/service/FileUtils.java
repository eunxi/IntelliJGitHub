package com.eunxi.spring.file.service;

import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;

// 여러 개의 파일을 담아서 리스트로 던져줄 객체 생성 (파일 개수, 파일 존재하는 게시글 번호, 게시글 타입, 파일 경로, 파일)
public class FileUtils {
    public List<FileVO> parseFileInfo(int file_num, int seq, String tbl_type, String filePath, MultipartHttpServletRequest files) throws IOException {

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> FileUtils : " + seq);
        if(ObjectUtils.isEmpty(files)) {
            return null;
        }

        List<FileVO> fileList = new ArrayList<FileVO>();

        //위 경로의 폴더가 없으면 폴더 생성
        File file = new File(filePath);
        if(file.exists() == false) {
            file.mkdir();
        }

        //파일 이름들을 iterator로 담음
        Iterator<String> iterator = files.getFileNames();

        while(iterator.hasNext()) {
            //파일명으로 파일 리스트 꺼내오기
            List<MultipartFile> list = files.getFiles(iterator.next());

            //파일 리스트 개수 만큼 리턴할 파일 리스트에 담아주고 생성 - DB 저장
            for(MultipartFile mf : list) {
                String fileOriginalName = mf.getOriginalFilename();
                UUID uuid = UUID.randomUUID(); // UUID
                String[] uuids = uuid.toString().split("-");
                String uniqueName = uuids[0]; // 생성된 고유 문자열
                String save_name = uniqueName + mf.getOriginalFilename();
                System.out.println("SAVE_NAME : " + save_name);

                int fileSize = (((int)mf.getSize() / 1024) / 1024); // MB 사이즈
                System.out.println("FILE_SIZE : " + fileSize);

                FileVO boardFile = new FileVO();
                boardFile.setB_num(seq);
                boardFile.setDivision_num(file_num);
                boardFile.setTbl_type(tbl_type);
                boardFile.setFile_name(mf.getOriginalFilename());
                boardFile.setFile_saveName(save_name);
                boardFile.setFile_size(fileSize);
//                boardFile.setFile_path(filePath);
                boardFile.setFile_path(filePath + "\\" + save_name);
                fileList.add(boardFile);

//                file = new File(filePath + mf.getOriginalFilename());
                file = new File(filePath + "\\" + save_name);
                mf.transferTo(file);

                file_num++;
            }
        }

        System.out.println( " FileUtils - fileList : " + fileList.size());
        System.out.println( " FileUtils - fileList : " + fileList);

        return fileList;
    }
}
