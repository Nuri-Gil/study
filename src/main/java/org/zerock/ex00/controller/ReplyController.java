package org.zerock.ex00.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.zerock.ex00.domain.Criteria;
import org.zerock.ex00.domain.PageDTO;
import org.zerock.ex00.domain.ReplyVO;
import org.zerock.ex00.service.ReplyService;

import java.util.List;
import java.util.Map;

@RestController // 만들어지는 데이터가 자동으로 JSON 처리가 될 수 있게 함 (Object 타입이어야 함)
@RequestMapping("/reply") // 외국 개발에서는 replies 같이 복수를 사용하기도 함
@RequiredArgsConstructor
@Log4j2
public class ReplyController {
    @GetMapping(value = "/sample", produces = MediaType.APPLICATION_JSON_VALUE) // JSON 데이터 반환을 명시함
    public Map<String, String> sample() {
        return Map.of("v1", "AAA", "v2", "BBB"); // Map 이므로 순서는 무작위, 키와 밸류로 출력됨
    }

    private final ReplyService replyService;
    // 컨트롤러는 Service 만 바라봐야 함!!

    @PostMapping("/register")
    public Map<String, Long> register(@RequestBody ReplyVO replyVO) {
        // ReplyVO 는 일반적으로 QueryString 처리함, JSON 처리를 위해 @RequestBody 반드시 필요함!!

        log.info(replyVO);
        Long rno = replyService.register(replyVO);

        // 댓글의 수
        int replyCount = replyService.getReplyCountOfBoard(replyVO.getBno());
        return Map.of("RNO", rno, "COUNT", (long) replyCount); // replyCount 는 int, 맵 제네릭을 위해 long 으로 캐스팅
    }

    @GetMapping("/{rno}")
    public ReplyVO get(@PathVariable("rno") Long rno) {
        return replyService.get(rno);
    }

    @DeleteMapping("/{rno}")
    public Map<String, Boolean> delete(@PathVariable("rno") Long rno) {
        boolean result = replyService.remove(rno);
        return Map.of("Result DELETE", result);
    }

    // 수정 시에는 JSON 데이터를 받아야 하므로 @RequestBody 필요함
    @PutMapping("/{rno}")
    public Map<String, Boolean> modify(@PathVariable("rno") Long rno,
                                       @RequestBody ReplyVO replyVO) {
        replyVO.setRno(rno); // 파라미터로 받은 rno 로 설정해서 매핑 확인, 맞추기
        boolean result = replyService.modify(replyVO);
        return Map.of("Result MODIFY", result);
    }

    @GetMapping("/list/{bno}")
    public Map<String, Object> getListOfBoard(@PathVariable("bno") Long bno, Criteria criteria) { // bno 를 동적 변수로 쓸 수 있게
        log.info("bno : " + bno);
        log.info(criteria);

        List<ReplyVO> replyList = replyService.getListWithBno(criteria, bno);

        int total = replyService.getTotalWithBno(criteria, bno);

        PageDTO pageDTO = new PageDTO(criteria, total);

        return Map.of("replyList", replyList, "pageDTO", pageDTO);
    }
}

/**
 * @RestController 는 객체를 반환하는 것이 좋음
 * 만약 String 리턴이라면 -> Response 의 Content-Type 이 text/html 로 들어가게 됨
 * 원하는 형태의 데이터로 생성이 되지 않을 수 있음
 */
