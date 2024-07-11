package org.zerock.ex00.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
    private int startPage; // 화면에서 시작 페이지 번호
    private int endPage; // 화면에서 마지막 페이지 번호
    private boolean prev, next; // 이전, 다음 페이지 -> 이 정보를 계산하려면 현재페이지, 전체 데이터 개수를 알아야 함 -> Criteria 안에 수집되어 있음

    private int total; // 모든 데이터의 개수
    private Criteria cri;

    public PageDTO(Criteria cri, int total) { // 현재 페이지에 대한 정보는 Criteria 안에 있음, 생성자로 주입하도록
        this.cri = cri;
        this.total = total;

        this.endPage = (int) Math.ceil(cri.getPageNum() / 10.0) * 10;
        // Criteria 에 저장된 현재 페이지 번호를 10.0 (페이지 리스트 10개씩) 로 나눈 뒤, 소수점을 올리고 다시 10을 곱하고 int 캐스팅
        // 현재 페이지가 1~10 일 경우 10, 2~20 일 경우 20 등등
        // endPage 는 개선의 여지가 있음 (total 에 따라 변하니까), 하지만 startPage 를 구하기 위해 먼저 계산함
        this.startPage = this.endPage - 9;
        // 페이지 리스트가 10개씩 나타낼 수 있도록, 첫 페이지는 n*10+1 이 되어야 한다 (ex. 1, 11, 21, 31)

        int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
        // 진짜 total 개수를 가지고 만들어지는 마지막 페이지 번호는 몇인가
        // total*1.0 -> 소수로 처리를 해야하기 때문
        // cri.getAmount -> 한 페이지당 데이터의 개수 (몇개가 한 페이지를 구성하는가) -> 기본 10개 세팅했음
        // ex. endPage = 20, total = 123 의 경우
        // 총 데이터 개수 123.0 / 페이지 당 데이터 10 -> ceil 12.3 -> 13, realEnd 가 this.endPage 보다 커서 문제되지 않음
        // 10, 20 단위로 페이지 리스트가 쪼개지므로 화면에는 realEnd 보다 작은 endPage 가 출력되어도 문제되지 않음

        // Criteria 에 저장된 getPageNum 이 6, this.endPage 가 10으로 출력되었으나 total 의 개수가 72 개 일 경우 realEnd 는 8임
        if (realEnd <= endPage) {
            this.endPage = realEnd;
            // realEnd 가 작다면 endPage 를 줄여서 realEnd 가 마지막 페이지가 되도록 수정 (10 -> 7)
        }

        this.prev = this.startPage > 1;
        // 이전페이지를 따질 때는 시작페이지 번호만 따짐, 시작 페이지가 1이 아니라면 이전이 있음, 이전으로 가는 링크가 존재함, true
        this.next = this.startPage < realEnd;
        // 다음 페이지를 따질 때는 마지막 페이지보다 작을 경우 다음 페이지로 가는 링크가 존재해야 하므로 true
    }
}
