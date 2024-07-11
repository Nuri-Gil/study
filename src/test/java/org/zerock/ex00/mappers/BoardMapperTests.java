package org.zerock.ex00.mappers;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.domain.Criteria;

import java.util.List;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class BoardMapperTests {

    @Autowired(required = false) // 스프링에서 주입을 받을건데 이런 타입이 없으니까 무시하고 진행해라
    BoardMapper boardMapper;

    @Test
    public void test1() {
        log.info(boardMapper);
    }

    @Test
    public void testList() {
        boardMapper.getList().forEach(boardVO -> log.info(boardVO));
    }

    @Test
    public void testInsert() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("New Test");
        boardVO.setContent("New content");
        boardVO.setWriter("newbie");

        log.info("COUNT : " + boardMapper.insert(boardVO)); // 몇개가 추가 되었나? -> 1
        log.info("BNO : " + boardVO.getBno());
    }

    @Test
    public void testSelect() {
        Long bno = 10L;
        log.info(boardMapper.select(bno));
    }

    @Test
    public void testUpdate() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("Updated Title");
        boardVO.setContent("updated content");
        boardVO.setBno(10L);
        int updateCount = boardMapper.update(boardVO);

        log.info("update : " + updateCount);
    }

    @Test
    public void testPage() {
        Criteria criteria = new Criteria(); // 기본값은 1, 10

        criteria.setPageNum(1);

        List<BoardVO> list = boardMapper.getPage(criteria);

        list.forEach(boardVO -> log.info(boardVO));
    }
}
