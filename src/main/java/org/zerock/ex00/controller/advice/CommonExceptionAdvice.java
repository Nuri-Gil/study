package org.zerock.ex00.controller.advice;

import lombok.extern.log4j.Log4j2;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice // 이게 없으면 스프링에 BEAN 으로 등록되지 않음
@Log4j2
public class CommonExceptionAdvice {

    @ExceptionHandler(NumberFormatException.class) // NumberFormatException 이 발생하면 이렇게 처리해줘
    public String exeptNumber(Exception exception, Model model) {
        // NumberFormatException 이 들어오고 Model 을 파라미터로 받을 수 있게

        log.error("================");
        log.error(exception.getMessage());

        model.addAttribute("msg", "Number Check");

        return "error_page"; // error_page 로 가게 해줘
    }
}
