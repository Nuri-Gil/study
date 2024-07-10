package org.zerock.ex00.controller;
// 127p.

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.ex00.domain.SampleDTO;
import org.zerock.ex00.domain.SampleDTOList;
import org.zerock.ex00.domain.TodoDTO;

import java.util.Arrays;

@Controller
/**
 * 컨트롤러로 지정하는 어노테이션
 * 스프링 부트와는 다르게 스프링에서는 해당 패키지를 조사해야지!!! 컨트롤러로 인식함
 * 웹과 관련된 설정은 servlet-context.xml 에서 처리함
 * 스프링에 등록된 component 조사를 위한 component-scan 할 것
 * 그 이후에 스프링에 Bean 으로 등록됨
 */
@Log4j2 // 로그를 남기기 위한 어노테이션 (상속, 인터페이스가 어노테이션으로 대체됨)
@RequestMapping("/sample")
/**
 * 아래 메서드의 타입은 void, 어떤 식으로 매칭이 될 것인지 지정하는 어노테이션
 * 두 군데에 적용 가능, 경로를 설정할 때 쓰는것, 패키지 경로 지정
 * RequestMapping 은 method 배열형식으로 GET, POST 둘 다 적용 가능
 * 여러 방식을 지정할 때는 RequestMapping, 하나만 지정해서 쓸 때는 GetMapping, PostMapping 지정
 * 1. 클래스 쪽 (인터페이스 같이), 경로를 지정할 때 쓸거라 /sample 로 선언
 */
public class SampleController {

    @GetMapping("/basic") // GET 방식으로 동작할 때 사용할 용도, sample/basic.jsp 를 찾아감
    public void basic() {
        log.info("basic-----------------");
    }

    // DTO 로 파라미터 받기
    @GetMapping("/ex01")
    public void ex1(SampleDTO sampleDTO) {
        log.info("ex01---------------");
        log.info(sampleDTO);
    }

/*

    // RequestParam 으로 파라미터 받기
    @GetMapping("/ex1")
    public void ex1(
            @RequestParam("name") // 1. 파라미터의 값이 "name" 이면
            String name, // 2. String name 에 넣는다 (http 프로토콜은 문자열을 처리하므로 String 이 기본)
            @RequestParam(value = "age", required = false, defaultValue = "10") // 3. "age" 라는 값이 있을수도, 없을수도 있고 기본값은 10
            int age) { // 4. 자동 타입을 변환해줌, 다만 타입이 다양할 때 해결해주지는 않음

        log.info("ex1-----------------");
        log.info(name);
        log.info(age);
    }

*/

    @GetMapping("/ex02Array")
    public java.lang.String ex02Array(String[] ids) { // Array 로 파라미터 받기
        log.info("ex02Array--------------");
        log.info(Arrays.toString(ids));
        return "/sample/ex2";
    }

    @GetMapping("/ex02Bean")
    /**
     * Get 방식 사용시 /sample/ex02Bean?list[0].name=nuri&list[0].age=20 등으로 입력할 때
     * [0] 같은 URL 에서만 사용하는 특수한 문자는 사용할 수 없음
     * URL Encoding 으로 처리해서 바꿔야 함
     * "[" -> &5B, "]" -> %5D, GET 방식에서만 사용, POST 에서는 상관 없음
     * 위 URL 을 인코딩 한 결과
     * /sample/ex02Bean?list%5B0%5D.name=nuri&list%5B0%5D.age=20&list%5B1%5D.name=YJ&list%5B1%5D.age=35
     */
    public void ex02Bean(SampleDTOList list) {
        log.info(list);
    }

    @GetMapping("/ex03")
    public void ex03(TodoDTO todoDTO) {
        log.info("------------------------------");
        // /sample/ex03?title=AA&dueDate=2024-03-12
        log.info(todoDTO);
    }

    @GetMapping("/ex04")
    public void ex04(
            /** @ModelAttribute -> 파라미터가 들어온 경우, 그 파라미터를 jsp 에서 사용하고 싶다
             * int page 라는 파라미터 값을 `"page"` 라는 이름으로 jsp 에서 ${page} 로 받아다 쓸것이다
             * 컨트롤러에는 파라미터로 들어왔지만 정식 데이터로 만드는 어노테이션
             */
            @ModelAttribute("dto") SampleDTO dto,
            @ModelAttribute("page") int page,
            Model model
    ) {
        model.addAttribute("list", new String[]{"AAA", "BBB", "CCC"});
        /**
         * model 을 파라미터로 받으면 "list" 를 전달하고 싶음, 처리된 결과물은 new String[]{"AAA", "BBB", "CCC"}
         */
    }

    @GetMapping("/ex05")
    public String ex05(RedirectAttributes rttr) {
        /**
         * RedirectAttributes -> /ex05 라는 경로로 컨트롤러를 호출하는데
         * 경로가 다르거나 조건에 맞춰서 다른 경로로 안내해주는 것
         * GET 방식만 사용할 수 있음
         */
        // 리다이렉트 될 때 파라미터를 전달하는 용도
        rttr.addAttribute("v1", "ABC");
        rttr.addAttribute("v2", "XYZ");

        // 파라미터를 한번만 전달하는 용도 -> 일회성, 휘발성, 리다이렉션을 하는 순간만 보냄, 유지하지 않음 -> 결과 데이터 전달용
        rttr.addFlashAttribute("core", "ABCDEF");
        return "redirect:/sample/basic"; // 메서드 파라미터로 들어가는 RedirectAttributes 와 쌍을 이룸
    }
}
