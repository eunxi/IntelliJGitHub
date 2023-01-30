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
        System.out.println(">>>>>>>>>>>>> FileDAO --- fileListInsert -- fileList : " + fileList.toString());
        session.insert("fileDao.fileListInsert", fileList);
    }

}
