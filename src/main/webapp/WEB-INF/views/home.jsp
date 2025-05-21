<%@ page    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<fmt:setLocale value="${param.lang == 'en' ? 'en' : 'tr'}" scope="session"/>
<fmt:setBundle basename="messages" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<fmt:setLocale value="${param.lang == 'en' ? 'en' : 'tr'}" scope="session"/>
<fmt:setBundle basename="messages"/>

<layout:layout pageTitle="Home">
    <c:choose>
        <c:when test="${isAdmin}">
            <script>
                const profile_section_on_navbar = document.getElementById("profile_navbar");
                const menu_divider = document.getElementById("menu-divider");
                const test_coz = document.getElementById("test-coz");
                profile_section_on_navbar.style.display = "none";
                menu_divider.style.display = "none";
                test_coz.style.display = "none";

            </script>
            <script>
                document.getElementById('confirmDeleteBtn')
                .addEventListener('click', () => {
                console.log("Silme URL'si:", deleteUrl); // 💥 bu satırı ekle
                if (deleteUrl) window.location.href = deleteUrl;
                });
            </script>
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h4 class="mb-0"><fmt:message key="header.testManagement"/></h4>
                            <button type="button"
                                    class="btn btn-light btn-sm edit-test-btn"
                                    data-test-id=""
                                    data-test-name=""
                                    id="newTestBtn">
                                <fmt:message key="button.newTest"/>
                            </button>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th><fmt:message key="header.testName"/></th>
                                    <th><fmt:message key="header.actions"/></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="test" items="${tests}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${test.name}</td>
                                        <td>
                                            <button type="button"
                                                    class="btn btn-sm btn-warning edit-test-btn"
                                                    data-test-id="${test.id}"
                                                    data-test-name="${test.name}">
                                                <fmt:message key="button.edit"/>
                                            </button>
                                            <button
                                               class="btn btn-sm btn-danger delete-test-btn"
                                               data-delete-url="${ctx}/tests/delete/${test.id}">
                                                <fmt:message key="button.delete"/>
                                            </button>
                                            <button type="button"
                                                    class="btn btn-sm btn-info create-question-btn"
                                                    data-test-id="${test.id}">
                                                <fmt:message key="button.addQuestion"/>
                                            </button>
                                            <a href="<c:url value='/tests/detail/${test.id}'/>"
                                               class="btn btn-sm btn-info">
                                                <fmt:message key="button.details"/>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <script>
                const test_yonetimi = document.getElementById("test-yonetimi");
                test_yonetimi.style.display = "none";
            </script>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h4><fmt:message key="header.solvePanel"/></h4>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="test" items="${tests}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                            ${test.name}
                                                <button
                                                type="button"
                                                class="btn btn-sm btn-success solve-btn"
                                                data-solve-url="${ctx}/tests/solve/${test.id}">
                                            <fmt:message key="button.solveTest"/>
                                                </button>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Önceki Sonuç Modalı -->
            <div class="modal fade" id="lastResultModal" tabindex="-1" aria-labelledby="lastResultLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="lastResultLabel">
                                Bu Test daha önce çözüldü
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>doğru:</strong> <span id="prevCorrect"></span></p>
                            <p><strong>yanlış:</strong> <span id="prevIncorrect"></span></p>
                            <p>tekrar çöz</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <fmt:message key="button.cancel"/>
                            </button>
                            <button type="button" class="btn btn-success" id="confirmSolveAgainBtn">
                                Tekrar Çöz
                            </button>
                        </div>
                    </div>
                </div>
            </div>

        </c:otherwise>
    </c:choose>

    <!-- Silme Onay Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1"
         aria-labelledby="confirmDeleteLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteLabel">
                        <fmt:message key="modal.deleteTitle"/>
                    </h5>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <fmt:message key="modal.deleteMessage"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        <fmt:message key="button.cancel"/>
                    </button>
                    <button type="button" class="btn btn-danger"
                            id="confirmDeleteBtn">
                        <fmt:message key="button.delete"/>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Test Düzenle/ Oluştur Modal -->
    <div class="modal fade" id="editTestModal" tabindex="-1"
         aria-labelledby="editTestLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editTestForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editTestLabel">
                            <fmt:message key="modal.editTestTitle"/>
                        </h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="testName" class="form-label">
                                <fmt:message key="label.testName"/>
                            </label>
                            <input type="text" class="form-control"
                                   id="testName" name="name" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            <fmt:message key="button.cancel"/>
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <fmt:message key="button.save"/>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Soru Oluştur Modal -->
    <div class="modal fade" id="createQuestionModal" tabindex="-1"
         aria-labelledby="createQuestionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="createQuestionForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createQuestionLabel">
                            <fmt:message key="modal.newQuestionTitle"/>
                        </h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="questionText" class="form-label">
                                <fmt:message key="label.questionText"/>
                            </label>
                            <input type="text" class="form-control"
                                   id="questionText" name="text" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">
                            <fmt:message key="button.cancel"/>
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <fmt:message key="button.add"/>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = '${ctx}';

            // ✅ Test Silme Modalı
            let deleteUrl = null;
            const delModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            document.querySelectorAll('.delete-test-btn').forEach(btn => {
                btn.addEventListener('click', e => {
                    e.preventDefault();
                    deleteUrl = btn.getAttribute('data-delete-url');
                    delModal.show();
                });
            });
            document.getElementById('confirmDeleteBtn')?.addEventListener('click', () => {
                if (deleteUrl) window.location.href = deleteUrl;
            });

            // ✅ Test Düzenleme / Oluşturma Modalı
            const editModal = new bootstrap.Modal(document.getElementById('editTestModal'));
            const editForm = document.getElementById('editTestForm');
            const nameInput = document.getElementById('testName');
            document.querySelectorAll('.edit-test-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const id = btn.getAttribute('data-test-id');
                    const name = btn.getAttribute('data-test-name');
                    if (id && id.trim() !== '') {
                        editForm.setAttribute('action', ctx + '/tests/edit/' + id);
                        nameInput.value = name;
                    } else {
                        editForm.setAttribute('action', ctx + '/tests/create');
                        nameInput.value = '';
                    }
                    editModal.show();
                });
            });

            // ✅ Soru Oluşturma Modalı
            const createModal = new bootstrap.Modal(document.getElementById('createQuestionModal'));
            const createForm = document.getElementById('createQuestionForm');
            const qInput = document.getElementById('questionText');
            document.querySelectorAll('.create-question-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const testId = btn.getAttribute('data-test-id');
                    if (!testId || testId.trim() === '') {
                        console.error('data-test-id eksik!');
                        return;
                    }
                    createForm.setAttribute('action', ctx + '/questions/create/' + testId);
                    qInput.value = '';
                    createModal.show();
                });
            });

            // ✅ Test Çözme Öncesi Sonuç Kontrolü Modalı
            const lastResultModalEl = document.getElementById('lastResultModal');
            const lastResultModal = lastResultModalEl ? new bootstrap.Modal(lastResultModalEl) : null;
            const prevCorrectEl = document.getElementById('prevCorrect');
            const prevIncorrectEl = document.getElementById('prevIncorrect');
            const confirmSolveBtn = document.getElementById('confirmSolveAgainBtn');
            let solveRedirectUrl = null;

            document.querySelectorAll('.solve-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    console.log("tetiklendi");
                    e.preventDefault();

                    const solveUrl = btn.getAttribute('data-solve-url');
                    console.log(solveUrl);
                    const parts = solveUrl.split('/');
                    let testId = parts[parts.length - 1];
                    console.log(testId);


                    fetch(`${ctx}/tests/last-result/1`, {
                        headers: {
                            'Accept': 'application/json'
                        }
                    })
                        .then(res => res.json())
                        .then(data => {
                            if (data.solvedBefore && lastResultModal) {
                                prevCorrectEl.textContent = data.correct;
                                prevIncorrectEl.textContent = data.incorrect;
                                solveRedirectUrl = solveUrl;
                                lastResultModal.show();
                            }
                        })
                        .catch(err => {
                            console.error("Kontrol hatası:", err);

                        });
                });
            });

            confirmSolveBtn?.addEventListener('click', function() {
                if (solveRedirectUrl) {
                    window.location.href = solveRedirectUrl;
                }
            });
        });
    </script>

</layout:layout>
