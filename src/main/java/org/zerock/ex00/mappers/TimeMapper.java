package org.zerock.ex00.mappers;

import org.apache.ibatis.annotations.Select; // mybatis 3 버전 이하는 ibatis 로 임포트 됨

public interface TimeMapper {
    // 실체가 없는 인터페이스는 스프링이 실행하면서 실체를 만들어 줌
    @Select("SELECT now()")
    /**
     * SQL 문을 간단하게 실행하기 위해 여기에 작성했지만
     * 원래는 xml 에 정의해야 함(mybatis 의 용도)
     * 인터페이스와 같은 패키지에 xml 을 작성해도 되지만 xml, Java 파일이 섞이므로 resources 내에 작성하도록
     */
    String getTime();

    String getTime2();
}
