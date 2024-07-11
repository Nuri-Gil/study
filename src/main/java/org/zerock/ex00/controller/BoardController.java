package org.zerock.ex00.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.ex00.domain.BoardVO;
import org.zerock.ex00.service.BoardService;

import java.util.List;

@Controller // 컨트롤러로 인식하라는 어노테이션
@Log4j2 // 콘솔에 로그를 찍기 위한 어노테이션
@RequiredArgsConstructor // FINAL 은 생성자를 통해 생성되어야 함, 생성자는 일종의 제한
@RequestMapping("/board") // SPRING 의 경우에는 컨트롤러 하나에서 여러개를 처리할 수 있으므로 RequestMapping 사용
public class BoardController {
    // 원래는 의존성 주입이 필요하지만 파라미터 수집이나 웹의 동작을 확인한 후에 해도 괜찮음
    private final BoardService boardService;

    // list -> 보드의 리스트, 경로 설정(url 같은거)을 직접 만드는 메서드에 할 수 있음
    @GetMapping("/list") // -> 이 경우에는 /board/list 의 경로가 됨
    // Model -> 데이터를 담아야 하는 카트
    public void list(Model model) {
        log.info("list....................");

        List<BoardVO> list = boardService.list();

        log.info(list);

        model.addAttribute("list", list); // model 에 "list" 라는 이름표를 붙여서 list 데이터를 담음
        // API 서버 (데이터만 밀어주는 서버) 를 만들면 컨트롤러에서 처리 가능, JSP 쪽으로 간다면 JSP 화면 구성하면 됨
    }

/*
    // HTTP GET 요청이 /read/{bno} 경로로 올 경우 이 메서드를 처리하도록 매핑
    @GetMapping("/read/{bno}") // bno 값을 QueryString 으로 받아 변수처럼 사용, @PathVariable 은 {} 로 묶을것
    public String read( // @PathVariable 은 값이 계속 변하므로 void 메서드 사용 불가능 -> void 라면 변수명마다 jsp 필요해짐
                        // 위에 묶은 {bno} 를 처리하는 @PathVariable 어노테이션
                        // name 속성 "bno" 라는 이름의 변수값을 메서드의 Long bno 에 매핑, 데이터를 가져와서 Model 에 담음
                        @PathVariable(name = "bno") Long bno, Model model) {

        log.info("bno : " + bno);
        // 몇번 글인지 로그
        BoardVO boardVO = boardService.get(bno);
        // 몇번 글의 데이터를 얻어와서
        log.info("boardVO : " + boardVO);
        // 그 글의 데이터 로그
        model.addAttribute("vo", boardVO);
        // 모델에 "vo" 라는 이름으로 가져온 몇번 글을 담음
        return "/board/read";
        // 만들어진 read.jsp 로 보냄
    }
*/
    /*
    // HTTP GET 요청이 /modify/{bno} 경로로 올 경우 이 메서드를 처리하도록 매핑
    @GetMapping("/modify/{bno}")
    public String modify(
            @PathVariable(name = "bno") Long bno, Model model) {

        log.info("bno : " + bno);
        // 몇번 글인지 로그
        BoardVO boardVO = boardService.get(bno);
        // 몇번 글의 데이터를 얻어와서
        log.info("boardVO : " + boardVO);
        // 그 글의 데이터 로그
        model.addAttribute("vo", boardVO);
        // 모델에 "vo" 라는 이름으로 가져온 몇번 글을 담음
        return "/board/modify";
    // 만들어진 read.jsp 로 보냄
}
*/

    @GetMapping({"/{job}/{bno}"})
    // 매핑되는 값 안에 들어가는것을 배열로 처리할 수 있음 -> {"/read/{bno}", "/modify{bno}"}
    // /read, /modify 도 변수로 처리할 수 있음
    public String read(
            @PathVariable(name = "job") String job,
            @PathVariable(name = "bno") Long bno, Model model) {

        log.info("job : " + job);
        // 수행할 작업이 무엇인지 로그
        log.info("bno : " + bno);
        // 몇번 글인지 로그

        // 수행할 job 이 read 나 modify 일 때만 작동하도록 제한 걸기, 예외 던지기
        if (!(job.equals("read") || job.equals("modify"))) {
            throw new RuntimeException("Bad Request Job");
        }

        BoardVO boardVO = boardService.get(bno);
        // 몇번 글의 데이터를 얻어와서
        log.info("boardVO : " + boardVO);
        // 그 글의 데이터 로그
        model.addAttribute("vo", boardVO);
        // 모델에 "vo" 라는 이름으로 가져온 몇번 글을 담음 -> jsp 에서 변수로 사용
        return "/board/" + job;
        // 만들어진 read.jsp 로 보냄
    }

    @GetMapping("/register")
    public void register() {
    }

    @PostMapping("/register")
    // Redirection 하기 때문에 String -> 고정값이 나와야 하므로
    public String registerPost(BoardVO boardVO, RedirectAttributes rttr) {
        // 파라미터는 BoardVO 타입으로 수집함
        // RedirectAttributes -> 데이터를 가지고 리다이렉트를 함

        log.info("boardVO : " + boardVO);

        Long bno = boardService.register(boardVO);
        // BoardMapper.XML 을 이용한 BoardMapper 인터페이스에서는 int insert() 를 정의함 (title, content, writer 추가)
        // BoardService 는 insert() 를 이용하여 register() 를 실행하고 새로운 BoardVO 인스턴스를 추가함
        // 이때 파라미터로 집어넣는 BoardVO 는 insert 후 자동으로 bno 가 생성되는데 그 새로운 long bno 를 읽어옴

        rttr.addFlashAttribute("result", bno);
        // 어떤 번호로 새로운 글이 등록되었다는 것을 알림 -> attributeValue
        // /board/list 스크립트에 const rno = bno 으로 들어가지만 새로고침하면 날아감!

        return "redirect:/board/list"; // 리다이렉트를 할 때는 무조건!!! 앞에 redirect: 붙이기
    }
}
