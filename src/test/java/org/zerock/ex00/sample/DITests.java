package org.zerock.ex00.sample;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// 테스트 할 때 어떤 설정을 이용할 지 지정하는 부분
public class DITests {

    @Autowired // 이 타입의 객체를 테스트 코드에 넣어줘!
    // 이 타입의 객체가 필요한데 자동으로 스프링에 찔러달라
    Restaurant restaurant;

    @Autowired  // 히카리 테스트용 (DB 연결) 등록
    DataSource dataSource;

    @Test
    public void testCon() throws SQLException {
        Connection con = dataSource.getConnection();
        System.out.println(con);
        con.close();
    }

    @Test // 테스트 용 어노테이션
    public void testExists() {
        System.out.println(restaurant);
    }
}
