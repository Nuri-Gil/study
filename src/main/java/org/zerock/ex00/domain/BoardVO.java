package org.zerock.ex00.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data // Lombok Getter/Setter 사용을 위해
public class BoardVO {
    // 데이터를 담기 위한 작업 -> 데이터베이스의 테이블과 거의 맞춰서 진행
    private Long bno; // JPA 할 때 대부분 Long 사용
    private String title;
    private String content;
    private String writer;

    private LocalDateTime regDate; // 8 버전 이후는 Date 보다 LocalDateTime 을 사용
    private LocalDateTime updateDate;
}
/**
 * 이 곳에 데이터가 들어오면 처리하게 됨
 * 이곳에서 처리를 하기 위해서는 코드가 길어짐
 * mybatis-config.xml 에서 <configuration> <typeAliases> 작성할 것
 */
