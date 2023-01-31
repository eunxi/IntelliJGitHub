package com.eunxi.spring.file.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FileDAO {
    @Autowired
    private SqlSessionTemplate session;

    // 파일[] 등록
    public void fileListInsert(List<FileVO> fileList){
        session.insert("fileDao.fileListInsert", fileList);
    }

    // 파일 상세보기
    public List<FileVO> fileDetail(int seq){
        return session.selectList("fileDao.fileDetail", seq);
    }

}
