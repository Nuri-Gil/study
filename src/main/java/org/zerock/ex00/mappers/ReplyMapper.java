package org.zerock.ex00.mappers;

import org.apache.ibatis.annotations.Param;
import org.zerock.ex00.domain.Criteria;
import org.zerock.ex00.domain.ReplyVO;

import java.util.List;

public interface ReplyMapper {

    Long insert(ReplyVO replyVO);

    ReplyVO selectOne(Long rno);

    int deleteOne(Long rno);

    int updateOne(ReplyVO replyVO);

    List<ReplyVO> getList(
            @Param("cri") Criteria cri,
            @Param("bno") Long bno);
    // MyBatis 는 원래 파라미터를 1개만 받을 수 있음.
    // 파라미터를 2개 이상 처리하려면 MAP 으로 묶거나, @Param 을 사용할 것

    // 댓글 검색 시 댓글의 개수를 받아올 기능
    int getTotal(@Param("cri") Criteria cri,
                 @Param("bno") Long bno);
}
