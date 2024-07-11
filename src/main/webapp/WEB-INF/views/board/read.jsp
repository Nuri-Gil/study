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
            <input type="text" class="form-control" value="<c:out value="${vo.bno}"/>" readonly> <%-- 조회를 위해 ReadOnly, 출력을 위해서는 c:out 사용--%>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Title</span>
            </div>
            <input type="text" name="title" class="form-control" value="<c:out value="${vo.title}"/>"readonly>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Content</span>
            </div>
            <input type="text" name="content" class="form-control" value="<c:out value="${vo.content}"/>"readonly>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">Writer</span>
            </div>
            <input type="text" name="writer" class="form-control" value="<c:out value="${vo.writer}"/>"readonly>
        </div>
        <div class="input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text">RegDate</span>
            </div>
            <input type="text" name="regDate" class="form-control" value="<c:out value="${vo.regDate}"/>"readonly>
        </div>
        <div class="input-group input-group-lg">
            <%-- 버튼에는 스크립트를 통해 이벤트를 걸어줄 것임 --%>
            <button type="submit" class="btn btn-info btnList">LIST</button>
            <button type="submit" class="btn btn-warning btnModify">MODIFY</button>
        </div>
    </div>
</div>


<%@include file="../includes/footer.jsp" %>

<script>

    document.querySelector(".btnList").addEventListener("click", (e) => {
        window.location = "/board/list"
    }, false); /*버블링 핸들러 false*/
    document.querySelector(".btnModify").addEventListener("click", (e) => {
        window.location = "/board/modify/${vo.bno}"
    }, false); /*버블링 핸들러 false*/

</script>

<%@include file="../includes/end.jsp" %>
