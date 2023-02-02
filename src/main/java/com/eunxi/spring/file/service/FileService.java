package com.eunxi.spring.file.service;

import java.util.List;

public interface FileService {
    void fileListInsert(List<FileVO> fileList); // 파일[] 등록
    List<FileVO> fileDetail(int seq); // 파일 상세보기
    void fileListDelete(int file_seq); // 파일[] 삭제
    FileVO file_downDetail(int file_seq); // 파일 하나만 상세보기 (다운로드)
}
