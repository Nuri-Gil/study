package org.zerock.ex00.mappers;

import org.apache.ibatis.annotations.Param;
import org.zerock.ex00.domain.AttachVO;
import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.domain.Criteria;

import java.util.List;

// SQL 처리용 MyBatis 인터페이스
public interface BoardMapper {
    List<BoardVO> getList();

    List<BoardVO> getPage(Criteria criteria); // Criteria 를 받아 페이지를 구하는 메서드 추가

    int getTotal(Criteria criteria);

    int insert(BoardVO boardVO);
    // insert 는 DML -> 데이터의 추가, 수정, 삭제하는 데이터 조작어(Data Manipulation Language)
    // 건수를 따지기 때문에 int 타입이 맞음

    BoardVO select(Long bno);

    int update(BoardVO boardVO);

    int insertAttach(AttachVO attachVO);

    // 첨부파일 ano 삭제 메서드
    void deleteAttachFiles(@Param("anos") Long[] anos);
}
