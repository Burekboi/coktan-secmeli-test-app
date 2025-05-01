<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:layout pageTitle="Test Detayı - ${test.name}">
    <c:choose>
        <c:when test="${empty test}">
            <div class="alert alert-danger">Aradığınız test bulunamadı.</div>
        </c:when>
        <c:otherwise>
            <!-- Başlık ve İşlemler -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>${test.name}</h2>
                <div>
                    <a href="<c:url value='/tests/edit/${test.id}'/>"
                       class="btn btn-sm btn-warning">Testi Düzenle</a>
                    <button type="button"
                            class="btn btn-sm btn-danger delete-test-btn"
                            data-delete-url="<c:url value='/tests/delete/${test.id}'/>">
                        Testi Sil
                    </button>
                    <a href="<c:url value='/questions/create?testId=${test.id}'/>"
                       class="btn btn-sm btn-info">Yeni Soru Ekle</a>
                </div>
            </div>

            <!-- Sorular Akordeon -->
            <div class="accordion" id="questionsAccordion">
                <c:forEach var="question" items="${test.questions}" varStatus="qs">
                    <div class="accordion-item">
                        <h2 class="accordion-header d-flex justify-content-between align-items-center"
                            id="heading${question.id}">
                            <button class="accordion-button ${qs.index > 0 ? 'collapsed' : ''}"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${question.id}"
                                    aria-expanded="${qs.index == 0}"
                                    aria-controls="collapse${question.id}">
                                Soru ${qs.index + 1}: ${question.text}
                            </button>
                            <div class="btn-group btn-group-sm me-2">
                                <button type="button"
                                        class="btn btn-outline-warning edit-question-btn"
                                        data-question-id="${question.id}"
                                        data-question-text="${fn:escapeXml(question.text)}">
                                    Düzenle
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger delete-question-btn"
                                        data-delete-url="<c:url value='/questions/delete/${question.id}'/>">
                                    Sil
                                </button>
                            </div>
                        </h2>
                        <div id="collapse${question.id}"
                             class="accordion-collapse collapse ${qs.index == 0 ? 'show' : ''}"
                             aria-labelledby="heading${question.id}"
                             data-bs-parent="#questionsAccordion">
                            <div class="accordion-body">
                                <ul class="list-group mb-3">
                                    <c:forEach var="choice" items="${question.choices}" varStatus="cs">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                                ${cs.index + 1}. ${choice.text}
                                            <span>
                        <a href="<c:url value='/choices/edit/${choice.id}'/>"
                           class="btn btn-sm btn-outline-warning me-1">Düzenle</a>
                        <a href="<c:url value='/choices/delete/${choice.id}'/>"
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Bu şıkkı silmek istediğinize emin misiniz?');">
                          Sil
                        </a>
                      </span>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <button type="button"
                                        class="btn btn-sm btn-secondary add-choice-btn"
                                        data-question-id="${question.id}">
                                    Şık Ekle
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Test Silme Modal -->
    <div class="modal fade" id="confirmDeleteTestModal" tabindex="-1"
         aria-labelledby="confirmDeleteTestLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteTestLabel">Testi Silme Onayı</h5>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Bu testi silmek istediğinize emin misiniz?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-danger"
                            id="confirmDeleteTestBtn">Sil</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Soru Silme Modal -->
    <div class="modal fade" id="confirmDeleteQuestionModal" tabindex="-1"
         aria-labelledby="confirmDeleteQuestionLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteQuestionLabel">Soruyu Silme Onayı</h5>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Bu soruyu silmek istediğinize emin misiniz?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">İptal</button>
                    <button type="button" class="btn btn-danger"
                            id="confirmDeleteQuestionBtn">Sil</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Soru Düzenleme Modal -->
    <div class="modal fade" id="editQuestionModal" tabindex="-1"
         aria-labelledby="editQuestionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editQuestionForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editQuestionLabel">Soru Düzenle</h5>
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
                        <button type="submit" class="btn btn-primary">Güncelle</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Şık Ekle Modal (mevcut kodunuz) -->
    <div class="modal fade" id="addChoiceModal" tabindex="-1"
         aria-labelledby="addChoiceLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="addChoiceForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addChoiceLabel">Yeni Şık Ekle</h5>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="choiceText" class="form-label">Şık Metni</label>
                            <input type="text" class="form-control"
                                   id="choiceText" name="text" required/>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input"
                                   id="isCorrect" name="isCorrect"/>
                            <label class="form-check-label" for="isCorrect">Doğru Şık</label>
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Test silme
            let testDeleteUrl;
            const testModal = new bootstrap.Modal(
                document.getElementById('confirmDeleteTestModal')
            );
            document.querySelectorAll('.delete-test-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    testDeleteUrl = btn.dataset.deleteUrl;
                    testModal.show();
                });
            });
            document.getElementById('confirmDeleteTestBtn')
                .addEventListener('click', () => {
                    if (testDeleteUrl) window.location.href = testDeleteUrl;
                });

            // Soru silme
            let questionDeleteUrl;
            const questionModal = new bootstrap.Modal(
                document.getElementById('confirmDeleteQuestionModal')
            );
            document.querySelectorAll('.delete-question-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    questionDeleteUrl = btn.dataset.deleteUrl;
                    questionModal.show();
                });
            });
            document.getElementById('confirmDeleteQuestionBtn')
                .addEventListener('click', () => {
                    if (questionDeleteUrl) window.location.href = questionDeleteUrl;
                });

            // Soru düzenleme
            const editModal = new bootstrap.Modal(
                document.getElementById('editQuestionModal')
            );
            const editForm = document.getElementById('editQuestionForm');
            const qTextInput = document.getElementById('questionText');
            document.querySelectorAll('.edit-question-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const id   = btn.dataset.questionId;
                    const text = btn.dataset.questionText;
                    editForm.action    = '<c:url value="/questions/edit/" />' + id;
                    qTextInput.value   = text;
                    editModal.show();
                });
            });

            // Şık ekleme
            const addModal = new bootstrap.Modal(
                document.getElementById('addChoiceModal')
            );
            const addForm  = document.getElementById('addChoiceForm');
            const cText    = document.getElementById('choiceText');
            const cCheck   = document.getElementById('isCorrect');
            document.querySelectorAll('.add-choice-btn').forEach(btn => {
                btn.addEventListener('click', () => {
                    const qId = btn.dataset.questionId;
                    addForm.action = '<c:url value="/choices/create"/>' + '?questionId=' + qId;
                    cText.value    = '';
                    cCheck.checked = false;
                    addModal.show();
                });
            });
        });
    </script>
</layout:layout>
