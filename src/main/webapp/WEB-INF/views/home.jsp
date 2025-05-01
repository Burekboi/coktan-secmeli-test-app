<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<layout:layout pageTitle="Ana Sayfa">
    <c:choose>
        <c:when test="${isAdmin}">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Test Yönetimi</h4>
                            <button type="button"
                                    class="btn btn-light btn-sm edit-test-btn"
                                    data-test-id=""
                                    data-test-name=""
                                    id="newTestBtn">
                                Yeni Test Oluştur
                            </button>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped">
                                <thead>
                                <tr><th>#</th><th>Test Adı</th><th>İşlemler</th></tr>
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
                                                Düzenle
                                            </button>
                                            <a href="#"
                                               class="btn btn-sm btn-danger delete-test-btn"
                                               data-delete-url="${ctx}/tests/delete/${test.id}">
                                                Sil
                                            </a>
                                            <button type="button"
                                                    class="btn btn-sm btn-info create-question-btn"
                                                    data-test-id="${test.id}">
                                                Soru Ekle
                                            </button>
                                            <a href="<c:url value='/tests/detail/${test.id}'/>"
                                               class="btn btn-sm btn-info">
                                                Detaylar
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
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h4>Test Çözme Paneli</h4>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="test" items="${tests}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                            ${test.name}
                                        <a href="<c:url value='/tests/solve/${test.id}'/>"
                                           class="btn btn-sm btn-success">
                                            Testi Çöz
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
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
                    <h5 class="modal-title" id="confirmDeleteLabel">Silme Onayı</h5>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    Bu öğeyi silmek istediğinize emin misiniz?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-danger"
                            id="confirmDeleteBtn">Sil</button>
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
                        <h5 class="modal-title" id="editTestLabel">Test Düzenle</h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="testName" class="form-label">Test Adı</label>
                            <input type="text" class="form-control"
                                   id="testName" name="name" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">İptal</button>
                        <button type="submit" class="btn btn-primary">Kaydet</button>
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
                        <h5 class="modal-title" id="createQuestionLabel">Yeni Soru Ekle</h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="questionText" class="form-label">Soru Metni</label>
                            <input type="text" class="form-control"
                                   id="questionText" name="text" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">İptal</button>
                        <button type="submit" class="btn btn-primary">Ekle</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = '${ctx}';

            // Silme işlemi
            let deleteUrl = null;
            const delModal = new bootstrap.Modal(
                document.getElementById('confirmDeleteModal')
            );
            document.querySelectorAll('.delete-test-btn').forEach(btn => {
                btn.addEventListener('click', e => {
                    e.preventDefault();
                    deleteUrl = btn.getAttribute('data-delete-url');
                    delModal.show();
                });
            });
            document.getElementById('confirmDeleteBtn')
                .addEventListener('click', () => {
                    if (deleteUrl) window.location.href = deleteUrl;
                });

            // Test düzenle / oluştur
            const editModal = new bootstrap.Modal(
                document.getElementById('editTestModal')
            );
            const editForm  = document.getElementById('editTestForm');
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

            // Soru oluştur
            const createModal = new bootstrap.Modal(
                document.getElementById('createQuestionModal')
            );
            const createForm  = document.getElementById('createQuestionForm');
            const qInput      = document.getElementById('questionText');
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
        });
    </script>
</layout:layout>
