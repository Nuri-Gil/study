<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp" %>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Read</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables
        documentation</a>.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Board Read</h6>
    </div>
    <div class="card-body">
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Bno</span>
            </div>
            <input type="text" class="form-control" value="<c:out value="${vo.bno}"/>"
                   readonly> <%-- 조회를 위해 ReadOnly, 출력을 위해서는 c:out 사용--%>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Title</span>
            </div>
            <input type="text" name="title" class="form-control" value="<c:out value="${vo.title}"/>" readonly>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Content</span>
            </div>
            <input type="text" name="content" class="form-control" value="<c:out value="${vo.content}"/>" readonly>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Writer</span>
            </div>
            <input type="text" name="writer" class="form-control" value="<c:out value="${vo.writer}"/>" readonly>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">RegDate</span>
            </div>
            <input type="text" name="regDate" class="form-control" value="<c:out value="${vo.regDate}"/>" readonly>
        </div>
        <div class="input-group input-group-lg">
            <%-- 버튼에는 스크립트를 통해 이벤트를 걸어줄 것임 --%>
            <button type="submit" class="btn btn-info btnList">LIST</button>
            <button type="submit" class="btn btn-warning btnModify">MODIFY</button>
        </div>
    </div>
</div>

<%-- 댓글 페이지 구현 & 카드 div 로 묶기--%>
<div class="card shadow mb-4">
    <ul class="list-group replyList">
        <%-- li 하나씩이 각각의 댓글, li 를 탬플릿처럼 사용해보기 --%>
        <li class="list-group-item d-flex justify-content-between align-items-center">
            Cras justo odio
            <span class="badge badge-primary badge-pill">14</span>
        </li>
    </ul>
    <%-- 댓글 페이지 리스트 번호 --%>
    <ul class="pagination">
        <li class="page-item">
            <a class="page-link" href="#" tabindex="-1">Previous</a>
        </li>
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item active">
            <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
        </li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item">
            <a class="page-link" href="#">Next</a>
        </li>
    </ul>

</div>

<form id="actionForm" method="get" action="/board/list">
    <%--cri 의 pageNum, amount 2개만 가지고 있음--%>
    <input type="hidden" name="pageNum" value="${cri.pageNum}">
    <input type="hidden" name="amount" value="${cri.amount}">
    <input type="hidden" name="pageNum" value="${cri.pageNum}">
    <input type="hidden" name="amount" value="${cri.amount}">
    <%-- 추가로 히든 타입으로 검색 type 이 넘어올 수 있도록--%>
    <c:if test="${cri.types != null && cri.keyword != null}">
        <%-- 키워드는 2개 이상이 들어갈 수 있으므로, 배열로 만들기도 위해 forEach 사용--%>
        <c:forEach var="type" items="${cri.types}">
            <input type="hidden" name="types" value="${type}">
        </c:forEach>
        <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
    </c:if>
    <%--이후에 actionForm 태그를 가진 상태로 list 를 클릭하면 actionForm 이 submit 되며 목록으로 가더라도 검색조건 유지--%>
</form>

<%@include file="../includes/footer.jsp" %>

// Axios 추가
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script> /* Criteria 처리하는 스크립트 추가 */

const actionForm = document.querySelector("#actionForm"); /* #actionForm 이라는 id 를 찾아 변수 선언*/
const bno = '${vo.bno}'

document.querySelector(".btnList").addEventListener("click", (e) => {
    actionForm.setAttribute("action", "/board/list")
    actionForm.submit()
}, false); /*버블링 핸들러 false*/

document.querySelector(".btnModify").addEventListener("click", (e) => {
    actionForm.setAttribute("action", `/board/modify/\${bno}`)
    actionForm.submit()
}, false); /*버블링 핸들러 false*/

</script>

<%--퍼포먼스를 위해서는 script 전달을 한번에 하는게 좋지만 연습을 위해 분리해 봄--%>
<script>
    // console.log(axios) // axios 존재 확인

    // 변하지 않는 상수
    const boardBno = ${vo.bno};
    // 화면에서 유지해야 하는 값 (페이지 번호, 사이즈 등)
    const replyUL = document.querySelector(".replyList"); /* 클래스 선택시 "." 꼭 추가하기!! */
    // 댓글들의 페이지 번호 처리를 위한 화면 클래스를 변수로 받기
    const pageUL = document.querySelector(".pagination");
    // 비동기 함수 정의
    // async function getList
    // const getList = async function
    const getList = async (pageParam, amountParam) => {
        // pageParam 이 없으면 pageNum 으로 할당, JS 는 파라미터 개수가 일치하지 않아도 됨
        const pageNum = pageParam || 1;
        const amount = amountParam || 10;

        // 호출할 경로 지정, Axios 에서 파라미터를 추가할 때는 {} 안에 params 로 추가함 (최근에는 축약형으로!!)
        // await -> 비동기는 결과가 언제 올지 모르지만 동기화처럼 쓰기 위해 사용
        // 비동기는 실행 없이 결과를 호출하려고 할 수 있으므로 실행 후 받는 일반적인 순서를 따르는것이 동기
        const res = await axios.get(`/reply/list/\${boardBno}`, {
            params: {pageNum, amount}
        });

        /* pageDTO, replyList 로 처리*/
        const data = res.data;
        const pageDTO = data.pageDTO;
        const replyList = data.replyList;

        printReplyList(pageDTO, replyList)
    }

    const printReplyList = (pageDTO, replyList) => {
        replyUL.innerHTML = ""

        let str = ''

        for (const reply of replyList) { /* 댓글 수 만큼 반복 */
            /* 구조 분해 할당 -> reply.rno, reply.Text 등의 여러 변수를 한번에 변수로 만들 수 있음 (추출) */
            const {rno, replyText, replyer} = reply
            str += `<li class="list-group-item d-flex justify-content-between align-items-center">
            \${rno} --- \${replyText}
            <span class="badge badge-primary badge-pill">\${replyer}</span>
        </li>`
        }
        replyUL.innerHTML = str

        // ---------------------------- 댓글 페이지 번호 출력
        // pageDTO 안에 있는 필요한 값 추출 -> startPage, endPage, prev, next
        const {startPage, endPage, prev, next} = pageDTO
        const pageNum = pageDTO.cri.pageNum
        let pageStr = '' // HTML 문을 담기 위한 변수

        // Prev
        if (prev) {
            pageStr +=
                `<li class="page-item">
            <a class="page-link" href="\${startPage-1}" tabindex="-1">Previous</a>
        </li>`
        }

        for (let i = startPage; i <= endPage; i++) { // 반복문을 돌며 li, a 태그 넣을것
            <!-- active 대신 삼항연산자 사용, 위에 있는 pageNum 사용 (cri 안에도 있음) -->
            pageStr += `<li class="page-item \${i == pageNum? 'active' : ''}">
                <a class="page-link" href="\${i}">\${i}</a>
            </li>`;
        }

        // Next
        if (next) {
            pageStr +=
                `<li class="page-item">
            <a class="page-link" href="\${endPage + 1}" tabindex="-1">Next</a>
        </li>`
        }
        pageUL.innerHTML = pageStr
    }

    pageUL.addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()
        const target = e.target
        const pageNum = target.getAttribute("href")
        // console.log(pageNum)

        getList(pageNum) // amount 값 안주면 기본 10
    }, false);

    getList() // 호출 시 파라미터가 없으므로 pageNum, amount 를 받음, 파라미터 하나만 던지면 1번 파라미터 pageNum 에 할당
</script>

<%@include file="../includes/end.jsp" %>
