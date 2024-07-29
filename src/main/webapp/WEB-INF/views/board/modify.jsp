<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp" %>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Modify</h1>
<p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
    For more information about DataTables, please visit the <a target="_blank"
                                                               href="https://datatables.net">official DataTables
        documentation</a>.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Board Modify</h6>
    </div>
    <div class="card-body">
        <form id="actionForm" action="/board/modify" method="post" enctype="multipart/form-data">
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">Bno</span>
                </div>
                <input type="text" name="bno" class="form-control" value="<c:out value="${vo.bno}"/>"
                       readonly> <%-- 조회를 위해 ReadOnly, 출력을 위해서는 c:out 사용--%>
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">Title</span>
                </div>
                <input type="text" name="title" class="form-control" value="<c:out value="${vo.title}"/>">
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">Content</span>
                </div>
                <input type="text" name="content" class="form-control" value="<c:out value="${vo.content}"/>">
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">Writer</span>
                </div>
                <input type="text" class="form-control" value="<c:out value="${vo.writer}"/>" readonly>
            </div>
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">RegDate</span>
                </div>
                <input type="text" class="form-control" value="<c:out value="${vo.regDate}"/>" readonly>
            </div>
            <%-- 파일 추가하는 작업 --%>
            <div class="form-group input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text">Files</span>
                </div>
                <input type="file" name="files" class="form-control" multiple>
            </div>

            <div class="input-group input-group-lg">
                <%-- 버튼에는 스크립트를 통해 이벤트를 걸어줄 것임 --%>
                <button type="submit" class="btn btn-info btnList">LIST</button>
                <button type="submit" class="btn btn-warning btnModify">MODIFY</button>
                <button type="submit" class="btn btn-danger btnRemove">REMOVE</button>
            </div>

            <div class="deleteImages">
            </div>
        </form>
    </div>
</div>

<div class="card">
    <%-- 버튼 밑에 AttachVO 보일 수 있도록 read.jsp 에서 가져오기 --%>
    <div class="attachList d-flex">
        <c:if test="${vo.attachVOList != null && vo.attachVOList.size() > 0}">
            <c:forEach items="${vo.attachVOList}" var="attach">
                <c:if test="${attach.ano != null}">
                    <div class="d-flex flex-column m-1">
                        <img src="/files/s_${attach.fullName}"/>
                        <button class="btn btn-danger removeImgBtn"
                                data-ano="${attach.ano}"
                                data-fullname="${attach.fullName}"
                        >X
                        </button>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</div>

<%-- modify 는 수정할 때 board/list 로 가는 액션이 있는 곳을 찾아 수정 --%>
<form id="listForm" action="/board/list">
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
    <%-- 이후에 actionForm 태그를 가진 상태로 list 를 클릭하면 actionForm 이 submit 되며 목록으로 가더라도 검색조건 유지 --%>
</form>

<%@include file="../includes/footer.jsp" %>

<script>

    const bno = '${vo.bno}' // bno 값을 JS 변수로 받기
    const actionForm = document.querySelector("#actionForm")
    const listForm = document.querySelector("#listForm")

    document.querySelector(".btnList").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        listForm.submit()
    }, false); /*버블링 핸들러 false*/

    document.querySelector(".btnModify").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        actionForm.action = `/board/modify/\${bno}`
        actionForm.method = 'post'
        /* 책에서는 modify 후에 검색조건을 유지하려고 했으나 여기선 제목이 수정되었을 때 일반 조회로 가도록 해봄
        * RedirectAttribute.addFlashAttribute 사용해서 */
        actionForm.submit()
    }, false); /*버블링 핸들러 false*/

    document.querySelector(".btnRemove").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        // 삭제해야하는 파일들을 hidden 태그로 만들기 (modify 처럼)
        const fileArr = document.querySelectorAll(".attachList button"); // attachList 하위 버튼 모두

        console.log(fileArr)

        if (fileArr && fileArr.length > 0) {
            let str = ''
            for (const btn of fileArr) {
                const ano = btn.getAttribute("data-ano");
                const fullName = btn.getAttribute("data-fullname"); // 대소문자 조심

                str += `<input type="hidden" name='anos' value='\${ano}'>`
                str += `<input type="hidden" name='fullNames' value='\${fullName}'>`
            } // end FOR
            document.querySelector(".deleteImages").innerHTML += str
        } // end IF

        actionForm.action = `/board/remove/\${bno}`;
        actionForm.method = 'post'
        actionForm.submit()
    }, false); /*버블링 핸들러 false*/

    document.querySelector(".attachList").addEventListener("click", e => {
        const target = e.target // 타겟은 클릭한 요소!! 즉 버튼
        /* 태그 이름이 BUTTON 이어야만 함, 버튼이 아니라면 끝내야 함 (지금은 button 이므로 동작) */
        if (target.tagName !== 'BUTTON') {
            return
        }

        const ano = target.getAttribute("data-ano");
        const fullName = target.getAttribute("data-fullname"); // 대소문자 조심

        // console.log("ano : ", ano, "fullName : ", fullName)

        if (ano && fullName) {
            let str = '' // hidden 태그 작성용 문자열
            str += `<input type="hidden" name='anos' value='\${ano}'>`
            str += `<input type="hidden" name='fullNames' value='\${fullName}'>`

            console.log("ano : ", ano, "fullName : ", fullName)
            target.closest("div").remove();

            document.querySelector(".deleteImages").innerHTML += str // 이미지 삭제를 누르면 hidden 태그 2개가 생김
        }


    }, false);
</script>

<%@include file="../includes/end.jsp" %>