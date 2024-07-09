package org.zerock.ex00.service;
/**
 * 이 패키지는 아직 어노테이션 인식을 위한 Component-Scan 이 되지 않았음
 * spring/root-context 에서 추가해줘야 함
 */

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.mappers.BoardMapper;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional // 트랜잭셔널, 추후에 AOP 수업에서 설명함
public class BoardService {
    /**
     * FINAL 은 생성자를 통해 생성되어야 함, 생성자는 일종의 제한
     * @RequiredArgsConstructor 를 사용할 것
     */
    private final BoardMapper boardMapper;

    public Long register(BoardVO boardVO) {
        log.info("==========================" + boardVO);

        int count = boardMapper.insert(boardVO);// BoardMapper 인터페이스에서 만든 int 값이 하나 나옴

        return boardVO.getBno();
    }

    public List<BoardVO> list() {

        return boardMapper.getList(); // GET 방식 -> 결과를 확인하기 좋음
    }

    public BoardVO get(Long bno) {
        return boardMapper.select(bno);
    }

    public boolean modify(BoardVO vo) {
        return boardMapper.update(vo) == 1; // 업데이트는 1, 실패하면 -1
    }

    public boolean remove(Long bno) {
        return true;
    }
}
/**
 * 예전에는 Setter 위주의 사용으로 데이터를 주입했으나
 * 요즘에는 @RequiredArgsConstructor, @Transactional 사용하는 추세
 */
