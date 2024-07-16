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

<form id="actionForm" method="get" action="/board/list">
    // cri 의 pageNum, amount 2개만 가지고 있음
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
    // 이후에 actionForm 태그를 가진 상태로 list 를 클릭하면 actionForm 이 submit 되며 목록으로 가더라도 검색조건 유지
</form>

<%@include file="../includes/footer.jsp" %>

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

<%@include file="../includes/end.jsp" %>
