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
        fileDao.fileListInsert(fileList);
    }

    @Override
    public List<FileVO> fileDetail(int seq) {
        return fileDao.fileDetail(seq);
    }
}
