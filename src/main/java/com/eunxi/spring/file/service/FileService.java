package com.eunxi.spring.file.service;

import java.util.List;

public interface FileService {
    void fileListInsert(List<FileVO> fileList); // 파일[] 등록
    List<FileVO> fileDetail(int seq); // 파일 상세보기
}
