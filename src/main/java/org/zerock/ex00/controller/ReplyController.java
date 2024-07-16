package org.zerock.ex00.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController // 만들어지는 데이터가 자동으로 JSON 처리가 될 수 있게 함 (Object 타입이어야 함)
@RequestMapping("/reply") // 외국 개발에서는 replies 같이 복수를 사용하기도 함
public class ReplyController {

    @GetMapping(value = "/sample", produces = MediaType.APPLICATION_JSON_VALUE) // JSON 데이터 반환을 명시함
    public Map<String, String> sample() {
        return Map.of("v1", "AAA", "v2", "BBB"); // Map 이므로 순서는 무작위, 키와 밸류로 출력됨
    }
}

/**
 * @RestController 는 객체를 반환하는 것이 좋음
 * 만약 String 리턴이라면 -> Response 의 Content-Type 이 text/html 로 들어가게 됨
 * 원하는 형태의 데이터로 생성이 되지 않을 수 있음
 */
