package org.zerock.ex00.aop;

import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect // Aspect (추상 기능을 구현할것) 라는것 선언
@Component // Spring 설정에서 인식시키기 위해
@Log4j2 // 로그 출력용 설정
public class LogAdvice {

    // @Before("execution(* org.zerock.ex00.service.BoardService.*(..))")
    // @Before -> 메서드 실행 전에 실행되는 어드바이스이며 주로 전처리 작업에 사용
    @Around("execution(* org.zerock.ex00.service.*Service.*(..))")
    // @Around -> 메서드 실행을 앞뒤로 감싸서 원본 메서드의 실행을 제어할 수 있는 더 유연한 어드바이스 유형 -> 무조건 Return 이 있음

    // 포인트컷 선언 -> 어떤 클래스, 어떤 상황 등에서 동작하도록 필터링 하는 조건
    // 지금은 위치만 선언했을 뿐, 적용의 설정은 하지 않음 -> 설정은 원래 따로 빼지만 (aop-config.xml 등으로) 지금은 root-context 에서 설정
    // 타겟의 어떤 메서드를 호출할 때 적용 시점을 사전, 사후로 설정 가능
    public Object logTime(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
        long start = System.currentTimeMillis();
        Object result = proceedingJoinPoint.proceed();// 진짜 메서드를 실행시키는 기능
        long end = System.currentTimeMillis();
        long gap = end - start;
        log.info("-----------------------");
        log.info(proceedingJoinPoint.getTarget()); // 타겟 정보
        log.info(proceedingJoinPoint.getSignature()); // 메서드 정보
        log.info("Time : " + gap);

        if (gap > 100) {
            log.warn("--------------- WARNING --------------");
        }
        return result;
    }
}
