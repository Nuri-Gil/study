<%--
  Created by IntelliJ IDEA.
  User: goott
  Date: 2024-07-10
  Time: 오후 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- JSTL 용 태그 라이브러리 --%>

<%@include file="../includes/header.jsp" %> <%-- 상대경로로 썼지만 서버 내부에서 처리함 --%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Tables</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables
        documentation</a>.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            ${pageMaker} <%-- 테스트용 --%>
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                <tr>
                    <th>Bno</th>
                    <th>Title</th>
                    <th>Writer</th>
                    <th>RegDate</th>
                    <th>UpdateDate</th>
                </tr>
                </thead>
                <tbody class="tbody"> <%-- TBODY 에 클릭시 링크를 이동 하도록 이벤트 걸기, TD 에서는 데이터만 줄 수 있도록--%>
                <c:forEach var="board" items="${list}"> <%-- var -> 변수명, items -> 돌릴 데이터 --%>
                    <tr data-bno="${board.bno}"> <%-- 무엇을 클릭할지 모르기 때문에 TD 의 데이터가 TR 로 올라와서 bno 를 가져오게--%>
                        <td><c:out value="${board.bno}"/></td>
                        <td><c:out value="${board.title}"/></td>
                        <td><c:out value="${board.writer}"/></td>
                        <td><c:out value="${board.regDate}"/></td>
                        <td><c:out value="${board.updateDate}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div>
                <ul class="pagination">
                    <%-- <li class="page-item disabled"> disabled 없애도록 if 사용 --%>
                    <c:if test="${pageMaker.prev}">
                        <li class="page-item">
                            <a class="page-link" href="${pageMaker.startPage - 1}" tabindex="-1">Previous</a>
                        </li>
                    </c:if>
                    <%-- BoardController 모델에서 정의한 이름 pageMaker--%>
                    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
                        <%-- cri 를 사용하고 있으므로 cri 가 가진 현재 페이지가 맞는 경우에만 'active' 출력 되도록 --%>
                        <li class="page-item ${cri.pageNum == num ? 'active' : ''}">
                            <a class="page-link" href="${num}">${num}</a> <%--c:forEach 에서 나오는 var num 이 여기 들어감--%>
                        </li>
                    </c:forEach>
                    <c:if test="${pageMaker.next}">
                        <li class="page-item">
                            <a class="page-link" href="${pageMaker.endPage + 1}">Next</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="myModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal Title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Modal body text goes here.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">Save changes</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<%@include file="../includes/footer.jsp" %>

<script>

    const result = '${result}' /* 내용이 없으면 빈 문자열이 되지만 있으면 글자가 되도록 '' 추가 */

    const myModal = new bootstrap.Modal(document.getElementById('myModal'));

    console.log(myModal)

    if (result) {
        myModal.show()
    }

    document.querySelector('.tbody').addEventListener("click", (e) => {
        const target = e.target.closest("tr") /* 클릭했을 때 가장 가까운 상위를 찾는다 (여기서는 TD 를 클릭하고 TR 을 찾음) */
        const bno = target.dataset.bno

        console.log(bno);

        // console.log(`/board/read/\${bno}`)
        window.location = `/board/read/\${bno}` /* 백틱을 쓰면 문자열을 탬플릿처럼 사용 가능 */
    }, false)

    // 문서의 쿼리 중 ".pagination" 클래스를 찾아 원래 존재하는것 바깥쪽에 "click" 이벤트를 걸고 event 를 파라미터로 받아 function 주기
    document.querySelector(".pagination").addEventListener("click", (e) => {

        e.preventDefault() // 이벤트에 걸린 기본동작 막기
        const target = e.target // 이벤트의 target 확인
        console.log(target)

        const targetPage = target.getAttribute("href") // target 에 prev, 현재, next 의 참조값을 가져옴 -> 숫자 값이기 때문에 변수 처리(const)
        console.log(targetPage)

        window.location = `/board/list?pageNum=\${targetPage}`
    });
</script>

<%@include file="../includes/end.jsp" %>


<%--

<html>
<head>
    <title>LIST.JSP</title>
</head>
<body>
<h1>LIST PAGE</h1>
<script> /* 자바스크립트 모달 창 띄우기 위해*/
const rno = '${result}'
/* BoardController 에서 rttr.addFlashAttribute("result", 123L);
"result" 라는 변수로 받음 -> JS 에서 변수로 받음 (문자열 처럼 받으려먼 '' 로 감싸야 함) */
</script>
</body>
</html>
--%>
