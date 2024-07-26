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
        <div>
            <select name="typeSelect">
                <option value="" }>--</option>
                <option value="T" ${cri.typeStr == 'T' ? 'selected' : '' }>제목</option>
                <option value="C" ${cri.typeStr == 'C' ? 'selected' : '' }>내용</option>
                <option value="W" ${cri.typeStr == 'W' ? 'selected' : '' }>작성자</option>
                <option value="TC"${cri.typeStr == 'TC' ? 'selected' : '' }>제목 OR 내용</option>
                <option value="TW" ${cri.typeStr == 'TW' ? 'selected' : '' }>제목 OR 작성자</option>
                <option value="TCW" ${cri.typeStr == 'TCW' ? 'selected' : '' }>제목 OR 내용 OR 작성자</option>
            </select>
            <input type="text" name="keywordInput" value="<c:out value="${cri.keyword}"/>">
            <%-- searchBtn 을 클릭 했을 때 typeSelect 안의 선택된 값을 알아야 함--%>
            <button class="btn btn-default searchBtn">Search</button>
        </div>

        <%--<div>
            <select name="typeSelect">
               <option value="" ${cri.checkValue("") ? 'selected': '' } >--</option>
                <option value="T" ${cri.checkValue("") ? 'selected': '' } >제목</option>
                <option value="C" ${cri.checkValue("") ? 'selected': '' } >내용</option>
                <option value="W" ${cri.checkValue("") ? 'selected': '' } >작성자</option>
                <option value="TC" ${cri.checkValue("") ? 'selected': '' } >제목 OR 내용</option>
                <option value="TW" ${cri.typeStr == 'TW' ? 'selected' : '' } >제목 OR 작성자</option>
                <option value="TCW" ${cri.checkValue("") ? 'selected': '' } >제목 OR 내용 OR 작성자</option>
            </select>
            <input type="text" name="keywordInput"/>
           <button class="btn btn-default searchBtn">Search</button>
    </div>--%>

        <div class="table-responsive">
            <%-- actionForm 을 클릭하면 get 방식으로 아래의 pageNum, amount 를 가지고 /board/list 로 이동하는데
            이 때도 검색 조건 (cri 에서 넘어오는 동적인 값) 을 유지하면서 이동할 수 있도록 설정 --%>
            <form id="actionForm" method="get" action="/board/list">
                <input type="hidden" name="pageNum" value="${cri.pageNum}">
                <input type="hidden" name="amount" value="${cri.amount}">
                <%-- 히든 타입으로 검색 type 이 넘어올 수 있도록--%>
                <c:if test="${cri.types != null && cri.keyword != null}">
                    <%-- 키워드는 2개 이상이 들어갈 수 있으므로, 배열로 만들기도 위해 forEach 사용--%>
                    <c:forEach var="type" items="${cri.types}">
                        <input type="hidden" name="types" value="${type}">
                    </c:forEach>
                    <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
                </c:if>
            </form>

            <%-- ${pageMaker} --%><%-- 테스트용 --%>
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

    const actionForm = document.querySelector("#actionForm"); /* id 를 썼기 때문에 # 사용 */

    /* .tbody 를 클릭하면 tr 을 찾아 dataset 에서 bno 를 찾아 window.location 으로 이동하도록
    * 검색 조건이 늘어날 수록 코드가 지저분해지는 단점이 생김 -> form 태그를 사용하는것이 깔끔함 */
    document.querySelector('.tbody').addEventListener("click", (e) => {

        const target = e.target.closest("tr") /* 클릭했을 때 가장 가까운 상위를 찾는다 (여기서는 TD 를 클릭하고 TR 을 찾음) */
        const bno = target.dataset.bno

        const before = document.querySelector("#clonedActionForm")

        if (before) {
            before.remove()
        }

        const clonedActionForm = actionForm.cloneNode(true); /* actionForm 을 복사함 */
        clonedActionForm.setAttribute("action", `/board/read/\${bno}`) /* pageNum 도 따라서 붙어 이동해야함 */
        /* 원래 있는 actionForm 을 수정할 경우 뒤로 갔을 때 예전의 데이터를 유지할 수 있음 */
        clonedActionForm.setAttribute("id", `clonedActionForm`)

        document.body.append(clonedActionForm)

        clonedActionForm.submit()


        /*window.location = `/board/read/\${bno}`*/ /* 백틱을 쓰면 문자열을 탬플릿처럼 사용 가능 */
    }, false)

    // 문서의 쿼리 중 ".pagination" 클래스를 찾아 원래 존재하는것 바깥쪽에 "click" 이벤트를 걸고 event 를 파라미터로 받아 function 주기
    document.querySelector(".pagination").addEventListener("click", (e) => {

        e.preventDefault() // 이벤트에 걸린 기본동작 막기
        const target = e.target // 이벤트의 target 확인
        console.log(target)

        const targetPage = target.getAttribute("href") // target 에 prev, 현재, next 의 참조값을 가져옴 -> 숫자 값이기 때문에 변수 처리(const)
        console.log(targetPage)

        actionForm.setAttribute("action", "/board/list")
        /* name 이 pageNum 인 인풋 태그를 찾아서 targetPage 라는 밸류로 설정 */
        actionForm.querySelector("input[name='pageNum']").value = targetPage
        actionForm.submit()
        /*window.location = `/board/list?pageNum=\${targetPage}`*/
    }, false);

    // querySelector 에서 "." 이 빠지면 searchBtn 클래스 못찾음!!!
    document.querySelector(".searchBtn").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const selectObj = document.querySelector("select[name='typeSelect']");

        const selectValue = selectObj.options[selectObj.selectedIndex].value;

        console.log("selectValue----------------")
        console.log(selectValue) // T, C, TCW 등

        const arr = selectValue.split(""); // 글자 쪼개기

        console.log(arr)

        // actionForm 에 hidden 태그로 만들어서 검색 조건 추가
        // 페이지 번호는 1페이지로
        // amount 도 새로 구해야 함

        let str = ''

        str = `<input type='hidden' name='pageNum' value=1>` // 검색을 하면 무조건 1페이지로
        str += `<input type='hidden' name='amount' value=${cri.amount}>` // Criteria 안의 amount 값 쓰기 (amount 는 검색 조건이 아님!)

        if (arr && arr.length > 0) { // 만약 배열이 있다면
            for (const type of arr) {
                str += `<input type='hidden' name='types' value=\${type}>` // types 태그 만들기
            }
        }
        const keywordValue = document.querySelector("input[name='keywordInput']").value
        str += `<input type='hidden' name='keyword' value='\${keywordValue}'>`
        // 원래 actionForm 에 있던 내용을 새로운 input 태그 str 로 교체하기
        actionForm.innerHTML = str

        // console.log(str)
        actionForm.submit()

    }, false);
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