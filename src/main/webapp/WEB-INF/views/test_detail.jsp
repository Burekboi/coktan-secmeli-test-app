<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<layout:layout pageTitle="Test Detayı – ${test.name}">
    <c:choose>
        <c:when test="${empty test}">
            <div class="alert alert-danger">Aradığınız test bulunamadı.</div>
        </c:when>
        <c:otherwise>
            <!-- Başlık ve İşlemler -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>${test.name}</h2>
                <div class="btn-group btn-group-sm">
                    <!-- Yeni Soru Ekle -->
                    <button type="button"
                            class="btn btn-info create-question-btn"
                            data-test-id="${test.id}">
                        Yeni Soru Ekle
                    </button>
                    <a href="${ctx}/tests/edit/${test.id}"
                       class="btn btn-warning">Testi Düzenle</a>
                    <button type="button"
                            class="btn btn-danger delete-test-btn"
                            data-delete-url="${ctx}/tests/delete/${test.id}">
                        Testi Sil
                    </button>
                </div>
            </div>

            <!-- Sorular Accordion -->
            <div class="accordion" id="questionsAccordion">
                <c:forEach var="question" items="${test.questions}" varStatus="qs">
                    <div class="accordion-item">
                        <h2 class="accordion-header d-flex justify-content-between align-items-center"
                            id="heading${question.id}">
                            <button class="accordion-button ${qs.index>0?'collapsed':''}"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${question.id}"
                                    aria-expanded="${qs.index==0}"
                                    aria-controls="collapse${question.id}">
                                Soru ${qs.index+1}: ${question.text}
                            </button>
                            <div class="btn-group btn-group-sm">
                                <button type="button"
                                        class="btn btn-outline-warning edit-question-btn"
                                        data-question-id="${question.id}"
                                        data-question-text="${fn:escapeXml(question.text)}">
                                    Düzenle
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger delete-question-btn"
                                        data-delete-url="${ctx}/questions/delete/${question.id}">
                                    Sil
                                </button>
                            </div>
                        </h2>
                        <div id="collapse${question.id}"
                             class="accordion-collapse collapse ${qs.index==0?'show':''}"
                             aria-labelledby="heading${question.id}"
                             data-bs-parent="#questionsAccordion">
                            <div class="accordion-body">
                                <ul class="list-group mb-3">
                                    <c:forEach var="choice" items="${question.choices}" varStatus="cs">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                                ${cs.index+1}. ${choice.text}
                                            <div class="btn-group btn-group-sm">
                                                <button type="button"
                                                        class="btn btn-outline-warning edit-choice-btn"
                                                        data-choice-id="${choice.id}"
                                                        data-choice-text="${fn:escapeXml(choice.text)}"
                                                        data-choice-correct="${choice.correct}">
                                                    Düzenle
                                                </button>
                                                <button type="button"
                                                        class="btn btn-outline-danger delete-choice-btn"
                                                        data-delete-url="${ctx}/choices/delete/${choice.id}">
                                                    Sil
                                                </button>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <button type="button"
                                        class="btn btn-secondary add-choice-btn"
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

    <!-- ===== Modallar ===== -->

    <!-- Test Silme Onay -->
    <div class="modal fade" id="confirmDeleteTestModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Testi Silme Onayı</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">Bu testi silmek istediğinize emin misiniz?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button class="btn btn-danger" id="confirmDeleteTestBtn">Sil</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Soru Silme Onay -->
    <div class="modal fade" id="confirmDeleteQuestionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Soruyu Silme Onayı</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">Bu soruyu silmek istediğinize emin misiniz?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button class="btn btn-danger" id="confirmDeleteQuestionBtn">Sil</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Şık Silme Onay -->
    <div class="modal fade" id="confirmDeleteChoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Şıkkı Silme Onayı</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">Bu şıkkı silmek istediğinize emin misiniz?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                    <button class="btn btn-danger" id="confirmDeleteChoiceBtn">Sil</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Soru Düzenle Modal -->
    <div class="modal fade" id="editQuestionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editQuestionForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Soru Düzenle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Soru Metni</label>
                            <input type="text" class="form-control" id="questionTextEdit" name="text" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                        <button class="btn btn-primary">Güncelle</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Şık Düzenle Modal -->
    <div class="modal fade" id="editChoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editChoiceForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Şık Düzenle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Şık Metni</label>
                            <input type="text" class="form-control" id="choiceTextEdit" name="text" required/>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="choiceCorrectEdit" name="correct"/>
                            <label class="form-check-label">Doğru Şık</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                        <button class="btn btn-primary">Güncelle</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Soru Oluştur Modal -->
    <div class="modal fade" id="createQuestionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="createQuestionForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Yeni Soru Ekle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Soru Metni</label>
                            <input type="text" class="form-control" id="questionTextCreate" name="text" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                        <button class="btn btn-primary">Ekle</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Şık Ekle Modal -->
    <div class="modal fade" id="addChoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="addChoiceForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Yeni Şık Ekle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Şık Metni</label>
                            <input type="text" class="form-control" id="choiceTextAdd" name="text" required/>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="choiceCorrectAdd" name="correct"/>
                            <label class="form-check-label">Doğru Şık</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
                        <button class="btn btn-primary">Kaydet</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const byId = id => document.getElementById(id);
            const ctx  = '${ctx}';

            // Test silme
            let testDeleteUrl;
            const testModal = new bootstrap.Modal(byId('confirmDeleteTestModal'));
            document.querySelectorAll('.delete-test-btn').forEach(b => {
                b.addEventListener('click', () => {
                    testDeleteUrl = b.getAttribute('data-delete-url');
                    testModal.show();
                });
            });
            byId('confirmDeleteTestBtn').addEventListener('click', () => {
                if (testDeleteUrl) location.href = testDeleteUrl;
            });

            // Soru silme
            let questionDeleteUrl;
            const qModal = new bootstrap.Modal(byId('confirmDeleteQuestionModal'));
            document.querySelectorAll('.delete-question-btn').forEach(b => {
                b.addEventListener('click', () => {
                    questionDeleteUrl = b.getAttribute('data-delete-url');
                    qModal.show();
                });
            });
            byId('confirmDeleteQuestionBtn').addEventListener('click', () => {
                if (questionDeleteUrl) location.href = questionDeleteUrl;
            });

            // Şık silme
            let choiceDeleteUrl;
            const cDelModal = new bootstrap.Modal(byId('confirmDeleteChoiceModal'));
            document.querySelectorAll('.delete-choice-btn').forEach(b => {
                b.addEventListener('click', () => {
                    choiceDeleteUrl = b.getAttribute('data-delete-url');
                    cDelModal.show();
                });
            });
            byId('confirmDeleteChoiceBtn').addEventListener('click', () => {
                if (choiceDeleteUrl) location.href = choiceDeleteUrl;
            });

            // Soru düzenleme
            const qEditModal = new bootstrap.Modal(byId('editQuestionModal'));
            const qForm     = byId('editQuestionForm');
            document.querySelectorAll('.edit-question-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const id  = b.getAttribute('data-question-id');
                    const txt = b.getAttribute('data-question-text');
                    qForm.setAttribute('action', ctx + '/questions/edit/' + id);
                    byId('questionTextEdit').value = txt;
                    qEditModal.show();
                });
            });

            // Şık düzenleme
            const cEditModal = new bootstrap.Modal(byId('editChoiceModal'));
            const cForm      = byId('editChoiceForm');
            document.querySelectorAll('.edit-choice-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const id   = b.getAttribute('data-choice-id');
                    const txt  = b.getAttribute('data-choice-text');
                    const corr = b.getAttribute('data-choice-correct') === 'true';
                    cForm.setAttribute('action', ctx + '/choices/edit/' + id);
                    byId('choiceTextEdit').value      = txt;
                    byId('choiceCorrectEdit').checked = corr;
                    cEditModal.show();
                });
            });

            // Şık ekleme
            const addModal = new bootstrap.Modal(byId('addChoiceModal'));
            const addForm  = byId('addChoiceForm');
            document.querySelectorAll('.add-choice-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const qid = b.getAttribute('data-question-id');
                    addForm.setAttribute('action', ctx + '/choices/create/' + qid);
                    addModal.show();
                });
            });

            // Soru oluşturma
            const createModal = new bootstrap.Modal(byId('createQuestionModal'));
            const createForm  = byId('createQuestionForm');
            document.querySelectorAll('.create-question-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const tid = b.getAttribute('data-test-id');
                    createForm.setAttribute('action', ctx + '/questions/create/' + tid);
                    createModal.show();
                });
            });
        });
    </script>
</layout:layout>
