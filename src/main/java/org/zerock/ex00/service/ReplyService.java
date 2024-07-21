package org.zerock.ex00.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.ex00.domain.Criteria;
import org.zerock.ex00.domain.ReplyVO;
import org.zerock.ex00.mappers.ReplyMapper;

import java.util.List;

@Transactional
@RequiredArgsConstructor
@Log4j2
@Service
public class ReplyService {
    // Service 는 무조건!! Mapper 만 바라봐야 함
    private final ReplyMapper replyMapper;

    public Long register(ReplyVO replyVO) {

        replyMapper.insert(replyVO);
        return replyVO.getRno(); // insert 후에는 insert 횟수인 count 만 나옴, rno 를 받아와야 함!!
    }

    // 댓글의 total 값을 가져오는 기능
    public int getReplyCountOfBoard(Long bno) {
        return replyMapper.getTotal(null, bno); // Cri 값이 지금 없으므로 null
    }

    public ReplyVO get(Long rno) {
        return replyMapper.selectOne(rno);
    }

    public boolean modify(ReplyVO replyVO) {
        return replyMapper.updateOne(replyVO) == 1;
    }

    public boolean remove(Long rno) {
        return replyMapper.deleteOne(rno) == 1;
    }

    // 특정 게시글의 댓글들 조회
    public List<ReplyVO> getListWithBno(Criteria cri, Long bno) {
        return replyMapper.getList(cri, bno);
    }

    // 특정 게시글의 댓글 수 조회
    public int getTotalWithBno(Criteria cri, Long bno) {
        return replyMapper.getTotal(cri, bno);
    }
}
