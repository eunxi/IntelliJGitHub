package com.eunxi.spring.file.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public void fileListDelete(int file_seq) {
        fileDao.fileListDelete(file_seq);
    }

    @Override
    public FileVO file_downDetail(int file_seq) {
        return fileDao.file_downDetail(file_seq);
    }
}
