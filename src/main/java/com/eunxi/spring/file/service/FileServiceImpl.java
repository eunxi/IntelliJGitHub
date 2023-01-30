package com.eunxi.spring.file.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    private FileDAO fileDao;

    @Override
    public void fileListInsert(List<FileVO> fileList) {
        System.out.println(">>>>>>>>>>>>> FileServiceImpl --- fileListInsert -- fileList : " + fileList.toString());
        fileDao.fileListInsert(fileList);
    }
}
