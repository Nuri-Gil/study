package org.zerock.ex00.sample;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
// 부트에서는 어노테이션으로 bean 인식하지만
// 스프링에서는 root-context 에서 설정해줄것
@ToString
@RequiredArgsConstructor
public class Restaurant {

    private final Chef chef;

}
