
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

    <%-- 버튼 밑에 AttachVO 보일 수 있도록 --%>
    <div class="attachList d-flex">
        <c:if test="${vo.attachVOList != null && vo.attachVOList.size() > 0}">
            <c:forEach items="${vo.attachVOList}" var="attach">
                <c:if test="${attach.ano != null}">
                    <div>
                            <%-- ${attach.fullName} &lt;%&ndash;AttachVo 에서 getFullName 만들고 MyBatis 가 자동으로 변수이름 가져옴 -> 이미지 태그가 들어가는것으로 변경 --%>
                        <a href="/files/${attach.fullName}" target="_blank">
                            <img src="/files/s_${attach.fullName}"/> <%-- 이미지 소스 앞에 s_ 넣어 섬네일 불러오기--%>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
</div>

<%-- 댓글 페이지 구현 & 카드 div 로 묶기--%>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <button class="btn btn-info addReplyBtn">Add Reply</button>
    </div>
    <div class="card-body">
        <div>
            <ul class="list-group replyList">
                <%-- li 하나씩이 각각의 댓글, li 를 탬플릿처럼 사용해보기 --%>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Cras justo odio
                    <span class="badge badge-primary badge-pill">14</span>
                </li>
            </ul>
        </div>
        <%-- 댓글 페이지 리스트 번호 --%>
        <div class="mt-3">
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
    </div>
</div>
<%-- 댓글 등록용 MODAL 창 추가--%>
<div class="modal" id="replyModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal Title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">x</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="input-group input-group-lg">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Reply Text</span>
                    </div>
                    <input type="text" name="replyText" class="form-control">
                </div>
                <div class="input-group input-group-sm">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Replyer</span>
                    </div>
                    <input type="text" name="replyer" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <button id="replyModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="replyDelBtn" type="button" class="btn btn-danger">Delete</button>
                <button id="replyRegBtn" type="button" class="btn btn-primary">Register</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<form id="actionForm" method="get" action="/board/list">
    <%--cri 의 pageNum, amount 2개만 가지고 있음--%>
    <input type="hidden" name="pageNum" value="${cri.pageNum}"> <%-- 몇 페이지 리스트 인지 --%>
    <input type="hidden" name="amount" value="${cri.amount}"> <%-- 몇개 씩 보여주는지--%>
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

    // 버튼을 눌렀을 때 작동하도록 Ajax 작업, 파라미터는 객체로 받기
    const registerReply = async (replyObj) => {
        const res = await axios.post('/reply/register', replyObj);
        const data = res.data; // 하위 데이터 RNO, COUNT 의 대소문자 주의!
        /* data.COUNT 를 이용해서 마지막 페이지를 구하기
        * 페이지당 10개를 출력하는 경우 -> 10.0 으로 나누어서 ceil 하기*/
        const lastPage = Math.ceil(data.COUNT / 10.0);
        /* 새로운 댓글의 위치를 모르므로 Ajax 통신을 한번 더 함 -> getList 한번 더 호출 -> 다시 댓글을 가져옴*/
        getList(lastPage)
    };

    const printReplyList = (pageDTO, replyList) => {
        replyUL.innerHTML = ""

        let str = ''

        for (const reply of replyList) { /* 댓글 수 만큼 반복 */
            /* 구조 분해 할당 -> reply.rno, reply.Text 등의 여러 변수를 한번에 변수로 만들 수 있음 (추출) */
            const {rno, replyText, replyer} = reply
            str += `<li data-rno="\${rno}" class="list-group-item d-flex justify-content-between align-items-center">
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
        console.log(pageNum)
        getList(pageNum)
        currentPage = pageNum
        getList(pageNum) // amount 값 안주면 기본 10
    }, false);

    // 현재 댓글 페이지
    let currentPage = 1
    let currentRno = 0

    /*Ajax 때문에 나중에 들고오는 데이터에 이벤트를 걸 수 없으므로 printReplyList 가 아니라 상위인 replyUL 에 이벤트 걸기 */
    replyUL.addEventListener("click", e => {
        e.stopPropagation()
        const target = e.target;
        // console.log(target)
        // console.log("rno : " + rno)
        // console.log("currentPage" + currentPage)
        currentRno = target.getAttribute("data-rno") // li 클래스에 넣은 data-rno="\${rno} 추출

        // async 함수를 호출하는 곳에서는 항상 Promise 타입을 받음 -> then 으로 처리하기
        // result 라는 변수가 댓글이 됨
        getReply(currentRno).then(result => {
            replyTextInput.value = result.replyText
            replyerInput.value = result.replyer
            replyAddModal.show()
        });
    }, false);

    getList() // 호출 시 파라미터가 없으므로 pageNum, amount 를 받음, 파라미터 하나만 던지면 1번 파라미터 pageNum 에 할당

    // Modal 이용하기 위해 bootstrap.Modal 사용
    const replyAddModal = new bootstrap.Modal(document.querySelector('#replyModal'));
    // Modal HTML 안의 input 타입으로 선언된 'replyText, replyer 를 사용하기 위해 상수로 선언
    const replyTextInput = document.querySelector("input[name='replyText']");
    const replyerInput = document.querySelector("input[name='replyer']");

    // ReplyController 에서 댓글을 조회할 때 Ajax 로 만들어지는 데이터 구현
    const getReply = async (rno) => {
        const res = await axios.get(`/reply/\${rno}`)
        // console.log(res)

        return res.data
    }

    // replyAddModal.show()

    // Axios 통신 정의
    const deleteReply = async (rno) => {
        const res = await axios.delete(`/reply/\${rno}`)
        return res.data // 삭제가 되었다고 출력 -> {Result DELETE:true}
    }

    const modifyReply = async (replyObj) => {
        const res = await axios.put(`/reply/\${currentRno}`, replyObj)
        return res.data
    };

    // replyRegBtn id 에 이벤트 추가
    document.querySelector("#replyRegBtn").addEventListener("click", e => {
        e.preventDefault()
        e.stopPropagation()

        const replyObj = {
            replyText: replyTextInput.value,
            replyer: replyerInput.value,
            bno: boardBno
        }
        registerReply(replyObj).then(result => {
            replyAddModal.hide()
            replyTextInput.value = ''
            replyerInput.value = ''
        });

    }, false);

    // 삭제용 버튼

    // Modal 창 삭제 버튼 -> 댓글 1페이지로 가야 함 (Axios 통신, deleteReply 비동기 함수로 따로 뺄것)
    document.querySelector("#replyDelBtn").addEventListener("click", e => {
        var i = currentRno
        deleteReply(currentRno).then(result => { // 현재 rno 를 삭제, then -> 성공했다면
            alert(i + '번 댓글이 삭제되었습니다')
            replyAddModal.hide() // 삭제 되면 Modal 창 가리기
            getList() // 파라미터 없으면 1페이지 호출!
        }, false);
    })


    document.querySelector("#replyModBtn").addEventListener("click", e => {
        // modifyReply 에서 사용할 replyObj 정의
        const replyObj = {
            replyText: replyTextInput.value,
            replyer: replyerInput.value,
            bno: boardBno
        }

        modifyReply(replyObj).then(result => {
            alert("댓글이 수정되었습니다.")
            replyAddModal.hide()
            getList(currentPage) // 수정이 되고 원래 페이지를 유지하기 위해 currentPage 파라미터!
        });
    }, false);

    document.querySelector(".addReplyBtn").addEventListener("click", e => {
        replyAddModal.show()
    }, false);
</script>

<%@include file="../includes/end.jsp" %>
