package org.zerock.ex00.mappers;

import org.zerock.ex00.domain.BoardVO;

import java.util.List;

// SQL 처리용 MyBatis 인터페이스
public interface BoardMapper {
    List<BoardVO> getList();

    int insert(BoardVO boardVO);
    // insert 는 DML -> 데이터의 추가, 수정, 삭제하는 데이터 조작어(Data Manipulation Language)
    // 건수를 따지기 때문에 int 타입이 맞음

    BoardVO select(long bno);

    int update(BoardVO boardVO);
}
