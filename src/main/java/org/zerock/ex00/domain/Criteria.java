package org.zerock.ex00.domain;

import lombok.Data;

/**
 * Criteria -> 분류/종류
 * JPA 에서 사용함
 * 여기서는 #페이지 번호, #개수, #계산된 skip 을 가지고
 * 동적으로 변화하는 list 의 내용물에 따라 페이지를 처리할 수 있도록 함
 */
@Data
public class Criteria {
    // 반드시 있어야 하는 2개의 변수
    private int pageNum = 1; // 현재 페이지 번호, 항상 1보다 커야 함
    private int amount = 10; // 페이지 당 컨텐츠의 개수
    // skip 은 MyBatis 기능(getter 읽기) 때문에 getSkip 을 만들어서 처리할 것

    public void setPageNum(int pageNum) {
        if (pageNum <= 0) {
            this.pageNum = 1;
            return;
        }
        this.pageNum = pageNum;
    }

    public void setAmount(int amount) {
        if (amount <= 10 || amount > 100) {
            this.amount = 10;
            return;
        }
        this.amount = amount;
    }

    // MyBatis 가 동작할 때 기본적으로 사용하는것은 Getter/Setter -> Java Beans 임
    // 호출할 때는 skip 이란 변수를 호출 할 수 있음 (myBatis 는 getter 를 인식해서 get 뒤에 붙은 변수명을 사용 가능)
    public int getSkip() {
        return (this.pageNum - 1) * this.amount;
    }
}
