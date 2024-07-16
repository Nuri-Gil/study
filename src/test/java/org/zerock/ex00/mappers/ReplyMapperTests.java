package org.zerock.ex00.mappers;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.ex00.domain.ReplyVO;


@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class ReplyMapperTests {
    @Autowired(required = false)
    private ReplyMapper replyMapper;

    @Test
    public void testInsert() {
        Long bno = 576L;

        for (int i = 0; i < 10; i++) {
            ReplyVO replyVO = ReplyVO.builder()
                    .bno(bno)
                    .replyText("Sample Reply..." + i)
                    .replyer("REPLY WRITER1")
                    .build();

            log.info(replyMapper.insert(replyVO));
        }
    }
}